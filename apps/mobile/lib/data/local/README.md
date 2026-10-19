# data/local

Base de données locale : **Drift** (SQLite) chiffrée avec **SQLCipher**. C'est la **source de l'interface** (offline-first).

- `tables.dart` : tables (ruches, inspections, photos, récoltes, alertes, outbox, curseur de sync).
- `app_database.dart` : ouverture chiffrée, migrations, provider.
- `app_database.g.dart` : **généré** (non committé en l'état du squelette) :
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```

## Règles
- La clé SQLCipher est générée au premier lancement et stockée dans le Keystore/Keychain (`core/storage`). Jamais en dur.
- Toute évolution de table = incrément de `schemaVersion` + étape de migration **testée**. On ne supprime jamais de données non synchronisées.
- Pas de logique métier ici : seulement le stockage. Les repositories (`data/repositories`) orchestrent.
- Test : `AppDatabase.forTesting(NativeDatabase.memory())`.
