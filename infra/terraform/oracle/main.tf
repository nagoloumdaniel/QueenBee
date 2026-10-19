# Squelette Terraform : VM centrale QueenBee sur Oracle Cloud (ROADMAP §1 « IaC », EP-00).
# L'authentification OCI vient de ~/.oci/config ou des variables TF_VAR_* / OCI_* (jamais dans le code).

provider "oci" {
  region = var.region
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

# Image Ubuntu 24.04 compatible avec la forme choisie.
data "oci_core_images" "ubuntu" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"
  shape                    = var.instance_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

resource "oci_core_vcn" "main" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.name_prefix}-vcn"
  cidr_blocks    = ["10.0.0.0/16"]
  dns_label      = var.name_prefix
}

resource "oci_core_internet_gateway" "main" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id
  display_name   = "${var.name_prefix}-igw"
}

resource "oci_core_route_table" "public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id
  display_name   = "${var.name_prefix}-rt-public"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.main.id
  }
}

resource "oci_core_security_list" "central" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id
  display_name   = "${var.name_prefix}-sl-central"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  # SSH : restreint à l'administrateur.
  ingress_security_rules {
    protocol = "6" # TCP
    source   = var.admin_cidr
    tcp_options {
      min = 22
      max = 22
    }
  }

  # HTTP/HTTPS publics (Caddy : ACME + TLS 1.3).
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 80
      max = 80
    }
  }
  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = 443
      max = 443
    }
  }

  # WireGuard : tunnel site-central.
  ingress_security_rules {
    protocol = "17" # UDP
    source   = "0.0.0.0/0"
    udp_options {
      min = var.wireguard_port
      max = var.wireguard_port
    }
  }

  # TODO(EP-00, [INFRA]): MQTT TLS (8883) uniquement via le VPN, jamais exposé publiquement.
}

resource "oci_core_subnet" "public" {
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.main.id
  display_name      = "${var.name_prefix}-subnet-public"
  cidr_block        = "10.0.1.0/24"
  route_table_id    = oci_core_route_table.public.id
  security_list_ids = [oci_core_security_list.central.id]
  dns_label         = "public"
}

resource "oci_core_instance" "central" {
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  display_name        = "${var.name_prefix}-central"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.instance_ocpus
    memory_in_gbs = var.instance_memory_gb
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.ubuntu.images[0].id
    boot_volume_size_in_gbs = var.boot_volume_gb
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public.id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

  # TODO(EP-00, [INFRA]): chiffrement du volume avec clé gérée, sauvegarde du volume (EP-11),
  # volume de données séparé pour PostgreSQL, tags (projet, env).
}
