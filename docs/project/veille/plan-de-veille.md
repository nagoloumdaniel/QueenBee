# Plan de veille technologique

> Compétence C1.2 (Bloc 1, partie 3). Le jury attend une veille **pensée pour le projet** et surtout la preuve que **l'analyse a modifié ou confirmé des choix**. Une liste de sites suivis ne démontre rien. Ce fichier est l'annexe « plan de veille » (sujet, sources, outil, fréquence, responsable).

## Objectifs (déduits des contraintes du projet)
Éviter de construire sur des choix dépassés ou ignorants des alternatives. Questions de veille précises (ROADMAP §4.3) :

| # | Sujet | Question de veille | Décision que cela peut influencer |
|---|---|---|---|
| V1 | Edge / offline sync | Quelles approches fiables de sync hors ligne (CRDT, outbox, backends de sync) ? | ADR-0003 |
| V2 | MQTT bridge | Mosquitto/EMQX : persistance, bridge MQTT 5, limites de file ? | ADR-0002 |
| V3 | TimescaleDB | Compression, agrégats continus, licences, versions Postgres 16 ? | ADR-0004 |
| V4 | K3s vs Docker Compose | Empreinte mémoire, alternatives légères (k0s, MicroK8s) sur petites passerelles ? | ADR-0001, R3 |
| V5 | DevSecOps / Snyk | Évolutions de Snyk, Trivy, Checkov, SBOM, signature cosign ? | CI/CD |
| V6 | n8n | Versions, sécurité des workflows, alternatives ? | EP-09 |
| V7 | LoRaWAN | Évolutions du protocole, sécurité, brouillage ? | EDGE, Cyber |
| V8 | Éco-conception | Référentiels (GR491, RGESN), outils de mesure d'empreinte ? | eco-conception |
| V9 | Concurrents | Arnia, BeeHero, Hive-Tech, 3Bee, Apis Prime : fonctions, prix, modèle ? | périmètre, différenciation |

## Dispositif
| Sujet | Sources | Outil | Fréquence | Responsable | Diffusion |
|---|---|---|---|---|---|
| V1-V3 | Documentation officielle, blogs d'ingénierie, Postgres Weekly | Feedly / RSS | 1 h/semaine | (à assigner) | Slack équipe + CR |
| V4-V5 | CNCF newsletter, releases GitHub (Snyk, Trivy, K3s) | GitHub releases (watch), RSS | 1 h/semaine | (à assigner) | Slack équipe |
| V6-V7 | Notes de version n8n, The Things Network, LoRa Alliance | Google Alerts, newsletters | 1 h/semaine | (à assigner) | Slack équipe |
| V8 | Référentiels publics (RGESN, GR491), publications ADEME/INR | Google Alerts | mensuelle | (à assigner) | Slack équipe |
| V9 | Sites et documentations des concurrents, publications | tableau comparatif | mensuelle | (à assigner) | Slack équipe |

## Méthode de tri
Pour chaque information : **pertinence** (impact sur une décision du projet : oui/non) -> **fiabilité** de la source -> **fraîcheur** -> action (ignorer, noter, comparer, proposer une décision). Seules les informations pertinentes passent dans un compte rendu.

## Comptes rendus
Au moins **deux** comptes rendus de veille, dont **un rédigé en français à partir de sources anglophones** (anglais technique). Modèle : [compte-rendu-template.md](compte-rendu-template.md).

| N° | Date | Sujet | Langue des sources | Décision influencée | Fichier |
|---|---|---|---|---|---|
| CR-01 | | | | | |

## Tableau comparatif de solutions / concurrents (à compléter)
| Critère | QueenBee (cible) | Arnia | BeeHero | Hive-Tech | 3Bee | Apis Prime |
|---|---|---|---|---|---|---|
| Capteurs (poids, T°, hygrométrie, acoustique, GPS) | | | | | | |
| Fonctionnement hors ligne / faible connectivité | | | | | | |
| Public cible / modèle économique | | | | | | |
| Ouverture / données / souveraineté | | | | | | |
| Prix (si public) | | | | | | |
| Source et date de consultation | | | | | | |

> Ne renseigner que des informations **sourcées et datées** : aucune donnée inventée.

## Exemple de bout en bout (à rédiger pour le dossier)
Information repérée -> analyse -> décision -> trace (ADR / ticket) : ...
