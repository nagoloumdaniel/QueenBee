# data/remote

Sources de données **distantes** (API FastAPI) : une classe par domaine, qui ne fait que des appels Dio.

- `hive_remote_source.dart` : ruches, QR, alertes.
- `sync_remote_source.dart` : `/sync/push` et `/sync/pull`.

À ajouter : `auth_remote_source.dart` (login, MFA, refresh, logout), envoi des photos (`POST /inspections/{id}/photos`).

Contrat : `docs/openapi.yaml`. Règles : pas de logique métier, pas d'accès à Drift, erreurs RFC 9457 remontées telles quelles aux repositories.
