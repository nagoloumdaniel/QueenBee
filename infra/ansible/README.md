# infra/ansible — configuration des serveurs

**Rôle** : configurer le serveur central et les passerelles de site de façon reproductible (ROADMAP §1 « IaC »).
Objectif : « reconstruction en une commande » (ROADMAP §6.2).

## Structure

- `inventories/{staging,production}/hosts.yml` : hôtes (adresses de documentation à remplacer).
- `group_vars/` : `all.yml`, `central.yml`, `sites.yml`. **Aucun secret** : `ansible-vault` ou SOPS/age.
- `playbooks/` : `central.yml`, `site.yml`, `monitoring.yml`.
- `roles/` : `common`, `docker`, `wireguard`, `central`, `site`, `monitoring` (`tasks`, `handlers`, `defaults`, `templates`).
  Les tâches non écrites sont marquées `TODO(EP-xx, [ZONE])`.

## Lancer (staging)

```bash
cd infra/ansible
ansible-playbook playbooks/central.yml --check --diff   # à blanc d'abord
ansible-playbook playbooks/central.yml
ansible-playbook playbooks/site.yml --limit gw-sn-casa  # site pilote d'abord
ansible-lint                                         # lint en CI
```

## Epics

- **EP-00 [INFRA]** : socle (common, docker, wireguard, central).
- **EP-05 [EDGE]** : rôle `site` (Mosquitto + bridge, cache disque, K3s optionnel).
- **EP-10 [OBS]** : rôle `monitoring`. **EP-11** : sauvegardes et reprise.

## Bonnes pratiques locales

- Idempotence : relancer un playbook ne doit rien changer la deuxième fois.
- Déploiement progressif : staging, puis site pilote, puis sites 2..8 ; rollback testé avant tout site.
- Chaque déploiement est tracé dans la table `deployment` (KPI > 95 %).
- Jamais de `ansible-playbook` en production sans accord explicite.
