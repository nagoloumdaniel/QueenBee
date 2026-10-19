variable "region" {
  description = "Région Oracle Cloud (hébergement des données : voir ROADMAP §9.6)."
  type        = string
}

variable "compartment_ocid" {
  description = "OCID du compartiment qui contiendra les ressources QueenBee."
  type        = string
}

variable "ssh_public_key" {
  description = "Clé publique SSH de l'administrateur (jamais la clé privée)."
  type        = string
}

variable "admin_cidr" {
  description = "CIDR autorisé à joindre SSH (22). Ne pas laisser 0.0.0.0/0."
  type        = string
}

variable "instance_shape" {
  description = "Forme de la VM centrale (Ampere A1 Flex, free tier possible)."
  type        = string
  default     = "VM.Standard.A1.Flex"
}

variable "instance_ocpus" {
  description = "Nombre d'OCPU de la VM centrale."
  type        = number
  default     = 2
}

variable "instance_memory_gb" {
  description = "Mémoire de la VM centrale en Go (ROADMAP : ~14 Go)."
  type        = number
  default     = 14
}

variable "boot_volume_gb" {
  description = "Taille du volume de démarrage en Go."
  type        = number
  default     = 100
}

variable "wireguard_port" {
  description = "Port UDP WireGuard (VPN site-central)."
  type        = number
  default     = 51820
}

variable "name_prefix" {
  description = "Préfixe des noms de ressources."
  type        = string
  default     = "queenbee"
}
