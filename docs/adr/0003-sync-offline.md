# ADR-0003 - Synchronisation hors ligne de l'app mobile (outbox + client_uuid)

- **Statut** : Proposé (à valider en S03, avant EP-07)
- **Date** : 2026-10-19
- **Décideurs** : LH, IG, WA
- **Zone / epic** : MOBILE, API (EP-07, EP-06)

## Contexte
L'apiculteur saisit des inspections (avec photos) et des récoltes sans réseau (UC-A01, UC-A03). Les données doivent être affichées immédiatement, envoyées plus tard sans doublon, et les conflits (modification serveur entre-temps, validation par le coordinateur) résolus de façon prévisible. Contraintes : appareils modestes, SQLite chiffré (SQLCipher), refresh de 30 jours, charge réseau faible. Risque R7 « conflits de sync hors-ligne » (score 9).

## Options envisagées
| Option | Avantages | Inconvénients |
|---|---|---|
| A - **Outbox locale + `client_uuid` + `version`**, push/pull par curseur, règles de fusion explicites | Simple à raisonner et à tester (tests de propriété) ; idempotent ; contrôle total | À coder (outbox, pull, fusion) |
| B - CRDT (ex. Automerge/Yjs) | Fusion automatique | Lourd, modèle de données contraint, peu adapté aux entités relationnelles et à la validation métier |
| C - Backend de sync tiers (Firebase, PowerSync, Couchbase Lite) | Gain de temps | Dépendance, coût/licence, hébergement des données (RGPD, souveraineté) |
| D - Écriture directe + file en mémoire | Très simple | Perte de données si l'app est tuée hors ligne : inacceptable |

## Décision
Option **A**.
1. Toute écriture = **transaction Drift** : entité + ligne d'`outbox_entries`. L'UI lit toujours Drift.
2. Chaque entité créée hors ligne a un `client_uuid` (UUID v4) ; le serveur fait un **upsert par `client_uuid`** : renvoyer deux fois ne crée pas de doublon. Les POST portent un `Idempotency-Key`.
3. `POST /sync/push` envoie un lot ; réponse par élément : `ok`, `conflict` (409 + version serveur), `error`. `GET /sync/pull?since=<curseur>` renvoie les changements et un nouveau curseur (table `sync_cursor`).
4. **Résolution de conflit** (ROADMAP §4.9) :
   - le **serveur gagne** si l'entité est déjà `validated` ;
   - sinon **fusion champ par champ** : le `updated_at` le plus récent l'emporte ;
   - **photos et notes ne sont jamais écrasées** (ajout) ;
   - un conflit non résolvable automatiquement est marqué `conflict` et signalé à l'utilisateur dans un message simple.
5. Échecs réseau : backoff exponentiel plafonné ; l'outbox est conservée tant que le serveur n'a pas acquitté.
6. Sécurité : base chiffrée SQLCipher, clé dans Keystore/Keychain ; refresh token 30 jours stocké chiffré ; à la déconnexion on efface les jetons mais on **ne détruit pas** les données non synchronisées sans avertissement.

## Conséquences
- Positives : comportement déterministe et testable ; fonctionne sans service tiers ; données personnelles maîtrisées.
- Négatives : code de fusion à maintenir ; migrations Drift à gérer avec prudence.
- Risques : R7 ; horloges d'appareil incorrectes (utiliser `version` serveur en priorité, `updated_at` en second) ; photos volumineuses (redimensionner/WebP avant envoi, envoi séparé).
- Performance : cible d'une journée de données en moins de 2 minutes ; pagination du pull.

## Mise en œuvre et vérification
Fichiers : `apps/mobile/lib/core/sync/{outbox,sync_service}.dart`, `apps/mobile/lib/data/local/`, endpoints `/sync/*` dans `docs/openapi.yaml`. Tests : tests de propriété sur la fusion (unitaire), `integration_test/offline_inspection_test.dart` (mode avion -> inspection + photo -> réseau -> synchronisée, coordinateur notifié ; conflit simulé -> résolution attendue).

## Références
`docs/diagrams/sync-sequence.md` ; ROADMAP §4.8, §4.9, §5.4b (EP-07) ; `apps/mobile/lib/core/sync/README.md`.
