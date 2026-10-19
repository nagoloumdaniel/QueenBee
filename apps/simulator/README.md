# apps/simulator — simulateur de capteurs et de scénarios

**Rôle** : chemin critique du projet (CDC §6.6). Joue le rôle d'une passerelle LoRaWAN + capteurs :
publie sur **le même topic MQTT** que le matériel réel (`queenbee/{site}/{hive}/telemetry`, QoS 1),
simule aussi les apiculteurs (inspections, récoltes) via l'API, avec **accélération temporelle**
et un **moteur de scénarios déclaratifs** produisant une **vérité terrain** horodatée.

## Lancer en local

```bash
cd apps/simulator
python -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
cp .env.example .env
queenbee-sim run --sites SN-CASA --speed 60          # (NotImplementedError tant que EP-01 n'est pas fait)
pytest && ruff check . && mypy
# ou via Docker : docker compose -f ../../infra/compose/dev.yml up simulator
```

## Structure

| Fichier | Rôle |
|---|---|
| `src/simulator/cli.py` | commandes `run`, `scenario`, `serve` |
| `config.py` | modèles Pydantic + chargement de `config/*.yaml` |
| `climate.py` | température/humidité/miellée par site |
| `hive_model.py` | génération par ruche (saison, cycle jour/nuit, bruit, batterie, GPS) |
| `humans.py` | profils assidu 30 % / régulier 50 % / occasionnel 20 %, récoltes |
| `scenarios.py` | timeline YAML -> effets ; vocabulaire d'actions documenté en tête de fichier |
| `mqtt_client.py` | publication MQTT, heartbeat passerelle |
| `api.py` | API de pilotage `/sim/*` (appelée par `apps/api/routers/sim.py`) |
| `truth.py` | écriture de la vérité terrain (JSONL) |
| `config/sites.yaml` | 8 sites, 3 pays (SN x3, CI x3, CM x2), 50 ruches chacun = 400 |
| `scenarios/*.yaml` | essaimage, mortalité, stress thermique, passerelle offline, brouillage, rejeu, vol de ruche |

## Epics

- **EP-01 [SIM]** (chemin critique S2-S4) : v0 = MQTT + 1 site + 1 scénario ; puis 8 sites, accélération, profils humains, 7 scénarios, API de run, vérité terrain.
- Consommateurs : EP-04 (ingestion), EP-05 (edge/sync), EP-10 (observabilité), Data (modèles), Cyber (incidents).

## Bonnes pratiques locales

- **Déterminisme** : toute aléa passe par `numpy.random.Generator` avec graine (`SIM_SEED`) ; un scénario doit se rejouer à l'identique.
- Valeurs de `sites.yaml` : indicatives, à valider avec Data ; ne jamais dupliquer un profil climatique entre sites.
- Les scénarios sont du **YAML**, pas du code : ajouter un scénario = ajouter un fichier + sa `ground_truth`.
- Livrer d'abord la version minimale (MQTT + 1 site + 1 scénario) : Data et Cyber en dépendent (risque R1).
- Test E2E EP-01 : scénario `essaimage` à x60 -> messages reçus aux horodatages attendus, vérité terrain écrite ; 8 sites x 50 ruches publient.
