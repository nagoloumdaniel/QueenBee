terraform {
  required_version = ">= 1.9.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 6.21"
    }
  }

  # TODO(EP-00, [INFRA]): backend distant chiffré (Object Storage OCI compatible S3) pour l'état.
  # Ne jamais committer terraform.tfstate (il peut contenir des secrets).
}
