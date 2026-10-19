# db — schéma de référence, seeds, dictionnaire

**Rôle** : documentation exécutable de la base PostgreSQL 16 + PostGIS + TimescaleDB (ROADMAP §4.9).

| Élément | Contenu |
|---|---|
| `schema/reference.sql` | DDL complet copié de ROADMAP §4.9. **Référence de lecture** ; la vérité exécutable = migrations Alembic de `apps/api/alembic/versions/` |
| `seeds/` | données de départ : 8 sites, coopératives, puis 400 ruches et 317 utilisateurs générés |
| `dictionary/` | dictionnaire de données généré depuis le DDL (publié dans `docs/data-dictionary.md`) |

## Lancer en local

```bash
docker compose -f ../infra/compose/dev.yml up -d postgres
# Appliquer le schéma de référence sur une base jetable (lecture/expérimentation uniquement) :
docker compose -f ../infra/compose/dev.yml exec -T postgres psql -U queenbee -d queenbee < schema/reference.sql
# En vrai : cd ../apps/api && alembic upgrade head
```

## Epics

- **EP-02 [DB]** : migrations Alembic (up/down), seeds 8 sites / 400 ruches / 317 utilisateurs, RLS, politiques Timescale (compression 30 j, rétention 3 ans).
- **EP-03 [AUTH]** : colonnes chiffrées (pgcrypto), verrouillage de compte.
- **EP-11 [OBS]** : sauvegarde `pg_dump` + WAL, restauration testée.

## Bonnes pratiques locales

- Toute modification de schéma = migration Alembic **réversible** (downgrade testé) puis mise à jour de `reference.sql`.
- UUID, `timestamptz` UTC, soft delete, RLS par site ; PII chiffrées (pgcrypto), jamais en clair dans les logs.
- Test E2E EP-02 : migration up/down sur base vide + seeds (8 sites, 400 ruches) ; l'utilisateur du site A ne lit pas le site B.
- Aucun mot de passe réel dans les seeds : hash générés au chargement, mots de passe de démo issus de variables d'environnement.
- Choix Timescale vs partitionnement, RLS, UUID : à justifier dans un ADR (`docs/adr/`).
