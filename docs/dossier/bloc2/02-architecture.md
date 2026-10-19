# 2. Architecture de la solution logicielle

> Dossier professionnel **Bloc 2** - EADL, spécialité Développement logiciel (RNCP38822, niveau 7).
> Pages attendues pour cette partie : **4 à 6** (hors annexes et bibliographie).
> Ce fichier est un **gabarit de rédaction** : le jury évalue uniquement le PDF final. Supprimer les encadrés de consigne (lignes commençant par `>`) avant la remise.

**Compétence visée** : **C2.1** - Élaborer l'architecture de l'application logicielle.

## Objectif
Concevoir et justifier l'architecture, la représenter avec un **langage de modélisation normalisé** et en démontrer la conformité aux exigences de **sécurité, d'accessibilité et de sobriété**.

## Question centrale
*Quelle architecture répond aux besoins, aux contraintes et à la sécurité, avec le moindre impact, et comment la rendre lisible à quelqu'un qui ne l'a pas construite ?*

## Critères d'évaluation du référentiel
| Réf. | Énoncé |
|------|--------|
| Ce2.1.1 | La schématisation de l'architecture de la solution logicielle répond aux spécifications techniques et fonctionnelles, ainsi qu'aux contraintes identifiées. |
| Ce2.1.2 | L'architecture de l'application logicielle répond aux cas d'utilisation identifiés et aux contraintes réglementaires et de sécurité. |
| Ce2.1.3 | Les langages de modélisations (ex. BPMN, UML) et les outils utilisés (ex. Draw.io) permettent de conceptualiser et visualiser clairement l'architecture de l'application. |
| Ce2.1.4 | L'architecture proposée est conformes aux exigences de sécurité et aux normes réglementaires. |
| Ce2.1.5 | La solution d'architecture logicielle proposée répond aux divers scénarios d'utilisation, et elle est adaptée aux personnes en situation de handicap (ex. compatibilité avec les lecteurs d'écran et les sous-titres) assurant ainsi une réponse adaptée et inclusive aux besoins de tous les utilisateurs. |
| Ce2.1.6 | L'architecture proposée permet de réduire l'impact environnemental de la solution (ex. pas de redondance inutile, utilisation de microservices, de la virtualisation et de la conteneurisation pour réduire l'utilisation des ressources, gestion dynamique des ressources, caching etc.). |

## Ce que le jury attend
Une architecture qui **découle des exigences** (cahier des charges, cas d'utilisation, contraintes), choisie **parmi des options comparées**, et représentée de façon claire et normalisée. La sécurité, l'inclusion et l'impact environnemental sont des **critères de choix** de l'architecture, et non des commentaires ajoutés après coup.

## Éléments à développer
1. Les exigences et contraintes qui structurent l'architecture, issues du cahier des charges (partie reliée au Bloc 1).
2. Les options d'architecture envisagées (monolithe modulaire, microservices, architecture pilotée par les événements), leur comparaison et le choix argumenté.
3. La représentation avec un langage de modélisation (UML, BPMN, autre) et un outil, et la façon dont ces schémas permettent de la lire sans explication orale.
4. La conformité aux exigences de sécurité et aux normes réglementaires, avec les mesures intégrées à l'architecture.
5. La réponse aux scénarios d'utilisation, y compris l'adaptation aux personnes en situation de handicap.
6. La réduction de l'impact environnemental (virtualisation, conteneurs, mise en cache, absence de redondance inutile) et l'arbitrage éventuel avec la performance.

## Preuves à renvoyer en annexe
Diagrammes d'architecture (composants, déploiement, séquence) ; journal des décisions d'architecture ; matrice cas d'utilisation / composants ; prototype de la solution.

## Support QueenBee
Architecture d'exploitation du cahier des charges (cloud central, zone de données, sites en périphérie, simulateur), flux de données du **chapitre VI**, fonctionnement hors ligne, **calcul local des caractéristiques acoustiques**. *Projet d'entreprise : architecture de l'application dont on a la charge, schémas anonymisés si nécessaire.*

## Où trouver la matière dans ce dépôt
- `docs/diagrams/` : contexte, ingestion, sync, états d'alerte, déploiement, ER (annexes).
- `docs/adr/` : journal des décisions d'architecture (0001 stack, 0002 bridge MQTT, 0003 sync offline, 0004 TimescaleDB).
- `ROADMAP.md` §1 (stack et alternatives écartées), §4.8, §5.7 (sécurité par couche).
- `docs/security/asvs-checklist.md`, `docs/accessibility/checklist.md`, `docs/eco-conception/checklist.md`.

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
