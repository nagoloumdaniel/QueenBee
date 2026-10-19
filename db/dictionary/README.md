# Dictionnaire de données

**Rôle** : décrire chaque table et colonne (type, contrainte, sens métier, donnée personnelle ou non, durée de rétention).

Le dictionnaire est **généré depuis le DDL**, pas écrit à la main :

1. EP-02 [DB] : choisir l'outil (p. ex. `tbls`, SchemaSpy, ou un script lisant `pg_catalog` + `COMMENT ON`).
2. Ajouter des `COMMENT ON TABLE/COLUMN` dans les migrations Alembic pour porter le sens métier.
3. Générer le Markdown vers `docs/data-dictionary.md` (CI : échec si le dictionnaire est périmé).

À documenter en priorité : colonnes PII chiffrées (`full_name_enc`, `phone_enc`, `mfa_secret_enc`), tables Timescale (`measurement`, `gateway_heartbeat`), RLS, rétention (3 ans pour `measurement`).

Tickets : EP-02 [DB] et [DOC].
