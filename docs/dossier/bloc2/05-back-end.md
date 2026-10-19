# 5. Développement back-end

> Dossier professionnel **Bloc 2** - EADL, spécialité Développement logiciel (RNCP38822, niveau 7).
> Pages attendues pour cette partie : **3 à 5** (hors annexes et bibliographie).
> Ce fichier est un **gabarit de rédaction** : le jury évalue uniquement le PDF final. Supprimer les encadrés de consigne (lignes commençant par `>`) avant la remise.

**Compétence visée** : **C2.4** - Piloter le développement back-end.

## Objectif
Piloter le développement du serveur, des bases de données, des interfaces de programmation et du back-office, selon des normes de sécurité et dans une démarche de numérique responsable.

## Question centrale
*Comment le serveur, les données et les interfaces de programmation assurent-ils le fonctionnement attendu, la sécurité et la sobriété ?*

## Critères d'évaluation du référentiel
| Réf. | Énoncé |
|------|--------|
| Ce2.4.1 | L'application back-end répond aux objectifs et aux contraintes techniques identifiées. |
| Ce2.4.2 | Le back-office permet la gestion de l'application dans le respect du cahier des charges et la liaison avec le front-end est assurée par APIs. |
| Ce2.4.3 | Les outils, technologies et langages objet (Python, Java ou Node.js) sont correctement mis en œuvre pour répondre aux besoins spécifiques du projet et en les utilisant pour développer des solutions back-end robustes et conformes aux normes de sécurisation. |
| Ce2.4.4 | La configuration des serveurs et des bases de données permet de répondre aux objectifs et contraintes du projet, et d'assurer la sécurité des données. |
| Ce2.4.5 | Les standards techniques, les normes de sécurisation (ex. W3C, OWASP) et les conformités réglementaires (ex. RGPD) sont respectés. |
| Ce2.4.6 | Les choix d'implémentation garantissent une utilisation efficace des ressources et permet de minimiser l'impact environnemental dans le cadre d'un développement numérique responsable (ex. code efficace et optimisé, gestion dynamique des ressources, caching etc.). |

## Ce que le jury attend
Un back-end qui répond aux objectifs et contraintes identifiés, des **choix de technologies justifiés**, une **sécurité vérifiée par des tests** et non par déclaration, et une attention aux ressources consommées. La liaison avec le front-end par interface de programmation doit être **documentée**.

## Éléments à développer
1. Les objectifs et contraintes techniques, et les choix de langage, de technologies et de système de gestion de données qui en découlent.
2. Les interfaces de programmation : contrat, documentation, liaison avec le front-end, et le back-office de gestion de l'application.
3. La configuration des serveurs et des bases de données et les mesures qui assurent la sécurité des données.
4. Le respect des standards techniques, des normes de sécurisation (W3C, OWASP) et de la réglementation (RGPD), avec les vérifications effectuées.
5. Les choix d'implémentation qui limitent la consommation de ressources (code optimisé, mise en cache, gestion dynamique) et leur mesure.
6. La collaboration avec les autres équipes (front-end, infrastructure, données).

## Preuves à renvoyer en annexe
Contrat d'interface de programmation documenté ; schéma de la base de données ; extraits de code commentés ; rapport de tests de sécurité ; mesures de performance.

## Support QueenBee
**Interface de programmation technique minimale** (santé, points d'accès techniques), **authentification et rôles (UC-T01)**, **synchronisation différée** entre sites et serveur central. *Projet d'entreprise : services dont on a la charge.*

## Où trouver la matière dans ce dépôt
- `apps/api/` (FastAPI) ; contrat : `docs/openapi.yaml` (OpenAPI 3.1).
- `db/` (schéma, migrations, seeds) ; `docs/data-dictionary.md` ; `docs/diagrams/er.md`.
- `docs/security/asvs-checklist.md` (tests de sécurité), rapports ZAP/Snyk en annexe.
- `ROADMAP.md` §4.9 (modèle de données), §4.10 (contrat d'API), §5.7 (sécurité).
- Mesures : API p95 < 500 ms (k6), consommation CPU/RAM (cAdvisor).

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
