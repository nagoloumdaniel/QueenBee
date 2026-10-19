# monitoring — observabilité

**Rôle** : configuration versionnée de la supervision (ROADMAP §6.1) : Prometheus + Alertmanager + Loki + Grafana.

| Dossier | Contenu |
|---|---|
| `prometheus/prometheus.yml` | cibles de scrape (api, ingest, node, cadvisor, sites via VPN) |
| `prometheus/rules/queenbee.rules.yml` | alertes : heartbeat > 15 min, VPN > 5 min, 5xx, file > seuil, certificat < 14 j, disque > 80 % |
| `alertmanager/alertmanager.yml` | routage ; critiques -> webhook n8n (`n8n/workflows/alerte-critique-notification.json`) |
| `loki/loki.yml` | logs (rétention 30 j) ; `promtail-site.yml` pour les passerelles |
| `grafana/provisioning/` | datasources (Prometheus, Loki, base QueenBee) et provider de dashboards |
| `grafana/dashboards/*.json` | 5 dashboards minimaux : déploiements, files de sync, disponibilité des sites, santé des services, qualité radio |

## Lancer en local

```bash
docker compose -f ../infra/compose/dev.yml up -d prometheus loki grafana   # Grafana : http://127.0.0.1:3001
# Valider les règles et la config (avec les images officielles, sans rien installer) :
docker run --rm -v "$PWD/prometheus:/etc/prometheus:ro" --entrypoint promtool prom/prometheus:v2.55.1 check rules /etc/prometheus/rules/queenbee.rules.yml
docker run --rm -v "$PWD/alertmanager:/cfg:ro" --entrypoint amtool prom/alertmanager:v0.27.0 check-config /cfg/alertmanager.yml
```

## Epics

- **EP-10 [OBS]** : métriques (`/metrics` API, ingestion, heartbeat), vraies requêtes des panneaux, exporters (WireGuard, blackbox), runbooks `docs/runbooks/`.
- **EP-05 [EDGE]** : métriques de file/bridge et heartbeat de passerelle. **EP-09** : webhook n8n.
- Test E2E EP-10 : provoquer un incident (arrêt conteneur, file saturée) -> alerte reçue + panneau concerné change d'état.

## Bonnes pratiques locales

- Les dashboards JSON sont éditables dans Grafana mais **toujours ré-exportés dans le dépôt** (`allowUiUpdates: false`).
- Chaque alerte a un runbook ; pas de PII dans les labels ni les logs.
- Les métriques `queenbee_*` citées dans les règles sont des contrats : les implémenter avec exactement ces noms ou adapter la règle dans la même PR.
- Compte PostgreSQL de Grafana en lecture seule.
