# apps/ingest — worker d'ingestion MQTT

**Rôle** : consomme `queenbee/+/+/telemetry` (QoS 1), valide chaque trame (schéma, plages physiques,
signature HMAC, anti-rejeu `seq`), écrit `measurement` (idempotent) ou `integrity_event`, puis exécute
les règles de seuil pour créer des `alert`. Expose des métriques Prometheus (port 9100).

## Lancer en local

```bash
cd apps/ingest
python -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
cp .env.example .env
docker compose -f ../../infra/compose/dev.yml up -d postgres mosquitto   # dépendances
queenbee-ingest            # (NotImplementedError tant que EP-04 n'est pas fait)
pytest && ruff check . && mypy
```

## Structure

- `src/ingest/main.py` : boucle MQTT -> base (squelette).
- `src/ingest/validators.py` : modèle `TelemetryFrame`, `IntegrityKind` (miroir de l'ENUM SQL), `validate_frame`, `check_replay`.
- `src/ingest/rules/` : `swarming`, `acoustic_drop`, `brood_temp`, `immobility`, `heatwave`, `gps_drift` (chacune expose `evaluate(window)`).
- `tests/` : tests unitaires ; intégration avec Testcontainers (`-m integration`).

## Epics

- **EP-04 [INGEST]** : validation, anti-rejeu, idempotence, règles -> alertes, contrat avec Data pour le score ML.
- **EP-05 [EDGE]** : le broker central reçoit les trames via le bridge Mosquitto site -> central (voir `infra/mosquitto/`).
- **EP-01 [SIM]** : le simulateur fournit les trames valides, rejouées, hors plage et GPS déplacé pour le E2E.

## Bonnes pratiques locales

- Seuils lus dans `alert_threshold` (par site), jamais en dur. Règles de seuil : **100 % de couverture**.
- Idempotence : une trame reçue deux fois ne crée qu'une ligne (clé `(hive_id, ts, seq)`) ; alertes dédupliquées par `dedup_key`.
- Aucune trame rejetée n'est perdue : toujours un `integrity_event`.
- Logs JSON sans PII ; secrets via variables `INGEST_*`.
- Test E2E EP-04 : trames valides/rejouées/hors plage/GPS déplacé -> mesures, `integrity_event`, alerte `hive_moved`.
