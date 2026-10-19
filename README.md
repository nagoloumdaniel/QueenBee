# QueenBee

Plateforme de suivi de **ruches connectées** pour l'association **BeeAfrica** : ~400 ruches sur 8 sites dans 3 pays, ~300 apiculteurs, connectivité intermittente. Projet fil rouge (spécialité Développement logiciel, orientation DevOps).

- **App terrain hors ligne** (Flutter) : inspections, alertes, récoltes, synchronisation.
- **Dashboard web** (Next.js) pour coordinateurs, gestionnaires et administrateurs + landing publique.
- **API** (FastAPI) + **base** PostgreSQL / PostGIS / TimescaleDB + **ingestion MQTT** + **calcul acoustique en edge**.
- **Simulateur** de capteurs et de scénarios (chemin critique du projet).
- **Infra as code** (Terraform, Ansible, Docker Compose / K3s), CI/CD GitHub Actions, observabilité (Prometheus, Grafana, Loki), automatisation n8n.

Plan complet : [ROADMAP.md](ROADMAP.md) · besoin : [cahier de charge.md](cahier%20de%20charge.md) · règles d'équipe et tickets : [docs/jira/PLAYBOOK.md](docs/jira/PLAYBOOK.md).

## Prérequis
| Outil | Version | Usage |
|---|---|---|
| Git, Make | récents | workflow, commandes du projet |
| Docker + Docker Compose v2 | récents | stack locale (`make up`) |
| Node.js | >= 22.12 | `apps/web` |
| Python | 3.12 | `apps/api`, `apps/ingest`, `apps/simulator`, `apps/edge-acoustic` |
| Flutter | >= 3.27 | `apps/mobile` |
| pre-commit | récent | hooks (ruff, black, gitleaks, prettier...) |

Sous Windows : utiliser Git Bash ou WSL pour `make`.

## Démarrage en 5 commandes
```bash
git clone <url-du-depot> QueenBee && cd QueenBee
cp .env.example .env        # puis remplacer les valeurs vides par des valeurs locales (jamais committées)
make up                     # base, broker, API, ingestion, simulateur, monitoring, n8n
make seed                   # sites, coopératives, ruches et utilisateurs de démonstration
make sim                    # démarre le simulateur de capteurs (accéléré)
```
Puis le dashboard web : `cd apps/web && npm ci && npm run dev` -> http://localhost:3000.

Adresses locales (publiées sur 127.0.0.1) : API http://localhost:8000/docs · Grafana http://localhost:3001 · Prometheus :9090 · n8n :5678 · simulateur :8081. (Ports définis dans `infra/compose/dev.yml`, qui fait foi.)

Autres commandes : `make help` liste tout (`make test`, `make lint`, `make fmt`, `make e2e`, `make down`).
Installer les hooks : `pre-commit install`.

## Structure
```
queenbee/
├─ apps/
│  ├─ api/            FastAPI (app/, alembic/, tests/)
│  ├─ web/            Next.js (landing publique + dashboard privé)
│  ├─ mobile/         Flutter (lib/, test/, integration_test/)
│  ├─ ingest/         worker MQTT -> base
│  ├─ edge-acoustic/  extraction de features acoustiques (passerelle)
│  └─ simulator/      moteur de scénarios + profils humains
├─ infra/             ansible/, terraform/, compose/, k3s/, caddy/, mosquitto/
├─ db/                schéma de référence, seeds, dictionnaire
├─ n8n/               workflows exportés (.json)
├─ monitoring/        règles Prometheus, dashboards Grafana, Loki
├─ docs/              adr/, diagrams/, runbooks/, openapi.yaml, dossier/, jira/ ...
└─ .github/           workflows CI/CD, modèles de PR et d'issues
```

## Documentation
| Sujet | Lien |
|---|---|
| Décisions d'architecture | [docs/adr/](docs/adr/) |
| Diagrammes (contexte, séquences, états, déploiement, ER) | [docs/diagrams/](docs/diagrams/README.md) |
| Contrat d'API (OpenAPI 3.1) | [docs/openapi.yaml](docs/openapi.yaml) |
| Dictionnaire de données | [docs/data-dictionary.md](docs/data-dictionary.md) |
| Runbooks d'exploitation | [docs/runbooks/](docs/runbooks/README.md) |
| Accessibilité · éco-conception · sécurité · conformité | [docs/accessibility/](docs/accessibility/checklist.md) · [docs/eco-conception/](docs/eco-conception/checklist.md) · [docs/security/](docs/security/asvs-checklist.md) · [docs/compliance/](docs/compliance/grille-conformite.md) |
| Pilotage (risques, décisions, écarts, sprints, veille) | [docs/project/](docs/project/risk-register.md) |
| Dossiers professionnels Bloc 1 / Bloc 2 | [docs/dossier/](docs/dossier/README.md) |
| Contribuer | [CONTRIBUTING.md](CONTRIBUTING.md) |
| Sécurité | [SECURITY.md](SECURITY.md) |

## Règles d'or
1. Jamais de commit direct sur `main` (ni sur `phase/*`) ; une branche = un ticket = une PR.
2. Le test E2E de la tâche est écrit d'abord et tourne en CI.
3. Aucun secret dans le dépôt (`.env` ignoré, Gitleaks en pre-commit et en CI).
4. Accessibilité, états loading/erreur/vide/hors-ligne et sobriété font partie de la Definition of Done.

## Licence
Projet pédagogique INGETIS. Aucune licence open source n'est définie à ce stade (tous droits réservés tant qu'aucun fichier `LICENSE` n'existe).
