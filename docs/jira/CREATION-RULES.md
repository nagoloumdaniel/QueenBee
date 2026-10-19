# Règles de création des tickets Jira (pour les agents)

Outil : `mcp__claude_ai_Atlassian_MCP__createJiraIssue` (charger via ToolSearch `select:mcp__claude_ai_Atlassian_MCP__createJiraIssue,mcp__claude_ai_Atlassian_MCP__searchJiraIssuesUsingJql`).
Constantes : cloudId `d33f2af0-a3ff-4ef6-b3ff-783be3614f57` · projectKey `KAN` · issueType `Tâche` · exemple réussi : KAN-19 (T001).

## Paramètres de chaque appel
- `summary` : `[ZONE] Titre` (titre de la spec, ne rien changer).
- `parent` : clé de l'epic (voir ligne « Epics Jira » de docs/jira/backlog-spec.md).
- `assignee` : accountId — LH `6403031c93cf2599462f0b3e`, IG `712020:48221cd5-77a3-4b41-a7ac-0d8881bc4718`, WA `712020:141ff312-954d-45c3-82d2-33eb5ef1e953`.
- `priority` : H→`High`, M→`Medium`, L→`Low` ; tous les tickets de l'EP-03 → `Highest`.
- `labels` : `["Sxx","ZONE","EP-nn","Tnnn","tmax-<h>h"]` (exemple `["S03","DB","EP-04","T070","tmax-3h"]`).
- `additional_fields` : `{"duedate":"<fin du sprint>","Date de début":"<début du sprint>"}`. NE PAS passer `timetracking` (inexistant dans ce projet).
- Dates de sprint (début → fin) : S01 2026-10-20→2026-11-02 · S02 11-03→11-16 · S03 11-17→11-30 · S04 12-01→12-14 · S05 12-15→12-28 · S06 2026-12-29→2027-01-11 · S07 2027-01-12→01-25 · S08 01-26→02-08 · S09 02-09→02-22 · S10 02-23→03-08 · S11 03-09→03-22 · S12 03-23→04-05 · S13 04-06→04-19 · S14 04-20→05-03 · S15 05-04→05-17 · S16 05-18→05-31 · S17 06-01→06-11.
- Relecteur : LH→IG, IG→WA, WA→LH. Noms : Land Hack, Ibrahima Gueye, Wissam Ait El Hadii.

## Description (markdown, en français, détaillée et actionnable)
Structure exacte :
```
**Réf backlog** : Tnnn · Epic : EP-nn <nom> · Sprint : Sxx · Échéance : <date>
**Responsable** : <nom> · **Relecteur** : <nom> · **Temps max** : <h> h (au-delà : stop, commenter, voir PLAYBOOK §4)

## Objectif
(1–2 phrases : pourquoi cette tâche, quel résultat visible)
## Détails à réaliser
(4 à 8 étapes numérotées, concrètes : fichiers/dossiers du squelette du dépôt à toucher — ex. apps/api/app/routers/auth.py, db/schema/reference.sql, infra/ansible/roles/... —, commandes ou valeurs clés du CDC/ROADMAP)
## Critères d'acceptation
(3 à 5 cases `- [ ]` mesurables, avec chiffres quand le CDC en donne)
## Test E2E / preuve à fournir
(le test à écrire AVANT le code, nom de fichier attendu, ce qu'il vérifie, et la preuve jointe à la PR)
## Bonnes pratiques de cette tâche
(3 à 5 puces : 2 tirées de docs/jira/PLAYBOOK.md §7 pour la zone, 1–3 spécifiques à cette tâche)
## Skills Claude Code
(liste PLAYBOOK §8 pour la zone + 1 skill spécifique si pertinent ; rappeler caveman)
## Branche / commit / PR
(Branche exacte `<type>/EP-<nn>-<slug>` ; commit exact `type(zone): message (KAN-xx)` ; PR vers main, relecteur nommé ; merge par LH)
## Dépendances
(IDs Tnnn qui doivent être finis avant, ou « aucune »)
## Si bloqué
Voir docs/jira/PLAYBOOK.md §4 (time-box) et §6 (Definition of Done). Commenter le ticket à 80 % du temps.
```
Le contenu doit être spécifique à la tâche (pas de remplissage générique). Lire d'abord docs/jira/PLAYBOOK.md, docs/jira/backlog-spec.md et, si besoin, ROADMAP.md / 'cahier de charge.md' pour les chiffres exacts.

## Procédure
1. Pour chaque ID de ta tranche : `searchJiraIssuesUsingJql` avec `project = KAN AND labels = Tnnn` ; s'il existe déjà, ne pas recréer.
2. Créer le ticket. En cas d'erreur de champ, lire le repairHint, corriger, réessayer une fois. Ne jamais créer en double.
3. Ne rien modifier d'autre dans Jira (pas de transition, pas de suppression, pas d'epic).
4. Rendre à la fin un tableau compact `Tnnn → KAN-xx` et la liste des échecs. Aucune autre sortie.
