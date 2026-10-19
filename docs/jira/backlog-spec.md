# Backlog Jira QueenBee — spécification source

Source des tickets créés dans le projet Jira QueenBee (clé KAN). Format : `ID | Epic | Sprint | Qui | Heures max | Priorité | Zone | Titre | Détails clés | Preuve/E2E`.
Qui : LH = Land Hack, IG = Ibrahima Gueye, WA = Wissam Ait El Hadii. Relecteur : LH→IG, IG→WA, WA→LH.
Priorité : H = High, M = Medium, L = Low (Highest pour le chemin critique simulateur). Règles communes : docs/jira/PLAYBOOK.md.

Epics Jira : EP-00=KAN-3, EP-01=KAN-4, EP-02=KAN-5, EP-03=KAN-6, EP-04=KAN-7, EP-05=KAN-8, EP-06=KAN-9, EP-07=KAN-10, EP-08=KAN-11, EP-09=KAN-12, EP-10=KAN-13, EP-11=KAN-14, EP-12=KAN-15, EP-13=KAN-16, EP-14=KAN-17, EP-15=KAN-18.

## EP-00 Gouvernance et cadrage
T001|00|S01|LH|2|H|GOV|Créer GitHub Projects, labels, milestones et CODEOWNERS|Board Kanban (Backlog/Ready/En cours/Revue/Fait), labels area:* type:* prio:*, 17 milestones S01–S17, CODEOWNERS `* @nagoloumdaniel`|Capture board + lien
T002|00|S01|IG|2|H|GOV|Valider CONTRIBUTING.md et le template de PR|Relire/compléter CONTRIBUTING.md et .github/pull_request_template.md selon PLAYBOOK §3 §6|PR mergée, template visible sur une PR test
T003|00|S01|WA|2|M|GOV|Installer et tester les hooks pre-commit|`pre-commit install`, ruff/black/prettier/gitleaks, tester sur un faux secret|Commit avec faux secret bloqué (log)
T004|00|S01|LH|3|H|GOV|Préparer le guide d'entretien et mener 1 entretien besoin|Guide 10 questions (coordinateur, admin, Cyber/Data), compte rendu en annexe A2|CR daté dans docs/project/
T005|00|S01|IG|3|H|GOV|Mener 2 entretiens besoin et rédiger les CR|Profils différents de T004 ; extraire contraintes/désaccords|2 CR dans docs/project/
T006|00|S01|WA|3|H|GOV|Rédiger la matrice des risques v1|Remplir docs/project/risk-register.md, proba×impact 4×4, mesure par risque|Tableau validé en revue
T007|00|S01|LH|2|H|GOV|Chiffrer la capacité réelle de l'équipe et le budget prévisionnel|10 h/sem/personne, congés, tableau prévu vs réalisé|docs/project/capacity.md
T008|00|S02|IG|3|H|GOV|Rédiger l'étude de faisabilité : contraintes et décision|Plan Bloc 1 partie 2 : contraintes 7 natures, décision conditionnelle|docs/dossier/bloc1/02 rempli
T009|00|S02|WA|3|H|GOV|Calculer le ROI et ses hypothèses (annexe A4)|Heures d'automatisation vs visites évitées −25 %, hypothèses basse/haute|Tableur + annexe
T010|00|S02|LH|3|H|GOV|Rédiger le plan de veille (tableau)|Sujets, sources, outils, fréquence, responsable ; 1 h/semaine|docs/project/veille/plan-de-veille.md
T011|00|S02|IG|3|M|GOV|Rédiger le compte rendu de veille n°1 en FR depuis sources EN|Sujet : MQTT bridge ou Timescale ; ≥ 3 sources EN citées|CR dans veille/
T012|00|S02|WA|2|M|GOV|Obtenir l'accord du tuteur sur le périmètre front-end|Mail + CR : app offline et dashboard web comme preuve C2.3|Mail archivé
T013|00|S02|LH|2|M|GOV|Instaurer les rituels et le modèle de compte rendu de sprint|Daily 15 min, lundi/mercredi/vendredi, template sprint-reports|Template + 1er CR S01
T014|00|S02|IG|2|H|GOV|Rédiger ADR-001 choix de stack|Compléter docs/adr/0001-stack.md (options écartées, conséquences)|ADR relu
T015|00|S02|WA|3|M|GOV|Tableau comparatif des solutions concurrentes|Arnia, BeeHero, 3Bee, Apis Prime : fonctions, connectivité, coût|Tableau en annexe
## EP-01 Design et modélisation
T016|01|S02|IG|3|H|DESIGN|Moodboard et direction visuelle|Palette miel/terre/feuille, typo Inter+Fraunces, 5 références, justification|Fichier Figma + docs/design
T017|01|S02|WA|3|H|DESIGN|Documenter les tokens design (CSS vars et ThemeData)|Couleurs, espacements 4 px, rayons, motion 150/250 ms ; contraste AA vérifié|tokens.md + vérif contraste
T018|01|S03|LH|3|H|DESIGN|Figma : composants de base (bouton, champ, carte ruche)|États défaut/focus/désactivé/erreur ; cibles 48 dp|Page Figma composants
T019|01|S03|IG|4|H|DESIGN|Maquette mobile : Login et Mes ruches (liste + carte)|Parcours UC-A01 début ; états vide/chargement/hors-ligne|Frames Figma
T020|01|S03|WA|4|H|DESIGN|Maquette mobile : Détail ruche et graphe 7 jours|Poids, température, score santé 0–100, alertes liées|Frames Figma
T021|01|S03|LH|4|H|DESIGN|Maquette mobile : Nouvelle inspection (stepper 4 étapes + photo)|Étapes état visuel, reine, comportement, photo ; brouillon local|Frames Figma
T022|01|S03|IG|3|M|DESIGN|Maquette mobile : Alertes et Récolte|UC-A02 UC-A03 ; recommandation + niveau de confiance|Frames Figma
T023|01|S04|WA|3|M|DESIGN|Maquette mobile : Sync/Profil et bannière hors-ligne|Compteur d'éléments à synchroniser ; conflit|Frames Figma
T024|01|S04|LH|4|H|DESIGN|Maquette web : Coordinateur|Liste risques, carte, planning visites, validation récoltes|Frames Figma
T025|01|S04|IG|4|H|DESIGN|Maquette web : Gestionnaire et rapport bailleur|KPIs, comparaison sites/pays, export PDF|Frames Figma
T026|01|S04|WA|4|H|DESIGN|Maquette web : Admin (utilisateurs, seuils, vues DevOps/Cyber)|Rôles par site, seuils par type d'alerte, déploiements, journaux|Frames Figma
T027|01|S03|LH|3|H|MODEL|Diagrammes cas d'utilisation et contexte (Mermaid)|UC-A/C/G/AD/T ; frontières ; légende|docs/diagrams/*.md
T028|01|S03|IG|3|H|MODEL|Diagrammes de composants et de déploiement|Cloud central, zone data, sites edge, simulateur ; Compose vs K3s|docs/diagrams/*.md
T029|01|S04|WA|3|H|MODEL|Diagrammes de séquence : ingestion et sync offline|Voir ROADMAP §4.8 ; cas d'erreur inclus|docs/diagrams/*.md
T030|01|S04|LH|2|M|MODEL|Diagrammes d'états (alerte, inspection) et BPMN récolte|États et transitions interdites|docs/diagrams/*.md
T031|01|S04|IG|2|M|DESIGN|Test utilisateur des maquettes (5 personnes) et compte rendu|Script de tâches, taux de réussite, 3 corrections|CR + corrections listées
T032|01|S04|WA|2|H|DESIGN|Rédiger les exigences d'accessibilité et la grille|RGAA/WCAG 2.2 AA, cibles 48 dp, TalkBack, contraste, reduced-motion|docs/accessibility/checklist.md
T033|01|S04|LH|2|M|DESIGN|Rédiger les exigences d'éco-conception et la grille|Octets transmis, poids pages, RAM conteneurs, arrêt envs inutiles|docs/eco-conception/checklist.md
## EP-02 Infrastructure et CI/CD
T034|02|S01|LH|3|H|INFRA|Initialiser le dépôt : premier commit sur branche, protection main|Premier commit via branche chore/EP-02-init-repo, push, PR ; ruleset déjà actif|PR ouverte, ruleset vérifié
T035|02|S02|WA|3|H|CI|Écrire le workflow CI de lint|Jobs python/node/dart en parallèle, cache, échec rapide|CI verte sur PR test
T036|02|S02|IG|3|H|INFRA|Dockerfile API multi-stage non-root + hadolint|Image < 150 Mo, utilisateur non-root, healthcheck|Build + hadolint OK
T037|02|S02|LH|3|H|INFRA|Terraform : VM Oracle (réseau, clés SSH, pare-feu)|Variables, outputs, state distant ou local documenté|terraform plan joint
T038|02|S03|IG|3|H|INFRA|Rôle Ansible common (utilisateurs, ufw, fail2ban, mises à jour)|Idempotent ; clés SSH uniquement|2 exécutions : 0 changed
T039|02|S03|WA|3|H|INFRA|Rôle Ansible docker|Docker + compose plugin, daemon.json log rotation|Version docker affichée
T040|02|S03|LH|3|H|INFRA|Caddy TLS 1.3 + compose central.yml socle|Domaine, HSTS, redirection https, headers|GET /health via TLS (E2E)
T041|02|S03|IG|2|H|INFRA|Gestion des secrets SOPS/age et GitHub Secrets|Clé age, .sops.yaml, procédure de rotation|Secret déchiffré en CI test
T042|02|S04|WA|3|H|CI|Snyk dans la CI (dépendances et code), seuil bloquant|SNYK_TOKEN en secret, fail sur High+|Run échoue sur vuln test
T043|02|S04|LH|2|H|CI|Gitleaks, Trivy image et Checkov dans la CI|Rapports SARIF en artefacts|Job vert + rapport
T044|02|S04|IG|3|M|CI|Build multi-arch, push GHCR, SBOM et cosign|amd64+arm64, tags SemVer et sha|Image signée vérifiée
T045|02|S05|WA|3|H|CI|Workflow de déploiement staging via Ansible|Approbation manuelle environment, log dans deployment|Déploiement staging OK
T046|02|S05|LH|3|M|CI|Enregistrer chaque déploiement dans la table deployment|Script post-déploiement, statut, git_sha|Ligne créée après déploiement
T047|02|S05|IG|3|H|INFRA|Procédure de rollback et test du rollback|Version précédente restaurée en < 5 min|Rollback chronométré
T048|02|S05|LH|3|H|QA|E2E infra : apply puis /health en TLS|Script bout en bout sur VM vierge|Sortie du script jointe
T049|02|S06|WA|2|M|CI|Dependabot et required checks sur les PR|Configurer dependabot.yml, checks requis dans le ruleset|PR de MAJ créée
## EP-03 Simulateur
T050|03|S02|LH|3|M|SIM|Squelette du simulateur : CLI, config YAML, client MQTT|Typer/argparse, lecture sites.yaml, connexion broker|`simulator --help` + test
T051|03|S02|WA|3|M|SIM|Broker Mosquitto en dev + convention de topics|queenbee/{site}/{hive}/telemetry etc. ; documenter|compose dev up + pub/sub test
T052|03|S03|IG|3|M|SIM|Générateur de poids : tendance saisonnière|Miellée/saison sèche par site ; graine fixe|Test unitaire de la courbe
T053|03|S03|LH|3|M|SIM|Générateur température/humidité : cycle jour + bruit gaussien|Bruit capteur bas coût|Test statistique moyenne/écart
T054|03|S03|WA|3|M|SIM|Générateur acoustique circadien + dérive batterie|Forte le jour, quasi nulle la nuit ; silence fin de vie|Test unitaire
T055|03|S03|IG|2|M|SIM|Format de message JSON §6.5 + validation de schéma|JSON Schema partagé avec ingest|Schéma validé sur 100 messages
T056|03|S04|LH|3|M|SIM|Profils climatiques des 8 sites (YAML)|Sénégal 3, Côte d'Ivoire 3, Cameroun 2|8 profils chargés (test)
T057|03|S04|WA|3|M|SIM|Facteur d'accélération temporelle|1 min réelle = N min simulées|Test horloge accélérée
T058|03|S04|IG|3|M|SIM|Moteur de scénarios déclaratif (parser de timeline YAML)|Étapes t=…, actions, validation|Scénario exemple joué
T059|03|S04|LH|3|M|SIM|Scénarios essaimage et mortalité progressive|Voir CDC §6.6|Rejouables, vérité terrain
T060|03|S04|WA|3|M|SIM|Scénarios stress thermique et passerelle hors-ligne|Arrêt de publication 15 min|Rejouables
T061|03|S05|IG|3|M|SIM|Scénarios brouillage radio, rejeu/falsification, vol de ruche|Dérive GPS au-delà de tolérance|Rejouables
T062|03|S05|LH|3|M|SIM|Comportement simulé des apiculteurs (3 profils) et récoltes|30/50/20 % ; déclarations autour des pics|Distribution vérifiée
T063|03|S05|WA|3|M|SIM|API de contrôle du simulateur|POST run scenario, PUT speed, GET status|Appels API testés
T064|03|S05|IG|2|M|SIM|Export de la vérité terrain (JSON horodaté)|Moment d'injection de chaque anomalie|Fichier généré et lu en test
T065|03|S05|LH|3|M|SIM|Dockerfile et compose local du simulateur (1–2 sites)|`docker compose up` suffit|README testé par un autre membre
T066|03|S05|WA|3|M|SIM|Déployer l'instance centrale 8 sites / 400 ruches|Flux stable ; démarrage auto|Dashboard compte 400 ruches
T067|03|S05|IG|3|H|QA|Tests : unité générateurs et E2E scénario essaimage|Détection du moment d'injection|Rapport de test
## EP-04 Base de données
T068|04|S03|WA|3|H|DB|Compose Postgres 16 + PostGIS + Timescale|Extensions, volume, healthcheck|`\dx` liste les extensions
T069|04|S03|LH|2|H|DB|Initialiser Alembic et conventions de nommage|naming_convention, env.py async|`alembic upgrade head` vide OK
T070|04|S04|IG|3|H|DB|Migration country, site, cooperative|Selon db/schema/reference.sql|up/down testés
T071|04|S04|WA|3|H|DB|Migration app_user, user_site, user_cooperative, refresh_token|CHECK MFA ; citext|up/down testés
T072|04|S04|LH|3|H|DB|Migration hive, gateway, gateway_heartbeat|Index GiST ; hypertable heartbeat|up/down testés
T073|04|S05|IG|3|H|DB|Migration measurement : hypertable, compression, rétention, agrégat horaire|Politiques Timescale|Politiques visibles
T074|04|S05|WA|3|H|DB|Migration alert, alert_threshold, visit_plan, integrity_event|Enums ; dedup_key unique|up/down testés
T075|04|S05|LH|3|H|DB|Migration inspection, photos, harvest, hive_move, sync_cursor|client_uuid unique|up/down testés
T076|04|S05|IG|2|H|DB|Migration deployment et audit_log append-only|REVOKE UPDATE/DELETE|Tentative UPDATE refusée
T077|04|S06|WA|3|H|DB|Row Level Security par site + tests|Politiques sur hive, measurement, inspection|Utilisateur site A ne lit pas site B
T078|04|S06|LH|3|M|DB|Seeds : 8 sites, 25 coopératives, 400 ruches|Script idempotent|Comptes SQL corrects
T079|04|S06|IG|3|M|DB|Seeds : 317 utilisateurs de test|Mots de passe de test non réutilisables|Comptes par rôle corrects
T080|04|S06|WA|3|M|DB|Générer le dictionnaire de données|Script depuis information_schema|data-dictionary.md généré
T081|04|S06|LH|2|M|DB|ADR Timescale vs partition, RLS, UUID|Docs/adr/0004|ADR relu
T082|04|S06|IG|3|H|QA|E2E migrations up/down + chiffrement pgcrypto de la PII|Base vide → head → base ; test chiffrement|Rapport
## EP-05 Authentification et RBAC
T083|05|S06|LH|3|H|AUTH|Compléter le squelette API : config, logging JSON, /health /ready|Couches routers/services/repositories|Tests health verts
T084|05|S07|IG|3|H|AUTH|Hashage argon2id et service utilisateur|Paramètres OWASP, rehash|Tests unitaires
T085|05|S07|WA|3|H|AUTH|POST /auth/login et JWT 15 min|Claims minimaux, erreurs génériques|Test E2E login
T086|05|S07|LH|3|H|AUTH|Refresh token rotatif + détection de réutilisation|famille de tokens, révocation|Test réutilisation → famille révoquée
T087|05|S07|IG|3|H|AUTH|MFA TOTP : enrôlement et vérification|QR otpauth, fenêtre ±1|Test E2E MFA
T088|05|S07|WA|2|H|AUTH|Verrouillage après 5 tentatives|locked_until, journalisation|Test 5 échecs → 423
T089|05|S08|LH|3|H|AUTH|RBAC (4 rôles) et contexte RLS (SET app.user_id)|Dépendance FastAPI, refus par défaut|Matrice d'accès testée
T090|05|S08|IG|3|H|AUTH|CRUD utilisateurs (admin) et rôles par site|Validation Pydantic ; désactivation|E2E admin
T091|05|S08|WA|2|M|AUTH|Middleware d'audit log|Qui/quoi/quand, sans PII|Ligne d'audit créée
T092|05|S08|LH|3|H|SEC|Rate limiting, headers de sécurité, CORS liste blanche|slowapi, 429 sur login|Test 429 + headers
T093|05|S08|IG|3|H|QA|Tests IDOR par rôle et E2E auth complet|Matrice rôle×endpoint|Rapport de matrice
## EP-06 Ingestion et règles
T094|06|S08|WA|3|H|INGEST|Worker d'ingestion : abonnement MQTT et parsing|Reconnexion automatique|Message reçu → log
T095|06|S09|LH|3|H|INGEST|Validation des plages physiques et du schéma|Poids, température, humidité, batterie|Trames invalides rejetées
T096|06|S09|IG|3|H|INGEST|Anti-rejeu (seq/ts) et idempotence ON CONFLICT|Clé hive_id+ts+seq|Double envoi = 1 ligne
T097|06|S09|WA|3|H|INGEST|Signature HMAC des capteurs|sensor_key_hash ; comparaison constante|Trame falsifiée rejetée
T098|06|S09|LH|2|H|INGEST|Journal integrity_event|kind, payload, détection|Événement créé
T099|06|S09|IG|3|H|INGEST|Règle : chute de poids brutale|> 0,5 kg en < 2 h hors récolte|Test unitaire + scénario
T100|06|S10|WA|3|H|INGEST|Règle : chute d'activité acoustique sur 72 h|> 30 %|Test unitaire + scénario
T101|06|S10|LH|3|H|INGEST|Règle : écart de température du couvain|> 3 °C sur > 6 h|Test unitaire
T102|06|S10|IG|2|M|INGEST|Règles : immobilité 24 h et canicule|Activité ≈ 0 ; seuil météo|Tests unitaires
T103|06|S10|WA|3|H|INGEST|Règle : dérive GPS PostGIS et déplacement déclaré|ST_Distance vs tolérance ; hive_move|Scénario vol → alerte
T104|06|S10|LH|3|H|INGEST|Création d'alertes : déduplication et sévérité|dedup_key|Alerte unique pour 10 trames
T105|06|S10|IG|3|M|INGEST|Interface du score de santé (contrat Data) et stub|Score 0–100 + confiance|Contrat documenté
T106|06|S10|WA|3|M|INGEST|Échantillonnage adaptatif : commande de config par site|5 min pendant 6 h si anomalie|Message de config publié
T107|06|S10|LH|3|H|QA|Tests unitaires règles à 100 % et E2E ingestion|Rejeu, hors plage, GPS|Couverture règles 100 %
## EP-07 Edge et synchronisation
T108|07|S09|IG|3|H|EDGE|Configuration Mosquitto site avec persistance|persistence true, limites|Redémarrage sans perte
T109|07|S10|WA|3|H|EDGE|Bridge site → central TLS QoS 1|Certificats, reconnexion|Message arrive après coupure
T110|07|S10|LH|3|H|EDGE|Service acoustique edge : extraction FFT|Features ~8 octets|Test sur signal synthétique
T111|07|S11|IG|3|M|EDGE|Publier le vecteur acoustique via MQTT|Pas d'audio brut|Message de 8 octets
T112|07|S11|WA|3|H|EDGE|Heartbeat de la passerelle et métriques de file|queue_depth, lora_loss|Heartbeat en base
T113|07|S11|LH|3|H|EDGE|Mode dégradé : cache disque borné et reprise auto|Taille max, FIFO, priorité alertes|Test coupure 30 min
T114|07|S11|IG|3|H|EDGE|Rôle Ansible WireGuard site ↔ central|Clés, routes, keepalive|Ping à travers le tunnel
T115|07|S11|WA|3|H|EDGE|Rôle Ansible site pilote complet (Compose)|Mosquitto, acoustique, agent|Site pilote déployé
T116|07|S12|LH|3|L|EDGE|Variante K3s (manifests) et mesure de RAM|Comparer à Compose|Mesure en annexe
T117|07|S12|IG|3|H|EDGE|Déployer le site pilote et tester le rollback|Version N−1 restaurée|Rollback chronométré
T118|07|S12|WA|3|H|QA|E2E coupure réseau 15 min (netem) zéro perte|Comparer compte de messages|Rapport comptage
T119|07|S12|LH|3|H|QA|Mesurer la synchro d'un jour (38 400 mesures) < 2 min|Simulateur accéléré|Rapport de mesure
T120|07|S12|IG|2|H|EDGE|Alerte gateway_offline à 15 minutes|Règle sur heartbeat absent|Alerte créée en scénario
## EP-08 API métier
T121|08|S09|WA|3|H|API|Ruches : liste (filtres site/risque/bbox) et détail|Pagination curseur|Tests API
T122|08|S10|LH|3|H|API|Ruches : mesures par bucket et recherche par QR|time_bucket Timescale|< 200 ms
T123|08|S10|IG|3|H|API|Ruches : création et modification|Validation, RLS|Tests API
T124|08|S11|WA|3|H|API|Inspections : POST idempotent (client_uuid) et liste|409 si version obsolète|Test double POST
T125|08|S11|LH|3|H|API|Upload photos sécurisé|Type magique, taille, ré-encodage|Fichier piégé refusé
T126|08|S11|IG|3|H|API|Récoltes : déclaration et écart vs prédiction|gap_pct|Test calcul
T127|08|S11|WA|3|H|API|Récoltes : validation par le coordinateur|Statuts, droits|Test RBAC
T128|08|S12|LH|3|H|API|Alertes : liste, ack, résolution|Transitions d'état valides|Tests d'états
T129|08|S12|IG|3|M|API|Plans de visite : CRUD et assignation|Un seul plan actif par ruche|Tests API
T130|08|S12|WA|3|H|API|Sync push/pull et résolution de conflits|Cursor, batch|Tests API
T131|08|S12|LH|3|H|QA|Tests de propriété sur la résolution de conflits|Hypothesis|Rapport
T132|08|S12|IG|3|M|API|Endpoints KPI analytics|Agrégats < 200 ms|Mesure EXPLAIN
T133|08|S13|WA|3|M|API|Endpoint de rapport (stub vers module Data)|Statut asynchrone|Appel + polling
T134|08|S13|LH|2|M|API|OpenAPI propre, erreurs RFC 9457, ETag|Exemples, descriptions|Schemathesis sans 500
T135|08|S13|IG|3|H|QA|Schemathesis + E2E des parcours UC-C01, C02, G02|Parcours par API|Rapport
T136|08|S13|WA|2|M|API|Endpoints ops : deployments, sync-queues, /metrics|Prometheus client|Métriques visibles
## EP-09 Application mobile
T137|09|S09|LH|3|H|MOBILE|Initialiser le projet Flutter, structure et thème (tokens)|flutter create, very_good_analysis|`flutter analyze` propre
T138|09|S10|IG|3|H|MOBILE|Schéma Drift local + chiffrement SQLCipher|Tables miroir|Test persistance
T139|09|S10|WA|3|H|MOBILE|Navigation go_router, i18n fr, écran de connexion|app_fr.arb|Widget test
T140|09|S11|LH|3|H|MOBILE|Client d'authentification : Keystore et refresh|flutter_secure_storage|Test refresh
T141|09|S11|IG|3|H|MOBILE|Écran Mes ruches : liste + cache local|Stale-while-revalidate|Test hors ligne
T142|09|S12|WA|3|M|MOBILE|Carte des ruches (flutter_map)|Tuiles OSM, clustering|Capture + test
T143|09|S12|LH|3|H|MOBILE|Scan QR et ouverture de la ruche|mobile_scanner|Test sur QR seed
T144|09|S12|IG|3|H|MOBILE|Détail ruche et graphe 7 jours|fl_chart ; alternatives textuelles|Widget test
T145|09|S13|WA|3|H|MOBILE|Inspection : étapes 1 et 2|Brouillon persistant|Test widget
T146|09|S13|LH|3|H|MOBILE|Inspection : étapes 3, 4 et caméra|Compression photo|Test intégration
T147|09|S13|IG|3|H|MOBILE|Outbox : file de synchronisation|Statuts pending/sent/failed|Test persistance outbox
T148|09|S13|WA|3|H|MOBILE|Sync push/pull client et gestion 409|Backoff exponentiel|Test conflit
T149|09|S14|LH|3|M|MOBILE|Bannière hors-ligne et compteur à synchroniser|connectivity_plus|Test d'état
T150|09|S14|IG|3|H|MOBILE|Écran Alertes et notifications push FCM|Canal, deep link|Test push simulé
T151|09|S14|WA|3|H|MOBILE|Déclaration de récolte|Validation volume ≥ 0|Test intégration
T152|09|S14|LH|3|H|MOBILE|Accessibilité mobile : Semantics, 48 dp, contrastes|TalkBack|Checklist cochée
T153|09|S14|IG|3|H|QA|integration_test : parcours complet en mode avion|UC-A01 de bout en bout|Vidéo + log
T154|09|S14|WA|2|M|MOBILE|APK release < 30 Mo et documentation de signature|Obfuscation, taille|Taille mesurée
## EP-10 Dashboard web
T155|10|S10|WA|3|H|WEB|Initialiser Next.js, Tailwind, shadcn et tokens|Pas de couleur en dur|`pnpm build` OK
T156|10|S11|LH|3|H|WEB|Layout, connexion + MFA, middleware RBAC|cookies httpOnly|Test E2E login
T157|10|S11|IG|3|H|WEB|Client API typé depuis OpenAPI|openapi-typescript|Types générés en CI
T158|10|S12|WA|3|H|WEB|Coordinateur : liste des ruches triée par risque|Tableau accessible|Test Playwright
T159|10|S12|LH|3|H|WEB|Coordinateur : carte et filtres|Leaflet|Test Playwright
T160|10|S13|IG|3|H|WEB|Coordinateur : planification des visites|Formulaire accessible|Test Playwright
T161|10|S13|WA|3|H|WEB|Coordinateur : validation des récoltes|Comparaison poids capteurs|Test Playwright
T162|10|S13|LH|3|H|WEB|Gestionnaire : KPIs et graphes|dataviz skill ; palette AA|Test Playwright
T163|10|S13|IG|3|M|WEB|Gestionnaire : comparaison des sites et export PDF|Appel /reports|Test Playwright
T164|10|S14|WA|3|H|WEB|Admin : utilisateurs et rôles|Création/désactivation|Test Playwright
T165|10|S14|LH|3|M|WEB|Admin : seuils d'alerte|Validation par type|Test Playwright
T166|10|S14|IG|3|M|WEB|Admin : vue DevOps (déploiements, sync)|Données /ops|Test Playwright
T167|10|S14|WA|3|M|WEB|Admin : vue Cyber (journaux, intégrité)|Filtrage, pagination|Test Playwright
T168|10|S14|LH|3|H|WEB|États loading/erreur/vide et audit axe|0 violation critique|Rapport axe
T169|10|S14|IG|3|H|QA|Playwright E2E des 3 rôles|Console sans erreur|Rapport HTML
## EP-11 n8n
T170|11|S12|LH|3|M|N8N|Déployer n8n sécurisé (compose)|Auth, chiffrement credentials, réseau interne|Accès restreint testé
T171|11|S12|IG|3|M|N8N|Workflow : alerte critique → FCM/email|Webhook depuis API|E2E < 30 s
T172|11|S13|WA|3|L|N8N|Workflow : export de rapport planifié|Cron, appel /reports|Exécution manuelle OK
T173|11|S13|LH|2|M|N8N|Exporter les workflows en JSON et E2E avec mock|Sans credentials|JSON versionné
## EP-12 Observabilité et reprise
T174|12|S12|WA|3|H|OBS|Prometheus, Alertmanager et Grafana en compose|Scrape API, node, cAdvisor|Cibles UP
T175|12|S13|IG|3|M|OBS|Loki et logs JSON structurés avec trace_id|Pas de PII|Requête LogQL
T176|12|S13|LH|3|H|OBS|Dashboard Grafana : déploiements|Succès %, durée, rollbacks|JSON provisionné
T177|12|S14|WA|3|H|OBS|Dashboard Grafana : files de sync|Taille, âge, débit|JSON provisionné
T178|12|S14|IG|3|H|OBS|Dashboard Grafana : disponibilité sites/passerelles|Heartbeat|JSON provisionné
T179|12|S14|LH|2|H|OBS|Règles Alertmanager (heartbeat, VPN, file, cert, disque)|Seuils CDC §4.6|Alerte déclenchée en test
T180|12|S15|WA|3|M|OBS|Runbooks par alerte|Symptôme/diagnostic/action/escalade|5 runbooks relus
T181|12|S15|IG|3|H|OBS|Sauvegarde pg_dump + WAL chiffrée|age ; copie hors VM|Sauvegarde restaurable
T182|12|S15|LH|3|H|QA|E2E : détruire la base de test puis restaurer, chronométré|Intégrité + RPO/RTO|Chronométrage
T183|12|S15|WA|3|H|QA|Démonstration panne passerelle chronométrée|Mode dégradé → reprise|Vidéo + mesures
## EP-13 Sécurité, performance, accessibilité, éco
T184|13|S14|IG|2|H|SEC|Checklist ASVS niveau 2|Cocher/justifier chaque point|docs/security/asvs
T185|13|S15|LH|3|H|SEC|OWASP ZAP baseline sur staging|Environnement de test seulement|Rapport ZAP
T186|13|S15|WA|3|H|QA|Test de charge k6 (400 ruches)|p95 < 500 ms|Rapport k6
T187|13|S15|IG|3|M|QA|Optimiser requêtes et index (EXPLAIN)|Avant/après|Mesures
T188|13|S15|LH|3|H|QA|Audit accessibilité web (axe + manuel)|Clavier, lecteur d'écran|Rapport
T189|13|S15|WA|3|H|QA|Audit accessibilité mobile (TalkBack)|Parcours clés|Rapport
T190|13|S16|IG|3|M|SEC|Mesures d'éco-conception|cAdvisor, poids pages, octets|Tableau avant/après
T191|13|S16|LH|3|H|SEC|Grille de conformité RGPD, ANSSI, ITIL|Preuve par point|docs/compliance
T192|13|S16|WA|2|H|SEC|Registre de traitement RGPD et AIPD simplifiée|Finalités, durées|docs/compliance
T193|13|S16|IG|3|M|SEC|Revue pip-audit, npm audit et SBOM|Corrections ou acceptation écrite|Rapport
## EP-14 Landing et SEO
T194|14|S15|LH|3|M|SEO|Landing Next.js SSG : sections et contenu|Contenu réel, aucune donnée inventée|Build statique
T195|14|S15|IG|3|M|SEO|Meta, canonical, OG, hreflang, JSON-LD, sitemap, robots|Titre/description uniques|Validation outils
T196|14|S16|WA|3|M|SEO|noindex des zones privées, 404 et Lighthouse CI|LCP ≤ 2,5 s|Rapport Lighthouse
T197|14|S16|LH|2|M|SEO|Audit SEO avec skills et corrections|seo-audit, schema|Rapport
## EP-15 Documentation, dossiers, soutenance
T198|15|S06|WA|3|M|DOC|README : installation en 5 commandes|Testé sur machine vierge|Relu par IG
T199|15|S16|LH|3|M|DOC|Guide utilisateur illustré (mobile)|Captures, langage simple|PDF
T200|15|S16|IG|3|M|DOC|Guide de déploiement multi-sites|Étapes, rollback|Relu
T201|15|S16|WA|3|H|DOC|DCT partie 1 (chapitres 1–3)|30–35 p. au total|Relu
T202|15|S16|LH|3|H|DOC|DCT partie 2 (chapitres 4–6)|—|Relu
T203|15|S16|IG|3|H|DOC|DCT partie 3 (chapitres 7–9)|—|Relu
T204|15|S16|WA|3|H|DOC|Slides de soutenance (20–25)|Plan démo|PPTX
T205|15|S17|LH|2|H|DOC|Scénario de démo scripté + vidéo de secours|Voir ROADMAP §6.7|Vidéo
T206|15|S17|IG|3|H|DOC|Répétition de soutenance n°1|Chronométrer 20 min|Notes
T207|15|S17|WA|3|H|DOC|Répétition de soutenance n°2 + questions du jury|—|Notes
T208|15|S17|LH|2|H|QA|E2E nocturne du scénario de démo en CI|Planifié cron|Run vert

## Tickets générés (agents : les créer avec les règles ci-dessous)
**REVUE (17 tickets)** : un par sprint S01–S17, 1 h, zone REVUE, epic EP-15, échéance = fin du sprint. Titre `[REVUE] Revue de sprint Sxx et mise à jour du journal des écarts`. Qui : S01 LH, S02 IG, S03 WA, puis rotation LH→IG→WA. Contenu : compte rendu (docs/project/sprint-reports/template.md), burndown, KPI du PLAYBOOK, écarts détectés + décisions, mise à jour du plan, message au commanditaire. Preuve : fichier sprint-reports/Sxx.md.
**DOSSIER (18 tickets)** : pour chaque personne (LH, IG, WA), 6 tickets zone DOSSIER, epic EP-15, priorité H, titres `[DOSSIER] <Prénom> — Bloc 1 parties 1 à 4` (4 h, S15), `Bloc 1 parties 5 à 8` (4 h, S15), `Bloc 1 parties 9–10 + bibliographie + annexes` (3 h, S16), `Bloc 2 parties 1 à 3` (4 h, S16), `Bloc 2 parties 4 à 6` (4 h, S16), `Bloc 2 parties 7–8 + bibliographie + annexes + export PDF` (3 h, S17, nommage NOM_Prenom_BLOC[N]_DEV_2027.pdf). Contenu : prose argumentée, 1ʳᵉ personne, chaque affirmation technique → « parce que » + annexe numérotée, critères Ce* des gabarits dans docs/dossier/blocN/. Les tickets de chaque personne dépendent de son journal de décisions.
