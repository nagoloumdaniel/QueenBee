# Runbook - <nom de l'alerte ou de la procédure>

- **Alerte liée** : `<NomAlerteAlertmanager>` (fichier de règle : `monitoring/...`)
- **Sévérité** : critique | élevée | moyenne | faible
- **Services concernés** : ...
- **Propriétaire** : (initiales) - **Dernier test du runbook** : AAAA-MM-JJ
- **Délai cible** : accusé de réception en X min, résolution en Y h (RTO/RPO si pertinent)

## Symptôme
Ce que l'on observe (alerte reçue, panneau Grafana, message d'un utilisateur). Impact pour les utilisateurs (apiculteurs, coordinateurs...). Comment distinguer un vrai incident d'un faux positif.

## Diagnostic
Étapes numérotées, de la plus rapide à la plus coûteuse. Pour chacune : commande copiable, résultat attendu, interprétation.

1. Vérifier ... : `commande`  -> attendu : ...
2. ...

Arbre de décision si utile (cause A -> action A, cause B -> action B).

## Action
Étapes de résolution **réversibles**. Marquer clairement tout geste destructif (⚠ demander un accord / faire une sauvegarde avant).

1. ...
2. Vérifier que l'alerte repasse au vert et que le panneau Grafana concerné revient à la normale.

## Escalade
Quand escalader (délai dépassé, cause inconnue, risque pour les données), à qui (rôle puis nom), par quel canal. Informations à fournir (heure, site, extraits de logs sans PII, actions déjà tentées).

## Après l'incident
- Noter l'incident (date, durée, cause, correction) ; ouvrir un ticket pour la cause racine.
- Mettre à jour ce runbook ; post-mortem sans blâme si sévérité élevée ou critique.
