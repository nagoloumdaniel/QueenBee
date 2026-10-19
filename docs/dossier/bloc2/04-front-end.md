# 4. Développement front-end

> Dossier professionnel **Bloc 2** - EADL, spécialité Développement logiciel (RNCP38822, niveau 7).
> Pages attendues pour cette partie : **3 à 5** (hors annexes et bibliographie).
> Ce fichier est un **gabarit de rédaction** : le jury évalue uniquement le PDF final. Supprimer les encadrés de consigne (lignes commençant par `>`) avant la remise.

**Compétence visée** : **C2.3** - Piloter le développement front-end.

## Objectif
Piloter le développement de l'interface : choix d'outils et de frameworks, collaboration avec les métiers de la conception, ergonomie et accessibilité démontrées.

## Question centrale
*Comment l'interface permet-elle à chaque utilisateur, y compris en situation de handicap, d'accomplir sa tâche, et comment les choix techniques ont-ils été arbitrés ?*

## Critères d'évaluation du référentiel
| Réf. | Énoncé |
|------|--------|
| Ce2.3.1 | Les outils et les solutions de développement utilisés pour le front-end s'appuient sur la veille technologique des meilleures pratiques et standards actuels. |
| Ce2.3.2 | Les éléments graphiques, dynamiques et le design responsive de l'interface utilisateur intègrent avec succès les contributions d'autres professionnels (ex. web-designer, UX/UI designer) pour enrichir le projet et améliorer la qualité du produit final. |
| Ce2.3.3 | L'application intègre l'ensemble des dernières évolutions des outils et techniques de développement front-end, en utilisant des langages spécifiques tels que HTML5, CSS3, JavaScript, et en mettant à jour et appliquant les meilleures pratiques et standards actuels dans le développement front-end. |
| Ce2.3.4 | L'utilisation des bibliothèques de fonctions et de frameworks (ex. ReactJS, AngularJS, VueJS) répond aux besoins spécifiques du projet et améliore la fonctionnalité et l'interactivité des applications. |
| Ce2.3.5 | L'interface propose une navigation fluide, ergonomique, intuitive et inclusive, et elle est accessible à tous, y compris aux personnes en situation de handicap (ex. sous-titres, transcriptions, etc.). |

## Ce que le jury attend
Des choix techniques **fondés sur la veille**, une interface **testée par des utilisateurs** et une accessibilité **démontrée par un audit**, non affirmée.

## Éléments à développer
1. Les outils et frameworks retenus, justifiés par la veille et les besoins.
2. La collaboration avec les autres professionnels (designer, ergonome) : maquettes, retours.
3. Les langages et standards (HTML5, CSS3, JavaScript) et le design adaptatif.
4. L'ergonomie et la fluidité de la navigation, vérifiées auprès d'utilisateurs.
5. L'accessibilité : référentiel retenu, audit réalisé, corrections apportées.

## Preuves à renvoyer en annexe
Maquettes et captures de l'interface ; rapport d'audit d'accessibilité ; compte rendu de tests utilisateurs ; extraits de code d'un composant.

## Support QueenBee
**L'orientation DevOps limite le développement d'interface** ; la compétence doit être démontrée sur l'**application terrain hors ligne (UC-A01 à UC-A03)** ou le **tableau de bord de l'administrateur**, **après accord du tuteur**. *Projet d'entreprise : interface de l'application, captures anonymisées ; c'est le recours si QueenBee ne permet pas de la démontrer.*

> **Point d'attention majeur** : la spécialité Dev étant orientée DevOps, la compétence C2.3 n'est pas couverte naturellement par le périmètre du cahier des charges. **Obtenir l'accord du tuteur** pour la démontrer sur un livrable d'interface précis (app terrain offline ou dashboard admin). Voir C.6 du cahier des charges et la décision ouverte n°4 du ROADMAP §9.

## Où trouver la matière dans ce dépôt
- `apps/web/` (Next.js : landing, dashboard) et `apps/mobile/` (Flutter : app terrain offline).
- Design system et maquettes : `ROADMAP.md` §4.7 ; tokens dans `apps/web/src/app/globals.css` et `apps/mobile/lib/core/theme/tokens.dart`.
- `docs/accessibility/checklist.md` : audit WCAG 2.2 AA / RGAA 4.1 (axe-core + TalkBack).
- `apps/web/tests/e2e/` et `apps/mobile/integration_test/`.
- Rapport de tests utilisateurs (5 personnes) : à produire.

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
