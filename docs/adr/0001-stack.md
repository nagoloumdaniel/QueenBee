# ADR-0001 - Stack technique de QueenBee

- **Statut** : Proposé (à valider par l'équipe en S01)
- **Date** : 2026-10-19
- **Décideurs** : LH, IG, WA
- **Zone / epic** : GOV, tous les epics

## Contexte
QueenBee doit suivre ~400 ruches connectées sur 8 sites (3 pays) avec une connectivité intermittente, ~300 apiculteurs sur appareils Android modestes, et un dashboard pour 3 autres rôles. Contraintes structurantes (cahier des charges, ROADMAP §1 et §4.4) :

- fonctionnement **hors ligne** et synchronisation d'une journée (38 400 mesures) en moins de 2 minutes ;
- PostgreSQL + PostGIS imposés ; MQTT déjà requis par les capteurs ; Prometheus + Grafana et n8n imposés ;
- équipe de 3 étudiants, ~10 h/semaine chacun : peu de composants à exploiter, outils gratuits ;
- VM centrale de 14 Go de RAM ; passerelles de site parfois très modestes ;
- sécurité (DevSecOps, Snyk), accessibilité WCAG 2.2 AA / RGAA 4.1, numérique responsable.

## Options envisagées et choix
| Couche | Choix | Raison | Alternative écartée |
|---|---|---|---|
| App terrain | **Flutter** + Drift (SQLite) + Riverpod | Offline-first natif, un code Android/iOS, bon sur appareils bas de gamme, QR/caméra matures, compétence Flutter déjà présente | React Native : bridge plus lourd, sync offline moins standard |
| Dashboard web | **Next.js 15 (App Router) + TypeScript + Tailwind + shadcn/ui** | Démontre C2.3, SSR/SSG utile pour la landing (SEO), composants accessibles (Radix) | Vue/Angular : pas de gain |
| API | **FastAPI (Python 3.12) + Pydantic v2 + SQLAlchemy 2 + Alembic** | Même langage que Data (ML, ETL), OpenAPI automatique = contrat (C2.4), async, léger en RAM | Node/Express : duplique les modèles avec Data |
| BDD | **PostgreSQL 16 + PostGIS + TimescaleDB** | Postgres + PostGIS imposés ; Timescale = séries temporelles (compression, rétention), voir ADR-0004 | InfluxDB : second moteur à exploiter |
| Broker | **MQTT : Mosquitto** (site) + **EMQX ou Mosquitto** (central) | Déjà requis ; persistance + QoS 1 ; bridge site->central tolère les coupures, voir ADR-0002 | RabbitMQ : composant en plus |
| Edge | **Docker Compose** par défaut, **K3s** si >= 2 Go de RAM | K3s ~500 Mo au repos : trop pour les passerelles modestes ; mêmes images dans les deux modes | K3s partout |
| Acoustique edge | Service Python (NumPy/SciPy, FFT) en conteneur | Seul un vecteur de features (~8 octets) part en radio ; audio brut interdit | Envoi d'audio brut |
| Conteneurs | Docker + **GHCR** | Gratuit, intégré à GitHub Actions | |
| CI/CD | **GitHub Actions** + Snyk + Trivy + Gitleaks | Porte de sécurité obligatoire | GitLab CI |
| IaC | **Ansible** (sites, central) + **Terraform** (VM Oracle Cloud) | Ansible recommandé par le CDC ; Terraform pour le provisioning reproductible | |
| Reverse proxy | **Caddy** (TLS auto) | Config minimale, TLS 1.3 par défaut | Nginx/Traefik |
| Observabilité | **Prometheus + Alertmanager + Grafana + Loki + node_exporter/cAdvisor** | Imposé ; Loki = logs légers | ELK : trop lourd pour 14 Go |
| Auth | JWT 15 min + refresh rotatif + **TOTP** + **argon2id** + RBAC 4 rôles + RLS | Exigence UC-T01 ; refresh 30 j chiffré pour l'offline long | |
| Automatisation | **n8n** | Imposé, >= 1 workflow d'intégration | |
| Cartes | Leaflet / flutter_map + OpenStreetMap | Gratuit, léger | Google Maps |
| Notifications | FCM (push) + SMTP/SendGrid (e-mail) | CDC §10.2 | |
| Tests | pytest, Testcontainers, Playwright, flutter_test + integration_test, k6, Schemathesis | Unit, intégration, E2E, charge, contrat | |
| Docs | Mermaid dans le dépôt, Draw.io, OpenAPI, ADR | Versionnés avec le code | |
| Gestion de projet | GitHub Projects + Jira (tickets), Milestones | Traçabilité PR <-> tâche | |

## Décision
Nous retenons la stack du tableau ci-dessus. Principe directeur : **un composant de moins à exploiter vaut mieux qu'une fonctionnalité de plus**, et **le même langage/modèle** entre Dev et Data quand c'est possible.

## Conséquences
- Positives : peu de composants (Postgres, Mosquitto, FastAPI, Caddy, n8n, observabilité), contrat d'API généré, types partagés (OpenAPI -> TypeScript), reconstruction en une commande (Ansible).
- Négatives : trois langages (Python, TypeScript, Dart) pour une équipe de 3 ; TimescaleDB à maîtriser ; K3s et Compose à maintenir en parallèle sur les sites.
- Risques : R3 (passerelle trop faible pour K3s) -> mode Compose par défaut ; R4 (compétence front-end hors périmètre DevOps) -> accord tuteur S2. Voir `docs/project/risk-register.md`.
- Sécurité / a11y / sobriété : chaque ligne du tableau a été choisie en tenant compte de ces trois critères (Radix pour l'a11y, traitement acoustique en edge pour la sobriété, argon2id/RLS pour la sécurité).

## Mise en œuvre et vérification
Epics EP-00 à EP-12 (ROADMAP §5.4). Vérification : E2E de chaque epic (ROADMAP §5.4b), mesures NFR (ROADMAP §4.4). Toute dérogation à cette stack = nouvel ADR qui remplace celui-ci ou le complète.

## Références
`ROADMAP.md` §1 ; `cahier de charge.md` chapitres IX et X ; ADR-0002, ADR-0003, ADR-0004.
