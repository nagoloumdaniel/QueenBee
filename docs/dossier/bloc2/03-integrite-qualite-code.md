# 3. Intégrité et qualité du code

> Dossier professionnel **Bloc 2** - EADL, spécialité Développement logiciel (RNCP38822, niveau 7).
> Pages attendues pour cette partie : **3 à 5** (hors annexes et bibliographie).
> Ce fichier est un **gabarit de rédaction** : le jury évalue uniquement le PDF final. Supprimer les encadrés de consigne (lignes commençant par `>`) avant la remise.

**Compétence visée** : **C2.2** - Préparer l'intégrité du code.

## Objectif
Préparer un développement sûr et maîtrisé : outils, indicateurs de qualité, listes de contrôle, sécurité et conformité intégrées dès le début du cycle.

## Question centrale
*Quelles règles et quels contrôles donnent confiance dans le code dès qu'il est écrit, et pas seulement au moment de la livraison ?*

## Critères d'évaluation du référentiel
| Réf. | Énoncé |
|------|--------|
| Ce2.2.1 | Les processus et les outils à mettre en place pour intégrer la sécurité du code dès le début du cycle de développement (**shift-left**) sont clairement spécifiés. |
| Ce2.2.2 | Les indicateurs de référence définis permettent de garantir continuellement la qualité du code. |
| Ce2.2.3 | Les listes de contrôle permettent d'assurer la complétude, la conformité, l'intégrité et la qualité du code tout au long du processus de développement. |
| Ce2.2.4 | Les exigences attendues sur la sécurité dans le développement et la confidentialité du code source, ainsi que le respect réglementaire des normes (ITIL, RGPD) sont intégrés dans le cadre du projet tout au long du processus de développement. |
| Ce2.2.5 | Les outils et les fonctionnalités collaboratives de versionning (ex. GitHub) sont clairement précisés et permettent de gérer les versions et les mises à jour et d'éviter les conflits. |
| Ce2.2.6 | Les bonnes pratiques de codage établies permettent l'identification précoce des vulnérabilités, la réduction du temps de mise en production et une gestion des performances adéquate. |

## Ce que le jury attend
Des règles **réellement appliquées**, des **indicateurs chiffrés assortis de seuils** et une sécurité traitée **dès l'écriture du code**, justifiées par les risques qu'elles couvrent.

## Éléments à développer
1. La gestion des versions : outils, branches, revue de code, conflits.
2. Les indicateurs de qualité du code (couverture, complexité, dette) et leurs seuils.
3. Les listes de contrôle (définition de fini, revue, sécurité) et ce qu'elles garantissent.
4. La sécurité dès le début du cycle (analyse statique, dépendances, secrets).
5. Le respect des normes et de la réglementation dans le processus (RGPD, ITIL).
6. Les bonnes pratiques de codage et leur effet sur les vulnérabilités, les performances et le délai de mise en production.

## Preuves à renvoyer en annexe
Règles de contribution et de revue ; listes de contrôle ; rapport d'analyse statique et de contrôle des dépendances ; extrait d'historique de revue de code.

## Support QueenBee
Dépôt et pipelines de la spécialité, **contrôle Snyk** des dépendances et des conteneurs avant déploiement (chapitres V et VI). *Projet d'entreprise : règles de l'équipe, avec ce qui est de son fait.*

## Où trouver la matière dans ce dépôt
- `CONTRIBUTING.md`, `.github/pull_request_template.md`, `.github/CODEOWNERS`, `.pre-commit-config.yaml`.
- `.github/workflows/` : pipeline CI/CD (lint, tests, Snyk, Trivy, Gitleaks, couverture >= 80 %).
- `docs/jira/PLAYBOOK.md` : Definition of Done, normalisation des branches, revue croisée.
- `docs/security/asvs-checklist.md` ; `docs/compliance/grille-conformite.md`.
- `ROADMAP.md` §5.2, §5.2b, §5.3, §5.5, §5.6.

## Règles de rédaction rappelées
- Prose argumentée : *situation, problème, options, choix, preuve résumée, résultat, limite*. Première personne pour les décisions.
- Après chaque affirmation technique : « parce que » / « ce qui a permis de » + renvoi à une annexe numérotée (A1, A2...).
- Pas de tutoriel ni de liste d'outils dans le corps : commandes, configurations et captures vont en annexe.
- Terminer par une **limite assumée** et une **perspective**.
- Voir `docs/dossier/README.md` pour le détail.

## Avancement
- [ ] Plan détaillé écrit
- [ ] Premier jet rédigé
- [ ] Annexes citées et numérotées
- [ ] Relu (relecteur désigné : ...)
- [ ] Volume dans la fourchette

## Rédaction

<!-- TODO(DOSSIER) : rédiger ici la partie, en prose. -->
