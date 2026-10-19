# apps/api — API FastAPI

**Rôle** : API REST de QueenBee (Python 3.12, FastAPI, Pydantic v2, SQLAlchemy 2 async, Alembic).
Contrat OpenAPI 3.1 sous `/api/v1` (voir ROADMAP §4.10). Sondes `/health` (liveness) et `/ready`
(readiness : base joignable) à la racine, **déjà fonctionnelles**.

## Lancer en local

```bash
cd apps/api
python -m venv .venv && source .venv/bin/activate      # Windows : .venv\Scripts\activate
pip install -e ".[dev]"
cp .env.example .env                                    # puis adapter (jamais committé)
uvicorn app.main:app --reload                           # http://localhost:8000/docs
```

Avec la base et le broker : `docker compose -f ../../infra/compose/dev.yml up -d postgres mosquitto`.

## Qualité (à lancer avant chaque PR)

```bash
ruff check . && ruff format --check .
mypy                       # strict
pytest                     # unit ; `pytest -m integration` nécessite Docker
```

## Structure

| Dossier | Contenu |
|---|---|
| `app/main.py` | fabrique d'application, `/health`, `/ready` |
| `app/core/` | `config` (env `QB_*`), `security` (argon2id/JWT/TOTP), `logging` (JSON), `deps` (session DB, utilisateur courant) |
| `app/routers/` | un routeur par domaine (vides, avec docstring et TODO) |
| `app/schemas/` | modèles Pydantic d'entrée/sortie |
| `app/services/` | logique métier |
| `app/repositories/` | accès aux données (SQLAlchemy) |
| `app/models/` | modèles ORM (miroir de `db/schema/reference.sql`) |
| `alembic/` | migrations (`versions/` vide pour l'instant) |
| `tests/{unit,integration,e2e}` | pyramide de tests |

Règle de couches : `routers -> services -> repositories -> models`. **Aucun SQL dans les routers.**

## Epics qui remplissent ce dossier (numérotation ROADMAP §5.4)

- **EP-02 [DB]** : modèles + migrations Alembic + RLS + seeds (`db/`).
- **EP-03 [AUTH]** : `core/security.py`, `routers/auth.py`, `routers/users.py` (login, MFA, refresh rotatif, verrou 5 essais, audit).
- **EP-06 [API]** : sites, ruches, inspections, récoltes, alertes, visites, analytics, rapports.
- **EP-05/EP-07** : `routers/sync.py` (push/pull, conflits §4.9).
- **EP-10 [OBS]** : `/metrics`, `routers/ops.py`. **EP-01 [SIM]** : `routers/sim.py`.

## Bonnes pratiques locales

- Écrire le test (E2E ou intégration) **avant** le code ; un bug corrigé = un test de non-régression.
- Pydantic strict, requêtes paramétrées, pas de PII en clair dans les logs, secrets uniquement via variables `QB_*`.
- Erreurs RFC 9457, pagination par curseur, `Idempotency-Key` sur les POST, rate limit sur `/auth/login`.
- Chaque endpoint est ajouté à `docs/openapi.yaml` (export : `python -c "import json,app.main as m; print(json.dumps(m.app.openapi()))"`).
- Une branche = un ticket : `feat/EP-xx-slug`. Voir `docs/jira/PLAYBOOK.md`.
