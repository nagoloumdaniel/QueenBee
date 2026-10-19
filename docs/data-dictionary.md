# Dictionnaire de données (stub)

> **Statut : squelette.** Ce document doit être **généré depuis le DDL** (`db/schema.sql` / migrations Alembic) puis complété à la main (descriptions, unités, plages, PII). Voir ROADMAP §4.9. Les choix structurants (Timescale vs partitionnement, RLS, UUID) sont justifiés en ADR (`docs/adr/0004-timescale.md`).

## Principes de modélisation
- Identifiants **UUID** (v7 visé) ; dates en `timestamptz` **UTC** ; `created_at` / `updated_at` / `version` ; suppression logique (`deleted_at`) ; audit trail (`audit_log` append-only).
- **RLS PostgreSQL par site** (`app.user_id`, `app.role`) ; les rôles `manager` et `admin` voient tous les sites.
- **PII chiffrées** (pgcrypto) : `full_name_enc`, `phone_enc`, `mfa_secret_enc`. Minimisation, consentement (`consent_at`), droit à l'effacement.
- Idempotence : `client_uuid` (inspection, récolte) ; mesures `PRIMARY KEY (hive_id, ts, seq)` + `ON CONFLICT DO NOTHING`.

## Inventaire des tables
| Table | Rôle | Données personnelles ? | Type de stockage | Épique |
|---|---|---|---|---|
| `country` | Pays et résidence des données | non | relationnelle | EP-02 |
| `site` | 8 sites, position PostGIS | non | relationnelle | EP-02 |
| `cooperative` | Coopératives rattachées à un site | non | relationnelle | EP-02 |
| `app_user` | Comptes (4 rôles, MFA, verrou, consentement) | **oui** (e-mail, nom, téléphone chiffrés) | relationnelle | EP-03 |
| `user_site`, `user_cooperative` | Rattachements utilisateur | indirecte | relationnelle | EP-02 |
| `refresh_token` | Refresh rotatifs (hash, famille, appareil) | indirecte | relationnelle | EP-03 |
| `gateway` | Passerelles LoRaWAN | non | relationnelle | EP-05 |
| `gateway_heartbeat` | Santé des passerelles | non | **hypertable** | EP-05 |
| `hive` | Ruches (position de référence, QR, tolérance) | indirecte (propriétaire) | relationnelle + PostGIS | EP-02 |
| `measurement` | Mesures capteurs (38 400/jour) | non | **hypertable**, compression 30 j, rétention 3 ans | EP-04 |
| `measurement_hourly` | Agrégat continu horaire | non | vue matérialisée continue | EP-04 |
| `integrity_event` | Rejets : plage, rejeu, signature, doublon, capteur inconnu | non | relationnelle | EP-04 |
| `alert_threshold` | Seuils d'alerte par site | non | relationnelle (jsonb) | EP-04 |
| `alert` | Alertes (type, gravité, statut, score) | non | relationnelle | EP-04 |
| `visit_plan` | Visites planifiées | indirecte | relationnelle | EP-06 |
| `inspection`, `inspection_photo` | Inspections et photos | **oui** (photos, notes libres) | relationnelle + stockage objet | EP-06 |
| `harvest` | Récoltes déclarées / validées | indirecte | relationnelle | EP-06 |
| `hive_move` | Déplacements déclarés ou détectés | non | relationnelle | EP-04 |
| `sync_cursor` | Curseur de pull par appareil | indirecte | relationnelle | EP-06 |
| `deployment` | Déploiements (KPI > 95 %) | non | relationnelle | EP-10 |
| `audit_log` | Journal d'audit (REVOKE UPDATE, DELETE) | indirecte (acteur, IP) | relationnelle append-only | EP-03 |

## Types énumérés (`CREATE TYPE ... AS ENUM`)
| Type | Valeurs |
|---|---|
| `user_role` | `beekeeper`, `coordinator`, `manager`, `admin` |
| `alert_type` | `swarming`, `weak_colony`, `thermal_stress`, `dead_colony`, `heatwave`, `offline_sensor`, `gateway_offline`, `hive_moved`, `integrity`, `radio_jamming` |
| `alert_status` | `open`, `acknowledged`, `in_progress`, `resolved`, `escalated`, `false_positive` |
| `severity` | `info`, `warning`, `critical` |
| `harvest_status` | `declared`, `validated`, `flagged` |
| `visit_status` | `planned`, `done`, `cancelled` |
| `integrity_kind` | `out_of_range`, `replay`, `bad_signature`, `duplicate`, `unknown_sensor` |

## Dictionnaire par table (à compléter)
Modèle de fiche à dupliquer pour **chaque table** :

### `nom_de_la_table`
**Rôle** : ... - **Volumétrie** : ... - **Rétention** : ... - **RLS** : oui/non (politique) - **PII** : oui/non

| Colonne | Type | Null ? | Défaut / contrainte | Description | Unité / plage | PII ? |
|---|---|---|---|---|---|---|
| `id` | uuid | non | PK | Identifiant | - | non |
| ... | | | | | | |

Index et leur justification (requête servie) : ...

## Générer la base du dictionnaire
```bash
# Exemple (à adapter au schéma réel, TODO(KAN-xxx, DB)) : lister colonnes et commentaires
psql "$DATABASE_URL" -c "\d+ hive"
# Ajouter des COMMENT ON TABLE/COLUMN dans les migrations pour alimenter ce fichier automatiquement.
```
Règle : un `COMMENT ON COLUMN` par colonne non évidente dans les migrations, puis un script (ticket DB) génère ce document pour éviter la dérive.
