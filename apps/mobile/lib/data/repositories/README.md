# data/repositories

**Pattern repository** : la frontière entre l'interface (`features/`) et les données (`data/local` + `data/remote`).

| Fichier | Rôle | Use case |
|---|---|---|
| `hive_repository.dart` | liste/détail des ruches, rafraîchissement | UC-A01 |
| `inspection_repository.dart` | enregistrer une inspection (Drift + outbox) | UC-A01 |
| `alert_repository.dart` | alertes reçues | UC-A02 |
| `harvest_repository.dart` | déclarer une récolte (Drift + outbox) | UC-A03 |

Règles :
- Interface abstraite + implémentation ; l'UI dépend de l'interface (Riverpod provider).
- **Lire = Drift** (flux `Stream`), **écrire = Drift + outbox** (transaction), **rafraîchir = API puis Drift**.
- Un repository ne connaît pas Flutter (pas de `BuildContext`, pas de widget).
- Tests unitaires avec une base en mémoire (`AppDatabase.forTesting`) et des fausses sources distantes (`mocktail`).
