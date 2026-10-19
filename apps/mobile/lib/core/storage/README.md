# core/storage

Secrets de l'appareil uniquement : `secure_storage.dart` (Keystore/Keychain).

La **base de données** (Drift + SQLCipher) est dans `lib/data/local/`. Sa clé de chiffrement est lue ici (`readDatabaseKey`).

Interdits : mettre un jeton ou une clé dans `SharedPreferences`, un fichier, un log ou le code. Voir `docs/security/asvs-checklist.md` (stockage mobile).
