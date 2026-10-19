# Diagramme de contexte système

**Question** : qui interagit avec QueenBee et quels sont les grands blocs ?
**Source** : ROADMAP §4.8 (« Contexte système »). **Légende** : trait plein = flux de production ; pointillé = simulateur (tests/démo).

```mermaid
flowchart LR
  A[Apiculteur - app Flutter] -->|HTTPS| C
  K[Coordinateur / Gestionnaire / Admin - web] -->|HTTPS| C
  subgraph Central [Cloud central - Oracle VM]
    C[Caddy] --> API[FastAPI]
    API --> DB[(PostgreSQL + PostGIS + Timescale)]
    API --> N8N[n8n]
    BR[MQTT central] --> ING[Ingestion worker]
    ING --> DB
    PR[Prometheus/Grafana/Loki]
  end
  subgraph Site [Site x8 - Edge]
    GW[Passerelle LoRaWAN] --> MQ[Mosquitto local]
    MQ --> AC[Service acoustique]
    MQ -->|bridge MQTT over TLS/VPN| BR
  end
  H[400 ruches capteurs] -->|LoRaWAN| GW
  SIM[Simulateur] -.->|MQTT| MQ
  SIM -.->|MQTT| BR
```
