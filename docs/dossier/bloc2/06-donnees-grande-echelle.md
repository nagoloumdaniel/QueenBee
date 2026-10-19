# 6. Traitement des données à grande échelle

> Dossier professionnel **Bloc 2** - EADL, spécialité Développement logiciel (RNCP38822, niveau 7).
> Pages attendues pour cette partie : **3 à 5** (hors annexes et bibliographie).
> Ce fichier est un **gabarit de rédaction** : le jury évalue uniquement le PDF final. Supprimer les encadrés de consigne (lignes commençant par `>`) avant la remise.

**Compétence visée** : **C2.5** - Coordonner le développement de solutions de traitement de données à grande échelle.

## Objectif
Coordonner le développement des solutions de collecte, de traitement, de stockage et d'analyse de données à grande échelle, et justifier les choix technologiques.

## Question centrale
*Comment collecter, stocker et exploiter à grande échelle les données de la solution pour en tirer une valeur d'usage, et pourquoi ces technologies ?*

## Critères d'évaluation du référentiel
| Réf. | Énoncé |
|------|--------|
| Ce2.5.1 | La mise en œuvre de la collecte et du traitement par lot ou en temps réel des données par des outils technologiques (ex. Open Refine, Nifi, Apache Spark ou Storm) permet de répondre aux contraintes techniques et fonctionnelles du projet. |
| Ce2.5.2 | La mise en œuvre du stockage de données massives structurées ou non structurées, dans des bases de données analytiques ou opérationnelles, permet de répondre aux contraintes techniques et fonctionnelles du projet, et d'assurer la sécurité et l'intégrité des données. |
| Ce2.5.3 | La mise en œuvre d'analyses descriptives et prédictives sur des données massives, y compris l'utilisation de techniques de machine learning, permettent d'extraire de la valeur de la donnée de manière innovante et de répondre aux objectifs et contraintes du projet. |
| Ce2.5.4 | Les choix technologiques, les frameworks et les outils utilisés tout au long du projet sont présentés clairement, de manière argumentée, pour démontrer comment ces choix contribuent à l'efficacité et à l'innovation de la solution développée. |

## Ce que le jury attend
Des choix de traitement et de stockage **justifiés par les volumes et les usages**, une analyse dont la **valeur est démontrée** et une sécurité des données traitée.

## Éléments à développer
1. La collecte et le traitement des données, par lots ou en temps réel : besoin, outils retenus, volumes visés.
2. Le stockage des données structurées ou non, et leur sécurité et intégrité.
3. Les analyses descriptives et prédictives mises en œuvre, y compris par apprentissage automatique, et la valeur obtenue, avec ses limites.
4. La coordination de l'équipe : découpage, interfaces, intégration.
5. L'argumentation d'ensemble des technologies et outils, au regard de l'efficacité et de l'innovation.

## Preuves à renvoyer en annexe
Schéma des flux de données ; extraits du traitement ou de la chaîne de données ; résultats d'analyse ou de modèle avec indicateurs d'évaluation ; mesures de volume et de délai de traitement.

## Support QueenBee
Chaîne d'**ingestion et de synchronisation des mesures (UC-T02)**, files de messages, stockage de séries temporelles. **Les volumes du cahier des charges sont modestes (environ 10 Mo par jour) : il faut justifier un dimensionnement cible et le démontrer avec le simulateur accéléré.** *Projet d'entreprise : données du projet, anonymisées.*

## Où trouver la matière dans ce dépôt
- `apps/ingest/` (worker MQTT -> DB), `apps/simulator/` (simulateur accéléré), `apps/edge-acoustic/`.
- `docs/diagrams/ingest-sequence.md` ; `docs/adr/0002-mqtt-bridge.md` ; `docs/adr/0004-timescale.md`.
- `db/` : hypertables, compression, rétention, agrégat continu ; `docs/data-dictionary.md`.
- Interface avec la spécialité Data : score de santé (ML) ; `cahier de charge.md` Partie C.4.
- Mesures de volume et de délai : 38 400 mesures/jour, rattrapage < 2 min, tests de charge k6.

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
