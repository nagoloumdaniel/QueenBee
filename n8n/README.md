# n8n — workflows d'automatisation

**Rôle** : workflows d'intégration côté Dev (CDC §6.7) exportés en JSON et versionnés. n8n tourne en conteneur (`infra/compose/*.yml`).

| Workflow | Déclencheur | Action |
|---|---|---|
| `workflows/alerte-critique-notification.json` | webhook `/webhook/alerte-critique` (Alertmanager ou API) | si sévérité critique -> push FCM + email |
| `workflows/export-rapport.json` | webhook `/webhook/export-rapport` | appelle `POST /reports` de l'API (PDF) |

Les workflows sont **inactifs** (`"active": false`) et **sans identifiants** : les credentials (SMTP, FCM, jeton API) se créent dans l'interface n8n ou via variables d'environnement (`FCM_PROXY_URL`, `ALERT_FROM_EMAIL`, `ALERT_TO_EMAIL`, `QB_API_URL`, `QB_API_TOKEN`) et ne sont jamais committés.

## Lancer en local

```bash
docker compose -f ../infra/compose/dev.yml up -d n8n     # http://127.0.0.1:5678
# Importer : interface n8n > Workflows > Import from file > n8n/workflows/*.json
# Ou en CLI : docker compose -f ../infra/compose/dev.yml exec n8n n8n import:workflow --input=/workflows/alerte-critique-notification.json
# Exporter après modification : n8n export:workflow --id=<id> --output=/workflows/<nom>.json
```

## Epics

- **EP-09 [N8N]** : brancher FCM/SMTP réels (ou mocks), authentifier les webhooks, rendre les workflows rejouables.
- **EP-10 [OBS]** : Alertmanager appelle le webhook. Les playbooks Cyber (Fortinet) sont hors périmètre de ce dossier.
- Test E2E EP-09 : alerte critique injectée -> workflow déclenché -> email/FCM de test reçu (mock) en < 30 s.

## Bonnes pratiques locales

- Toujours ré-exporter le workflow dans le dépôt après modification dans l'interface (les JSON font foi).
- Vérifier avant commit : aucun `credentials` ni secret dans le JSON (`gitleaks` tourne en CI).
- Webhooks de production protégés (secret en en-tête) ; éditeur n8n non exposé publiquement.
