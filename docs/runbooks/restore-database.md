# Runbook - Restauration de la base de données

- **Alerte liée** : aucune (procédure de reprise après sinistre ; déclenchée par décision humaine). Alerte associée : échec de la sauvegarde quotidienne - TODO(KAN-xxx, OBS)
- **Sévérité** : critique
- **Services concernés** : PostgreSQL/PostGIS/TimescaleDB central, API, ingestion
- **Propriétaire** : (à renseigner) - **Dernier test de restauration** : jamais (à tester **chaque mois**, EP-11)
- **Cibles** : **RTO < 8 h**, **RPO < 24 h** (ROADMAP §4.4) ; à mesurer lors de la démonstration chronométrée

## Symptôme
Base corrompue, supprimée par erreur, disque détruit, VM perdue, ou migration défaillante. L'API renvoie des erreurs 5xx sur toutes les routes de données ; `/ready` est en échec.

## Diagnostic
1. Confirmer l'étendue : base inaccessible, ou seulement certaines tables/données ? (`/health` vs `/ready`, logs de l'API et de Postgres.)
2. **Ne rien écraser avant d'avoir copié l'état actuel** (volume, dump partiel) si la base répond encore, même mal.
3. Identifier la dernière sauvegarde saine : fichier `pg_dump` chiffré quotidien + archives WAL ; date, taille, empreinte (somme de contrôle) ; copie **hors VM** disponible ?
4. Décider du point de restauration (dernier dump, ou PITR avec WAL jusqu'à une heure précise avant l'incident).

## Action
⚠ Une restauration remplace des données : travailler d'abord sur une **base de test**, valider, puis basculer. Jamais de migration ou suppression destructive sans accord et sans restauration vérifiée.

1. Mettre l'API en maintenance (arrêter l'ingestion et l'API pour éviter les écritures concurrentes) : `docker compose -f central.yml stop api ingest`.
2. Récupérer la sauvegarde (copie hors VM si la VM est perdue) et la **déchiffrer** avec la clé stockée dans le coffre de secrets (SOPS/age) - ne jamais afficher la clé.
3. Recréer une instance PostgreSQL avec **les mêmes extensions** (PostGIS, TimescaleDB, pgcrypto, citext) et la même version majeure (16).
4. Restaurer (dump) : `pg_restore --clean --if-exists --no-owner -d <base> <fichier>` ; pour du PITR : restaurer la sauvegarde de base puis rejouer les WAL jusqu'à l'heure cible. Les commandes exactes sont dans `infra/` (rôle Ansible de sauvegarde) - TODO(KAN-xxx, EP-11).
5. **Vérifier l'intégrité** : comptes attendus (sites, ruches, utilisateurs), dernière mesure, politiques Timescale (compression/rétention), RLS actives, contraintes ; lancer les tests de fumée (`/ready`, un parcours E2E).
6. Redémarrer l'ingestion puis l'API ; les passerelles rejouent leur file (idempotence) pour combler la période manquante.
7. Chronométrer : heure de début, heure de reprise (RTO) ; écart entre la dernière donnée restaurée et l'incident (RPO).

## Escalade
- Dès la décision de restaurer : informer l'administrateur DevOps (LH) et l'équipe pédagogique (commanditaire).
- Si la sauvegarde est introuvable ou corrompue : incident majeur - escalade immédiate, ne rien supprimer.
- Fournir : heure de l'incident, état constaté, sauvegardes disponibles (dates/tailles), actions déjà faites.

## Après l'incident
Post-mortem sans blâme ; consigner RTO/RPO mesurés dans le journal de décisions et le dossier (annexe) ; corriger la cause (sauvegarde, droits, procédure) ; planifier le prochain test mensuel.
