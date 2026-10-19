# docs/runbooks

Un **runbook par alerte** (PLAYBOOK §7 OBS : « une alerte = un runbook »). Écrits pour une personne qui n'a pas construit le système et qui est de garde (ITIL : gestion d'incident).

| Runbook | Alerte Alertmanager liée | Sévérité | Use case |
|---|---|---|---|
| [gateway-offline.md](gateway-offline.md) | Heartbeat passerelle absent > 15 min | élevée | UC-CY01 |
| [vpn-down.md](vpn-down.md) | VPN site-central coupé > 5 min | élevée | UC-CY01 |
| [sync-queue-saturated.md](sync-queue-saturated.md) | File de synchronisation > seuil | moyenne | UC-T02 |
| [restore-database.md](restore-database.md) | (procédure, pas une alerte) restauration de la base | critique | EP-11 |
| [template.md](template.md) | modèle à copier | - | - |

Alertes du ROADMAP §6.1 **sans runbook encore** (à écrire par le ticket OBS) : erreurs 5xx, certificat < 14 jours, disque > 80 %, déploiement en échec.

## Règles d'écriture
1. Copier `template.md`, nommer le fichier avec le nom de l'alerte en `kebab-case`.
2. Quatre sections obligatoires : **Symptôme**, **Diagnostic**, **Action**, **Escalade**.
3. Commandes **copiables** et sûres : lecture seule d'abord, puis actions réversibles ; avertir avant toute action destructive.
4. Jamais de secret, mot de passe ni IP privée réelle (utiliser des variables : `$SITE`, `$GATEWAY_SERIAL`).
5. Toute alerte Prometheus a une annotation `runbook_url` qui pointe vers son fichier ici.
6. Après chaque incident : mettre à jour le runbook (post-mortem sans blâme, `engineering:incident-response`).
7. Tester le runbook en conditions réelles (simulateur : coupure de passerelle, `tc/netem`) et noter la date du dernier test.
