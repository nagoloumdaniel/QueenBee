# Runbook - Passerelle hors ligne / site isolé

- **Alerte liée** : `GatewayOffline` (aucun heartbeat `queenbee/{site}/gw/heartbeat` depuis plus de 15 minutes) - TODO(KAN-xxx, OBS) : nom exact dans `monitoring/`
- **Sévérité** : élevée
- **Services concernés** : passerelle LoRaWAN du site, Mosquitto du site, bridge vers le central
- **Propriétaire** : (à renseigner) - **Dernier test du runbook** : jamais (à tester avec le simulateur : coupure de passerelle, UC-CY01)
- **Délai cible** : accusé < 15 min ; reprise sans perte de données (RTO < 8 h / RPO < 24 h, ROADMAP §4.4)

## Symptôme
L'alerte `gateway_offline` s'ouvre ; le panneau Grafana « Disponibilité sites/passerelles » montre le site en rouge ; les mesures des ruches du site cessent d'arriver. Les apiculteurs de ce site continuent de travailler hors ligne (l'app ne dépend pas de la passerelle). Faux positif possible : coupure du seul VPN (voir `vpn-down.md`) - dans ce cas la passerelle publie toujours en local.

## Diagnostic
1. Le site est-il le seul touché ? Panneau Grafana « Disponibilité » : si plusieurs sites tombent en même temps, suspecter le central ou le VPN (-> `vpn-down.md`).
2. Le VPN du site est-il actif ? Voir `vpn-down.md` (ping de l'adresse VPN du site, depuis le central).
3. Dernier heartbeat connu et métriques (batterie, CPU, RAM, `queue_depth`, `lora_loss_pct`) : table `gateway_heartbeat` ou panneau Grafana. Une batterie qui chute puis plus rien = coupure d'alimentation/solaire.
4. Le conteneur Mosquitto du site tourne-t-il ? (si accès au site) : `docker compose -f site.yml ps`, `docker compose -f site.yml logs --tail 100 mosquitto`.
5. Le simulateur est-il à l'origine de la panne (scénario `panne_passerelle`) ? Vérifier `GET /sim/status` avant d'escalader.

## Action
1. Si panne d'alimentation ou matériel : contacter le responsable local du site (coordinateur) pour contrôle sur place ; noter l'heure.
2. Si conteneur arrêté : le redémarrer (`docker compose -f site.yml up -d mosquitto`) puis surveiller la reprise du heartbeat.
3. Si le réseau du site est coupé : la passerelle passe en **mode dégradé** (stockage local, file disque). Ne rien purger : le bridge rattrapera.
4. À la reprise : vérifier la **resynchronisation sans perte** (nombre de mesures attendues vs reçues sur la période, `queue_depth` qui décroît, alerte fermée).
5. Fermer l'alerte (statut `resolved`) et consigner la durée de coupure.

## Escalade
- Après 1 h sans diagnostic, ou perte de données suspectée : prévenir l'administrateur DevOps (LH) puis l'équipe Cyber si doute sur une attaque (brouillage radio, sabotage : UC-CY03).
- Transmettre : site, serial de la passerelle, heure du dernier heartbeat, actions tentées. Pas de secrets ni de PII.

## Après l'incident
Mettre à jour ce runbook, mesurer RTO/RPO réels, ouvrir un ticket si la cause est structurelle (alimentation, câblage, taille de file).
