# ADR-0002 - Bridge MQTT site -> central avec persistance disque

- **Statut** : Proposé (à valider en S03, avant EP-05)
- **Date** : 2026-10-19
- **Décideurs** : LH, IG, WA
- **Zone / epic** : EDGE, INGEST (EP-05, EP-04)

## Contexte
Chaque site (8) a une passerelle LoRaWAN et un Mosquitto local. Le lien site -> central (VPN WireGuard) peut tomber pendant des heures. Exigences (CDC, ROADMAP §4.4 et §5.4b EP-05) :

- **zéro perte** de mesures après une coupure réseau de 15 minutes ou plus ;
- rattrapage d'une journée de données (38 400 mesures) en **moins de 2 minutes** après reprise ;
- alerte `gateway_offline` à 15 minutes ;
- aucun composant de plus que nécessaire (ressources limitées sur les passerelles).

Topics (ROADMAP §4.10) : `queenbee/{site}/{hive}/telemetry` (QoS 1), `.../status`, `queenbee/{site}/gw/heartbeat`, `queenbee/sim/cmd`, `queenbee/{site}/cmd/config` (rétention).

## Options envisagées
| Option | Avantages | Inconvénients |
|---|---|---|
| A - **Bridge Mosquitto** site -> central, QoS 1, `persistence true`, file disque | Aucun composant en plus ; bridge natif ; mise en tampon sur disque pendant la coupure ; reconnexion automatique | File bornée par le disque ; ordre non garanti entre topics ; dédoublonnage nécessaire côté ingestion |
| B - Un agent applicatif qui lit le Mosquitto local et poste en HTTPS sur l'API | Contrôle fin, retry applicatif | Code à écrire et exploiter ; duplique l'ingestion |
| C - RabbitMQ (federation / shovel) | Livraison robuste | Composant supplémentaire, plus gourmand en RAM |
| D - Kafka / Redpanda | Débit élevé | Disproportionné pour ~10 Mo/jour |

## Décision
Option **A** : bridge Mosquitto -> broker central, `bridge_protocol_version mqttv5` si supporté, QoS 1 sur la télémétrie, `cleansession false`, persistance activée, `queue_qos0_messages false`, taille de file bornée et surveillée. L'**idempotence** est garantie côté ingestion : clé `(hive_id, ts, seq)` et `INSERT ... ON CONFLICT DO NOTHING` (le QoS 1 peut dupliquer).

## Conséquences
- Positives : zéro composant en plus ; même mécanisme en mode Compose et K3s ; comportement testable avec `tc/netem`.
- Négatives : dépend de la taille du disque de la passerelle (dimensionner : 38 400 mesures x taille de trame x nombre de jours d'autonomie) ; rejeu massif à la reprise (limiter le débit du bridge pour ne pas saturer l'ingestion).
- Risques : saturation de la file (alerte `sync_queue_saturated`, runbook `docs/runbooks/sync-queue-saturated.md`) ; dérive d'horloge (utiliser `ts` de la trame, pas l'heure de réception).
- Sécurité : TLS + certificats par passerelle (ou VPN), ACL par site (un site ne publie que sous `queenbee/{son_site}/#`), pas d'accès anonyme. Détails avec l'équipe Cyber.
- Sobriété : pas d'audio brut, seulement un vecteur de features (~8 octets) ; échantillonnage adaptatif.

## Mise en œuvre et vérification
Ticket(s) EDGE/INGEST. Preuve : test E2E EP-05 - couper le réseau du site 15 min (netem) -> 0 perte, rattrapage d'une journée < 2 min, alerte `gateway_offline` à 15 min. Mesures de RAM/CPU de la passerelle en annexe.

## Références
`docs/diagrams/ingest-sequence.md` ; `docs/runbooks/gateway-offline.md`, `vpn-down.md`, `sync-queue-saturated.md` ; documentation Mosquitto (section bridges).
