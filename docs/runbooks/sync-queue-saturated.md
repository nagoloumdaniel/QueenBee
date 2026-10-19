# Runbook - File de synchronisation saturée

- **Alerte liée** : `SyncQueueSaturated` (taille ou âge de la file bridge/outbox au-dessus du seuil) - TODO(KAN-xxx, OBS) : seuils et nom exact dans `monitoring/`
- **Sévérité** : moyenne (élevée si le disque du site approche de 100 %)
- **Services concernés** : bridge MQTT site -> central, ingestion, `GET /ops/sync-queues`
- **Propriétaire** : (à renseigner) - **Dernier test du runbook** : jamais
- **Délai cible** : accusé < 1 h ; file vidée en moins de 2 min par journée de données une fois la cause levée

## Symptôme
Le panneau Grafana « Files de sync » (taille, âge, débit) dépasse le seuil ; `GET /ops/sync-queues` montre une file qui grossit ou dont l'élément le plus ancien vieillit. Côté app mobile, la bannière « N éléments à synchroniser » reste élevée chez plusieurs utilisateurs.

## Diagnostic
1. Quelle file ? **Site -> central** (bridge Mosquitto) ou **app -> API** (outbox des mobiles) ? Les mesures et les inspections n'ont pas la même chaîne.
2. La liaison est-elle en cause ? (`vpn-down.md`, `gateway-offline.md`). Une file qui grossit pendant une coupure est normale.
3. L'ingestion consomme-t-elle ? Logs du worker (`apps/ingest`), débit d'insertion, erreurs en base (verrous, disque plein, hypertable).
4. Le disque de la passerelle est-il presque plein ? (`df -h` sur le site ; métrique cAdvisor/node_exporter).
5. Beaucoup de rejets (`integrity_event` : rejeu, signature) ? Un capteur/simulateur défaillant peut inonder la file.

## Action
1. Cause = liaison : rétablir la liaison ; ne **pas** purger la file (elle contient des données uniques).
2. Cause = ingestion lente : redémarrer le worker si bloqué (`docker compose restart ingest`), vérifier la base ; l'insertion est **idempotente** (`ON CONFLICT DO NOTHING`), un rejeu est sûr.
3. Cause = disque plein : libérer de l'espace **hors** de la file (journaux, images inutilisées) ; si impossible, escalader avant toute suppression de données.
4. Cause = émetteur fou (simulateur, capteur) : arrêter la source (`PUT /sim/speed` ou scénario en cours), analyser les `integrity_event`.
5. Vérifier la décroissance de la file puis la fermeture de l'alerte.

## Escalade
- File qui ne baisse pas après 2 h ou disque > 90 % : administrateur DevOps (LH). Perte de données possible : informer aussi la Data.
- Fournir : site, taille/âge de la file, débit, extraits de logs sans PII.

## Après l'incident
Ajuster les seuils d'alerte et la taille de file (ADR-0002), ajouter un test de charge (k6) si le débit de reprise est insuffisant.
