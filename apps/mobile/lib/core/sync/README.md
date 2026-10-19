# core/sync

Cœur de l'**offline-first** (epic EP-07). Deux fichiers :

- `outbox.dart` : file locale des écritures à envoyer (inspections, photos, récoltes).
- `sync_service.dart` : push de l'outbox puis pull des changements serveur.

## Règles à respecter
1. Toute écriture utilisateur = **transaction Drift** : entité + ligne d'outbox ensemble.
2. L'UI lit **toujours** Drift, jamais le réseau.
3. Chaque entité a un `client_uuid` -> l'envoi est **idempotent** (rejouer = pas de doublon).
4. Conflits : voir `docs/adr/0003-sync-offline.md` (serveur gagne si validé ; sinon fusion par champ ; photos/notes jamais écrasées).
5. Le bouton « Synchroniser maintenant » et la bannière affichent l'état réel (`pendingCountProvider`).
6. Cible : une journée de données synchronisée en < 2 min.

## Tests attendus
- `test/core/sync/outbox_test.dart` (unitaire) et un test de propriété sur la fusion.
- `integration_test/offline_inspection_test.dart` : mode avion -> inspection + photo -> réseau -> synchronisée.
- Diagramme : `docs/diagrams/sync-sequence.md`.
