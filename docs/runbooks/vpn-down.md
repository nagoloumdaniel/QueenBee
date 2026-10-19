# Runbook - VPN site-central coupé

- **Alerte liée** : `VpnTunnelDown` (tunnel WireGuard site <-> central inactif depuis plus de 5 minutes) - TODO(KAN-xxx, OBS) : nom exact dans `monitoring/`
- **Sévérité** : élevée
- **Services concernés** : liaison site-central (bridge MQTT, déploiements Ansible, métriques)
- **Propriétaire** : (à renseigner) - **Dernier test du runbook** : jamais
- **Délai cible** : accusé < 15 min ; rétablissement < 4 h

## Symptôme
Alerte VPN down ; métriques du site absentes de Prometheus ; le bridge MQTT du site n'est plus connecté au broker central ; les déploiements Ansible vers ce site échouent. Les mesures s'accumulent dans la file disque du site (pas de perte tant que le disque n'est pas plein).

## Diagnostic
1. Un seul site ou tous ? Tous -> problème côté central (pare-feu, UDP WireGuard, VM). Un seul -> côté site.
2. Depuis le central, vérifier le dernier handshake du pair du site : `sudo wg show` (champ `latest handshake` ; > 3 min = tunnel inactif).
3. Le port UDP WireGuard est-il joignable (pare-feu Oracle Cloud, règle de sécurité) ? Vérifier les règles Terraform/Ansible (`infra/`).
4. Côté site (si accès) : `sudo wg show`, état du réseau (`ip a`, passerelle internet), l'IP publique a-t-elle changé (IP dynamique) ?
5. Horloge : un décalage important casse parfois le handshake -> vérifier NTP.

## Action
1. Redémarrer l'interface côté site : `sudo systemctl restart wg-quick@wg0` (le nom de l'interface dépend de la configuration Ansible).
2. Si l'IP publique du site a changé : mettre à jour le pair côté central **via Ansible** (jamais à la main) puis rejouer le rôle.
3. Si la clé est suspectée compromise : ne pas la réutiliser, la régénérer et la redéployer via le coffre de secrets (SOPS) - prévenir l'équipe Cyber.
4. Une fois le tunnel remonté : vérifier la reconnexion du bridge MQTT et le **rattrapage** de la file (`sync-queue-saturated.md` si elle ne se vide pas).
5. Vérifier que l'alerte repasse au vert.

## Escalade
- Panne > 4 h, ou plusieurs sites : administrateur DevOps (LH), puis équipe Cyber (hypothèse de filtrage/attaque).
- Fournir : site(s), heure de début, sortie de `wg show` **sans clés**, actions déjà tentées.

## Après l'incident
Documenter la cause, vérifier qu'aucune donnée n'a été perdue, ajouter un test de résilience (`tc/netem`) si la cause est reproductible.
