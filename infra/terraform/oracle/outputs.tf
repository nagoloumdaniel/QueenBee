output "central_public_ip" {
  description = "IP publique de la VM centrale (à renseigner dans l'inventaire Ansible)."
  value       = oci_core_instance.central.public_ip
}

output "central_instance_id" {
  description = "OCID de la VM centrale."
  value       = oci_core_instance.central.id
}

output "vcn_id" {
  description = "OCID du réseau virtuel."
  value       = oci_core_vcn.main.id
}
