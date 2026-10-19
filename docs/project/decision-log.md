# Journal des décisions

> Tenu **dès S01**. Une ligne par décision, avec un lien vers l'ADR quand elle est structurante (`docs/adr/`). Matière directe du Bloc 1 (parties 6 à 8) et du Bloc 2 (journal des décisions d'architecture, C2.1). Une décision sans date ni raison n'a pas de valeur pour le jury.

| N° | Date | Décision | Contexte / raison | Options écartées | Décideurs | Impact (planning, budget, risque) | ADR / lien |
|---|---|---|---|---|---|---|---|
| D-001 | 2026-10-19 | Stack technique du projet (Flutter, Next.js, FastAPI, PostgreSQL + PostGIS + Timescale, Mosquitto, Compose/K3s, Ansible/Terraform) | Exigences du cahier des charges, équipe de 3, ressources limitées | React Native, Node/Express, InfluxDB, RabbitMQ, K3s partout | LH, IG, WA (à valider) | Cadre tous les epics | [ADR-0001](../adr/0001-stack.md) |
| D-002 | 2026-10-19 | Bridge MQTT Mosquitto avec persistance disque pour la liaison site-central | Zéro perte après coupure, aucun composant en plus | Agent HTTP, RabbitMQ, Kafka | à valider | EP-05 | [ADR-0002](../adr/0002-mqtt-bridge.md) |
| D-003 | 2026-10-19 | Sync mobile : outbox + `client_uuid` + règles de fusion explicites | Offline-first, idempotence, testabilité | CRDT, backend tiers | à valider | EP-07 | [ADR-0003](../adr/0003-sync-offline.md) |
| D-004 | 2026-10-19 | TimescaleDB pour les mesures | Un seul moteur, compression/rétention natives | Partitionnement manuel, table simple, InfluxDB | à valider | EP-02 | [ADR-0004](../adr/0004-timescale.md) |
| D-005 | | Fréquence capteur retenue : 15 min (et non 30 min) | Incohérence CDC §6.4 vs UC-T02 (ROADMAP §9) | 30 min | | volumétrie | |
| | | | | | | | |

## Décisions ouvertes (ROADMAP §9, à trancher en S01)
1. Équipe et capacité réelle (h/semaine) - voir `docs/jira/PLAYBOOK.md` §1 (~10 h/semaine/personne).
2. Durée : 5 mois (page de garde) vs 16 semaines (jalons) - le PLAYBOOK retient S01 à S17 (fin visée 2027-06-11).
3. Fréquence capteur : 15 min vs 30 min -> retenir 15 min (D-005).
4. Accord du tuteur pour le livrable front-end (app offline + dashboard web) - lié à C2.3.
5. Langues de l'UI (fr seul ou + langues locales).
6. Hébergement final des données (Oracle région vs on-prem école).

## Mode d'emploi
1. Ajouter une ligne au moment de la décision (pas après coup).
2. Si la décision structure l'architecture : créer l'ADR (`docs/adr/0000-template.md`) et le lier ici.
3. Si une décision en remplace une autre : ne pas supprimer l'ancienne, ajouter « remplacée par D-0xx ».
