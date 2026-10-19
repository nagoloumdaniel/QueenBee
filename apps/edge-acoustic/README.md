# apps/edge-acoustic — extraction de features acoustiques (edge)

**Rôle** : tourne sur la passerelle de site. Transforme un échantillon audio de 10 s en un vecteur
de features (~8 octets : fréquence dominante, ratio d'énergie de bande, score d'activité) par FFT.
**Le signal brut n'est jamais transmis ni conservé** (CDC §6.4 : duty cycle LoRaWAN, surface d'attaque réduite).

## Lancer en local

```bash
cd apps/edge-acoustic
python -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
cp .env.example .env
pytest && ruff check . && mypy
```

Image : `docker build -t queenbee/edge-acoustic .` (amd64 et arm64 ; cible des passerelles modestes < 2 Go RAM).

## Structure

- `src/edge_acoustic/features.py` : `extract_features` (FFT), `encode_features` (codage compact).
- `src/edge_acoustic/main.py` : boucle d'acquisition et publication MQTT locale (squelette).
- `tests/` : tests sur signaux synthétiques (sinusoïde de fréquence connue, silence).

## Epics

- **EP-05 [EDGE]** : service acoustique, échantillonnage adaptatif (30 min / 10 min en surveillance renforcée).
- **EP-01 [SIM]** : le simulateur fournit des échantillons/valeurs d'activité réalistes.
- Aval : `apps/ingest` décode le vecteur de features et le stocke dans `measurement.acoustic_activity`.

## Bonnes pratiques locales

- Mesurer CPU/RAM (éco-conception, ROADMAP §6.5) : le service doit rester négligeable sur une passerelle.
- Fonctions pures et testables (pas d'I/O dans `features.py`) ; tests avec `hypothesis` sur les bornes.
- Aucun enregistrement audio sur disque ni dans les logs.
