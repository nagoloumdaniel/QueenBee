# QueenBee - contexte pour Claude Code

Plateforme de suivi de ruches connectées (BeeAfrica) : app terrain Flutter hors ligne, dashboard Next.js, API FastAPI, PostgreSQL + PostGIS + TimescaleDB, MQTT, simulateur, IaC. Équipe de 3 étudiants (LH, IG, WA), projet fil rouge EADL. **Sans secret dans ce fichier.**

## Où lire d'abord
1. `docs/jira/PLAYBOOK.md` : règles d'équipe, nommage, time-box, Definition of Done, bonnes pratiques par zone, skills par zone. **Référence unique pour tout ticket (KAN-xxx).**
2. `ROADMAP.md` : stack (§1), design (§4.7), modélisation (§4.8-4.10), structure (§5.1), branches (§5.2b), E2E par epic (§5.4b), normes (§5.5).
3. `cahier de charge.md` : besoin, UC, NFR.
4. Le `README.md` du dossier sur lequel tu travailles (chaque dossier est auto-explicatif).

## Stack (résumé)
| Zone | Techno | Dossier |
|---|---|---|
| Mobile | Flutter, Riverpod, Drift + SQLCipher, Dio, go_router | `apps/mobile` |
| Web | Next.js 15 App Router, TypeScript strict, Tailwind, shadcn/ui | `apps/web` |
| API | FastAPI, Pydantic v2, SQLAlchemy 2, Alembic (Python 3.12) | `apps/api` |
| Ingestion / edge / simulateur | Python, MQTT (Mosquitto), NumPy/SciPy | `apps/ingest`, `apps/edge-acoustic`, `apps/simulator` |
| Données | PostgreSQL 16 + PostGIS + TimescaleDB | `db/` |
| Infra | Docker Compose / K3s, Ansible, Terraform, Caddy, GitHub Actions | `infra/`, `.github/workflows` |
| Observabilité | Prometheus, Alertmanager, Grafana, Loki | `monitoring/` |
| Automatisation | n8n | `n8n/` |

## Git (obligatoire)
- **Jamais de développement, commit ou push sur `main`** (ni `phase/*`). Hook `git-guard` actif. Pas de force-push.
- Branche : `<type>/EP-<nn>-<slug>` avec type `feat|fix|refactor|test|docs|chore|ci` ; slug minuscule, tirets, sans accent, <= 40 caractères. Une branche = un ticket. Phase : `phase/<nn>-<slug>`. Hotfix : `hotfix/<slug>`.
- Commit : **Conventional Commits**, impératif, <= 72 caractères : `feat(db): ajoute la migration site et country (KAN-123)`. Utiliser le skill `caveman-commit`.
- PR : titre = commit principal ; corps = Quoi / Pourquoi / Comment tester / Preuves (sortie E2E) / Risques ; `Closes KAN-123`. Relecteur obligatoire. **Jamais de merge sans accord explicite de LH.**
- Commencer chaque tâche : `git status`, branche réelle, ticket et fichiers cités.

## Commandes
```bash
make up        # stack locale (infra/compose/dev.yml)     make down   # l'arrêter
make seed      # données de démo                          make sim    # simulateur
make test      # tests de toutes les apps                 make lint   # lint + types
make fmt       # formatage                                make e2e    # stack e2e + Playwright
```
Par app : voir le README de chaque dossier (`apps/api`, `apps/web`, `apps/mobile`...).

## Règles de qualité
- **Test E2E (ou intégration) écrit d'abord**, vert en CI, sortie jointe à la PR. Bug corrigé = test de non-régression.
- Python : ruff + mypy strict, couches `routers/ services/ repositories/ schemas/`, pas de SQL dans les routers. TS : strict, ESLint, composants serveur par défaut. Dart : `very_good_analysis`, Riverpod, repository pattern.
- UI : tokens de design uniquement (ROADMAP §4.7), états loading/erreur/vide/hors-ligne, WCAG 2.2 AA (`docs/accessibility/checklist.md`). Mobile : la base locale est la source de l'UI, écritures via l'outbox.
- Sécurité : `docs/security/asvs-checklist.md`, jamais de PII ou de secret dans les logs, autorisation côté serveur. Tests actifs en environnement de test uniquement.
- Pas de `TODO` sans ticket : `TODO(KAN-123)`.
- Textes et commentaires en français ; identifiants (code, tables, endpoints) en anglais.

## Secrets
Aucun secret dans le dépôt, la mémoire ou les logs. Variables d'environnement : noms dans `.env.example`, valeurs dans `.env` (ignoré). Gitleaks en pre-commit et en CI.

## Communication
Mode **caveman** (réponses compressées) par défaut, sauf demande explicite de détail ; jamais au détriment des erreurs, résultats de tests, alertes sécurité ou code. Invoquer le skill `caveman` en début de session. Skills par zone : tableau du PLAYBOOK §8.

## Pièges connus
- `docs/jira/` est géré à part : ne pas y toucher sans consigne du ticket.
- `ROADMAP.md` et `cahier de charge.md` sont des références : ne pas les réécrire dans une tâche de code.
- Roadmap != code : si le code diverge, expliquer l'écart avant toute refonte.
