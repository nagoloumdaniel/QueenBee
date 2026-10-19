# Séquence - synchronisation hors ligne (UC-A01)

**Question** : comment une inspection saisie sans réseau arrive-t-elle sur le serveur sans doublon, et comment les conflits sont-ils traités ?
**Source** : ROADMAP §4.8 (« Séquence - sync offline »). Voir ADR-0003 et `apps/mobile/lib/core/sync/`.

```mermaid
sequenceDiagram
  participant M as App Flutter
  participant O as Outbox SQLite
  participant A as API
  participant D as DB
  M->>O: écrit inspection (client_uuid, version, status=pending)
  Note over M: hors ligne, affichage immédiat
  M->>A: POST /sync/push (batch, JWT) dès réseau
  A->>D: upsert par client_uuid (idempotent)
  alt conflit (version serveur > base)
    A-->>M: 409 + version serveur
    M->>M: résolution (champ par champ, serveur gagne pour validé)
  end
  A-->>M: ids + accusés
  M->>A: GET /sync/pull?since=cursor
  A-->>M: changements
  A->>A: notification coordinateur si anomalie
```
