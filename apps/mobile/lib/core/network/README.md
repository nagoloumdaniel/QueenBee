# core/network

Accès réseau de l'application.

- `api_client.dart` : instance `Dio` (URL de base via `--dart-define=API_BASE_URL`, jeton Bearer).
- `connectivity_provider.dart` : état réseau (bannière hors-ligne, déclenchement de la sync).

À faire (tickets MOBILE, EP-07) : refresh automatique du jeton, mapping des erreurs RFC 9457 vers des erreurs de domaine, pinning de certificat.

Règle d'or : **aucun écran n'appelle Dio directement**. Les écrans lisent la base locale (Drift) ; les écritures passent par l'outbox ; les sources distantes (`data/remote/`) sont appelées par `SyncService` et les repositories.
