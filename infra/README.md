# infra — infrastructure et déploiement

**Rôle** : tout ce qui sert à provisionner, configurer et faire tourner QueenBee (central + 8 sites).

| Dossier | Contenu | Epic |
|---|---|---|
| `terraform/oracle/` | VM centrale Oracle Cloud (VCN, règles réseau, instance) | EP-00 |
| `ansible/` | configuration des serveurs : inventaires, playbooks, rôles (common, docker, wireguard, central, site, monitoring) | EP-00, EP-05, EP-10 |
| `compose/` | `dev.yml` (local), `central.yml`, `site.yml`, `e2e.yml` | EP-00, EP-05 |
| `caddy/` | reverse proxy Caddy (TLS 1.3, en-têtes de sécurité) | EP-00 |
| `mosquitto/` | `central.conf`, `site.conf` (bridge TLS QoS 1 documenté), `dev.conf`, exemple d'ACL | EP-05 |
| `k3s/` | variante Kubernetes optionnelle | EP-05 |

## Lancer en local

```bash
cd infra/compose
cp .env.example .env            # puis remplacer les "change-me"
docker compose -f dev.yml up -d --build
docker compose -f dev.yml ps
curl http://127.0.0.1:8000/health
docker compose -f dev.yml down -v
```

## Stack E2E

```bash
docker compose -f infra/compose/e2e.yml up -d --build --wait   # depuis la racine du dépôt
```

## Bonnes pratiques locales

- **Aucun secret dans le dépôt** : `.env` (ignoré), `ansible-vault`/SOPS, GitHub Secrets. Les `.env.example` ne contiennent que des noms et des `change-me`.
- Images **épinglées** (jamais `latest` hors dev) : vérifier les tags avec `docker pull` avant de valider, puis laisser Dependabot proposer les mises à jour.
- Analyse IaC par Checkov (CI) ; `docker compose config` doit passer avant chaque PR.
- Pas de déploiement en production sans accord explicite ; rollback testé avant tout site.
- Les ports de dev sont publiés sur `127.0.0.1` uniquement.
