# docs/dossier

Matière des deux **dossiers professionnels** (jury EADL, RNCP38822 niveau 7) : Bloc 1 (planifier et organiser) et Bloc 2 (concevoir et développer). Source : `cahier de charge.md` Partie B (gabarits d'évaluation).

```
dossier/
├─ bloc1/   00 page de garde · 01 à 10 parties · bibliographie · annexes/
└─ bloc2/   00 page de garde · 01 à 08 parties · bibliographie · annexes/
```

Chaque fichier de partie contient : titre, compétence visée, **question centrale**, **critères d'évaluation Ce\*.\***, ce que le jury attend, **éléments à développer**, preuves à mettre en annexe, support QueenBee, **où trouver la matière dans ce dépôt**, et une zone `## Rédaction` à remplir.

## Ce que le dossier est (et n'est pas)
Un travail à la fois **professionnel** (situation réelle, rôle assumé, décisions et résultats mesurés), **académique** (problématique, démarche, choix comparés, sources, regard critique) et **technique** (preuves vérifiables). Ce n'est **ni un tutoriel**, ni une liste d'outils, ni un compte rendu chronologique (« d'abord, puis, ensuite ») : il est organisé **par problèmes à résoudre**. Chaque affirmation doit pouvoir être défendue à l'oral.

## Règles de rédaction
1. **Prose structurée** : *situation, problème, options, choix, preuve résumée, résultat, limite*.
2. **Test du « parce que »** : après chaque affirmation technique, on doit pouvoir écrire « parce que » ou « ce qui a permis de », avec renvoi à une annexe.
3. **Première personne** pour les décisions, **justifiées par rapport à des alternatives écartées**.
4. Terminer chaque partie par **une limite assumée et une perspective**.
5. **Texte vs annexes** : le corps contient ce qui permet de juger le raisonnement ; tout ce qui permet de **reproduire** (code, configurations, journaux complets, captures) va en **annexe** et est cité par son numéro (« annexe A3, p. 2 »).
6. Un lecteur professionnel non spécialiste de l'outil doit pouvoir suivre le fil.
7. Chiffres : toujours sourcés (annexe, mesure, cahier des charges). **Aucune donnée inventée**.
8. Les gabarits donnent des exemples « insuffisant » vs « attendu » (cahier des charges B.1.5 à B.1.7) : s'en inspirer, ne pas les recopier.
9. « La qualité de l'argumentation et la rigueur de l'analyse priment sur le volume. »

## Modèles de renvois (communs)
| Élément | Forme attendue |
|---|---|
| Renvoi à une annexe | ...le pipeline bloque la fusion en cas d'échec (annexe A3, p. 2). |
| Légende de figure | Figure 2 - Chronologie de traitement d'un incident (source : auteur, 2027). |
| Citation dans le texte | ...conformément aux recommandations de l'organisme de référence [2]. |
| Entrée de bibliographie | [2] ORGANISME ou AUTEUR, Titre du document, année, adresse web, consultée le jj/mm/aaaa. |
| Ligne d'index des annexes | A3 - Configuration du pipeline (extrait commenté) - renvoi : partie 3 - page 41. |

## Volumes (hors annexes et bibliographie)
| Bloc 1 | Pages | Bloc 2 | Pages |
|---|---|---|---|
| 1. Introduction | 1-2 | 1. Introduction | 1-2 |
| 2. Étude de faisabilité | 3-5 | 2. Architecture | 4-6 |
| 3. Plan de veille | 2-4 | 3. Intégrité et qualité du code | 3-5 |
| 4. Cahier des charges fonctionnel | 3-5 | 4. Front-end | 3-5 |
| 5. Feuille de route | 2-4 | 5. Back-end | 3-5 |
| 6. Mise en place | 2-4 | 6. Données à grande échelle | 3-5 |
| 7. Mesure de la performance | 2-3 | 7. Compétences transversales | 1-2 |
| 8. Supervision et contrôle | 2-3 | 8. Conclusion et bilan | 1-2 |
| 9. Compétences transversales | 1-2 | | |
| 10. Conclusion et bilan | 1-2 | | |
| **Total** | **19 à 34** | **Total** | **19 à 32** |

Introductions : prose de **300 à 500 mots**.

## Compétences transversales (dans chaque bloc)
- **Anglais technique** : compte rendu de veille rédigé en français à partir de sources anglophones citées ; références anglophones ; capacité à échanger en anglais à l'entretien.
- **Numérique responsable** : éco-conception appliquée, estimation ou mesure de l'impact, arbitrage performance/sobriété, référentiels en vigueur.
Indiquer dans la partie « Compétences transversales » où chaque preuve se trouve (partie, annexe, page).

## Support du dossier
Le support retenu est **QueenBee** (plateforme de suivi de ruches connectées de BeeAfrica : 3 pays, 8 sites, ~400 ruches). Le choix doit être validé avec le tuteur avant la rédaction ; pour **C2.3 (front-end)**, un accord du tuteur est nécessaire (voir `bloc2/04-front-end.md`).

## Remise
- **PDF natif** nommé `NOM_Prenom_BLOC[N]_DEV_2027.pdf` (ex. `DUPONT_Marie_BLOC1_DEV_2027.pdf`, `DUPONT_Marie_BLOC2_DEV_2027.pdf`).
- Remis à l'équipe pédagogique **2 à 4 semaines avant la soutenance** (un dossier hors délai peut entraîner le report). Calendrier : `docs/jira/PLAYBOOK.md` (soutenance au plus tard le 2027-06-14).
- Contenu du PDF : page de garde, table des matières **mise à jour**, parties rédigées, bibliographie, annexes. **Supprimer** les pages pédagogiques et les encadrés de consigne.
- Annexes numérotées A1, A2..., chacune citée dans le texte, avec « ce qu'elle démontre » (index : `bloc*/annexes/README.md`). **Une seule norme de citation** pour toute la bibliographie.
- Soutenance : 20 minutes de présentation + 20 minutes d'entretien avec le jury.

## Fabriquer le PDF
Assembler les fichiers dans l'ordre (page de garde, parties, bibliographie, annexes) puis exporter, par exemple avec le skill `markdown-to-pdf` ou Pandoc :
```bash
# Exemple (à adapter) : concaténer puis convertir
cat bloc1/0*.md bloc1/10-conclusion.md bloc1/bibliographie.md > /tmp/bloc1.md
pandoc /tmp/bloc1.md -o NOM_Prenom_BLOC1_DEV_2027.pdf --toc
```
Ne pas committer les PDF contenant des données personnelles ; vérifier l'anonymisation des annexes.

## Rôle de chacun
Chaque étudiant rédige **son propre dossier** (les parties s'appuient sur le travail commun du dépôt). Les écarts et décisions sont consignés **dès S01** dans `docs/project/deviation-journal.md` et `docs/project/decision-log.md` : c'est la matière directe de Bloc 1 parties 6 à 8.
