# ADR-0004 - TimescaleDB pour les mesures de capteurs

- **Statut** : Proposé (à valider en S02-S03, avant EP-02)
- **Date** : 2026-10-19
- **Décideurs** : LH, IG, WA
- **Zone / epic** : DB (EP-02)

## Contexte
Les 400 ruches envoient une mesure toutes les 15 minutes (décision ouverte n°3 du ROADMAP : 15 min retenu) soit 96 mesures/ruche/jour et **38 400 mesures/jour** au total (~10 Mo/jour selon le CDC). Besoins : insertion idempotente, requêtes par ruche et par période (graphe 7 jours), agrégats horaires, rétention limitée (3 ans), compression, jointures avec les données relationnelles (ruche, site, alerte) et géographiques (PostGIS). PostgreSQL + PostGIS est imposé ; la VM centrale a 14 Go de RAM. Les volumes sont **modestes** : le choix doit être justifié par l'usage et le dimensionnement cible (démontré avec le simulateur accéléré), pas par un effet de mode.

## Options envisagées
| Option | Avantages | Inconvénients |
|---|---|---|
| A - **TimescaleDB** (extension Postgres) : hypertable `measurement`, compression, rétention, agrégat continu | Reste dans Postgres (un seul moteur, jointures SQL/PostGIS, RLS, sauvegardes communes) ; compression et rétention natives ; agrégats continus | Extension à installer/maintenir (version alignée avec Postgres 16) ; licence (Apache/Timescale License selon fonctions) à vérifier |
| B - Table Postgres **partitionnée** manuellement (pg_partman) | Pas d'extension tierce | Maintenance des partitions à coder ; pas de compression/agrégats continus natifs |
| C - Table simple + index `(hive_id, ts)` | Le plus simple | Gonflement sur 3 ans ; pas de rétention/compression ; agrégats à la main |
| D - InfluxDB / autre TSDB | Optimisé séries temporelles | Second moteur à exploiter, pas de RLS ni PostGIS, sauvegardes séparées |

## Décision
Option **A**. `measurement` est une **hypertable** (`chunk_time_interval = 7 days`), clé primaire `(hive_id, ts, seq)` (anti-rejeu + idempotence via `ON CONFLICT DO NOTHING`), compression après 30 jours (`compress_segmentby = hive_id`), rétention 3 ans, **agrégat continu** `measurement_hourly` pour les graphes. `gateway_heartbeat` est aussi une hypertable. Schéma complet : ROADMAP §4.9 puis `db/schema.sql`.

Si l'extension pose un problème d'exploitation (version, image Docker, sauvegarde), le **plan B** est l'option B (partitionnement natif) : le schéma de la table est volontairement compatible.

## Conséquences
- Positives : un seul moteur ; requêtes SQL standard ; RLS par site applicable ; chaîne de sauvegarde unique (pg_dump + WAL) ; sobriété (compression).
- Négatives : image Postgres spécifique (Timescale + PostGIS) à construire/épingler ; restauration à tester avec l'extension (runbook `restore-database.md`).
- Risques : montée de version Postgres/Timescale ; usage excessif des fonctionnalités avancées (rester simple) ; R8 (ressources VM) -> dimensionnement frugal.
- Sobriété : compression + rétention + agrégats = moins de stockage et de requêtes lourdes ; mesure à documenter (`docs/eco-conception/checklist.md`).

## Mise en œuvre et vérification
Migrations Alembic (up/down testées sur base vide), seeds (8 sites, 400 ruches). Preuve de dimensionnement : simulateur accéléré (400 ruches x 24 h) -> insertion + requête de graphe 7 jours sous les cibles (API p95 < 500 ms), taille avant/après compression en annexe. Test E2E EP-02 : migration up/down + RLS.

## Références
ROADMAP §4.9 (modèle de données) ; `db/` ; `docs/diagrams/er.md` ; documentation TimescaleDB (hypertables, compression, continuous aggregates).
