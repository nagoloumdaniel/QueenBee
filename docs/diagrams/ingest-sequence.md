# Séquence - ingestion IoT (UC-T02)

**Question** : que devient une mesure de capteur, de la ruche à la base, y compris en cas de trame invalide ou rejouée ?
**Source** : ROADMAP §4.8 (« Séquence - ingestion IoT »). Voir aussi ADR-0002 (bridge MQTT) et `apps/ingest/`.

```mermaid
sequenceDiagram
  participant S as Capteur/Simulateur
  participant G as Passerelle
  participant L as Mosquitto site
  participant B as MQTT central
  participant I as Ingestion
  participant D as DB
  S->>G: trame LoRaWAN (hive_id, mesures, ts, gps)
  G->>L: publish queenbee/{site}/{hive}/telemetry
  L-->>B: bridge QoS1 (cache disque si coupure)
  B->>I: subscribe
  I->>I: valide plages, unicité (hive_id+ts+seq), signature
  alt invalide/rejeu
    I->>D: INSERT integrity_event
  else valide
    I->>D: INSERT measurement (idempotent ON CONFLICT DO NOTHING)
    I->>D: évalue seuils -> alert
  end
```
