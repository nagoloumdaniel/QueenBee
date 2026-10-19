# Modèle conceptuel de données (MCD)

**Question** : quelles sont les entités de QueenBee et comment sont-elles reliées ?
**Source** : ROADMAP §4.9 (« MCD »). Le DDL complet (types, contraintes, hypertables, RLS) est dans `db/schema.sql` ; les colonnes sont décrites dans `docs/data-dictionary.md`. Principes : UUID, `timestamptz` UTC, soft delete, `created_at/updated_at/version`, audit trail, RLS par site, PII chiffrée.

```mermaid
erDiagram
  COUNTRY ||--o{ SITE : contient
  SITE ||--o{ HIVE : héberge
  COOPERATIVE ||--o{ HIVE : possède
  COOPERATIVE ||--o{ USER_COOP : emploie
  APP_USER ||--o{ USER_COOP : membre
  APP_USER }o--o{ SITE : accès
  HIVE ||--o{ MEASUREMENT : produit
  HIVE ||--o{ INSPECTION : reçoit
  HIVE ||--o{ HARVEST : donne
  HIVE ||--o{ ALERT : déclenche
  HIVE ||--o{ HIVE_MOVE : déplacée
  HIVE ||--o{ INTEGRITY_EVENT : signale
  APP_USER ||--o{ INSPECTION : réalise
  APP_USER ||--o{ VISIT_PLAN : assigné
  HIVE ||--o{ VISIT_PLAN : cible
  ALERT ||--o| VISIT_PLAN : génère
  SITE ||--o{ GATEWAY : possède
  GATEWAY ||--o{ GATEWAY_HEARTBEAT : émet
  SITE ||--o{ ALERT_THRESHOLD : configure
  APP_USER ||--o{ AUDIT_LOG : trace
  INSPECTION ||--o{ INSPECTION_PHOTO : joint
  HARVEST }o--|| APP_USER : déclarée_par
```
