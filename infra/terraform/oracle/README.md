# infra/terraform/oracle — VM centrale Oracle Cloud

**Rôle** : provisionner de façon reproductible la VM centrale (VCN, sous-réseau, règles réseau, instance Ampere A1 ~14 Go RAM).
La configuration logicielle de la VM est faite ensuite par Ansible (`../../ansible`).

## Lancer (à faire par la personne qui a les accès OCI)

```bash
cd infra/terraform/oracle
cp example.tfvars terraform.tfvars        # adapter, ne jamais committer
export OCI_CLI_CONFIG_FILE=~/.oci/config  # ou variables TF_VAR_* / OCI_*
terraform init
terraform fmt -check && terraform validate
terraform plan -out tfplan
terraform apply tfplan
terraform output central_public_ip        # -> inventaire Ansible
```

## Epics

- **EP-00 [INFRA]** : VM Oracle, réseau, backend d'état distant, E2E : `terraform apply` + Ansible sur VM vierge -> `GET /health` 200 en TLS 1.3.
- **EP-11** : sauvegarde du volume et reprise.

## Bonnes pratiques locales

- Aucun secret dans le code ni dans `*.tfvars` committé ; état Terraform hors dépôt (backend distant).
- Analyse IaC en CI : Checkov (`.github/workflows/security.yml`).
- SSH limité à `admin_cidr` ; MQTT jamais exposé en clair sur Internet.
- Pas de `terraform apply` en production sans accord explicite et revue du plan.
