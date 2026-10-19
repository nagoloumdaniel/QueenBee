# CAHIER DE CHARGE — QUEENBEE

> **Plateforme intelligente de gestion apicole solidaire multi-sites (Afrique)**
> Document de synthèse intégrale du projet, construit à partir de trois sources :
>
> | # | Fichier source | Nature |
> |---|----------------|--------|
> | 1 | `QUEENBEE_CDC_COMMUN_M1.docx` | Cahier des charges fonctionnel commun (les 3 spécialités) |
> | 2 | `TEMPLATE_BLOC1_DEV_B.docx` | Gabarit du dossier professionnel Bloc 1 — Planifier et organiser (EADL, activité A1) |
> | 3 | `TEMPLATE_BLOC2_DEV_B.docx` | Gabarit du dossier professionnel Bloc 2 — Concevoir et développer (EADL, activité A2) |
>
> **Spécialité de l'équipe auteur : Développement logiciel — orientation DevOps.**
> **Écoles :** INGETIS (Paris) / ITIS (Évry) — **Promotion :** Master 1 — **Durée :** 5 mois (janvier → mai 2027).

---

## Comment lire ce document

Ce document est organisé en **trois grandes parties** :

| Partie | Contenu | Pourquoi |
|--------|---------|----------|
| **PARTIE A** | Le cahier des charges commun QueenBee, repris **en intégralité** (contexte, besoins, acteurs, cas d'utilisation, modules, architecture, données, exigences, stack, interfaces, organisation, livrables, évaluation, annexes) | C'est la **définition du produit** : ce que l'application doit faire |
| **PARTIE B** | Les deux gabarits de dossier professionnel (Bloc 1 et Bloc 2), repris **en intégralité** (compétences, critères d'évaluation, attentes du jury, plans, volumes) | C'est la **définition de l'évaluation** : comment le travail réalisé sera jugé |
| **PARTIE C** | Synthèse croisée : ce que notre spécialité (Dev/DevOps) doit réellement faire, matrice exigences ↔ compétences, points d'attention, incohérences relevées dans les sources | C'est le **pont** entre les deux : comment utiliser le produit pour valider les compétences |

> **Note de lecture.** Les textes sont reproduits fidèlement. Les blocs « 💡 *Explication* » ajoutés par la synthèse expliquent en langage simple ce qu'il faut en comprendre ; ils ne figurent pas dans les documents d'origine.

---

## TABLE DES MATIÈRES GÉNÉRALE

**PARTIE A — CAHIER DES CHARGES FONCTIONNEL COMMUN**
1. Présentation générale
2. Analyse du besoin
3. Acteurs et utilisateurs
4. Scénarios et cas d'utilisation
5. Spécifications fonctionnelles par spécialité
6. Architecture système multi-spécialités
7. Modèle de données (conception étudiants)
8. Exigences non fonctionnelles
9. Stack technique recommandée par spécialité
10. Interfaces et intégrations
11. Organisation et méthodologie
12. Livrables par spécialité
13. Critères d'évaluation
14. Annexes (A à D)

**PARTIE B — DOSSIERS PROFESSIONNELS (GABARITS D'ÉVALUATION)**
- B.1 Informations communes aux deux gabarits
- B.2 Bloc 1 — Planifier et organiser un projet de développement logiciel
- B.3 Bloc 2 — Concevoir et développer des solutions logicielles

**PARTIE C — SYNTHÈSE CROISÉE POUR LA SPÉCIALITÉ DÉVELOPPEMENT (DEVOPS)**
- C.1 Rôle exact de la spécialité Développement
- C.2 Backlog fonctionnel et technique de la spécialité Dev
- C.3 Matrice exigences du produit ↔ compétences à démontrer
- C.4 Interfaces avec Data et Cyber
- C.5 Objectifs chiffrés à atteindre (récapitulatif)
- C.6 Risques et points d'attention
- C.7 Incohérences et points à clarifier dans les sources
- C.8 Glossaire consolidé

---
---

# PARTIE A — CAHIER DES CHARGES FONCTIONNEL COMMUN

## I. PRÉSENTATION GÉNÉRALE

### 1.1 Contexte et enjeux

L'apiculture joue un rôle central dans la **sécurité alimentaire**, la **préservation de la biodiversité** et l'**autonomisation économique** des communautés rurales en Afrique de l'Ouest et Centrale. Pourtant, les colonies d'abeilles y sont soumises à des pressions croissantes : dérèglement climatique, déforestation, usage de pesticides, maladies et essaimages non détectés à temps.

**Constats actuels :**

- Suivi des ruches réalisé manuellement, sur papier, avec des visites de terrain espacées et coûteuses
- Colonies affaiblies ou en essaimage détectées trop tard, faute de données en temps réel
- Rendements de miel imprévisibles, rendant la planification des récoltes et des ventes difficile pour les coopératives
- Sites dispersés sur plusieurs pays, avec une connectivité Internet intermittente ou absente
- Absence de vision consolidée pour l'association qui coordonne les coopératives locales
- Données sensibles des bénéficiaires (coopératives, apicultrices, localisation des ruchers) mal protégées
- Infrastructure numérique de l'association fragile, sans redondance ni supervision
- Engagement limité des bailleurs de fonds faute d'indicateurs d'impact fiables

**Enjeux stratégiques :**

- **Environnementaux** : préserver les colonies et la biodiversité pollinisatrice
- **Économiques** : sécuriser et augmenter les revenus des coopératives apicoles (**+15 % de rendement visé**)
- **Sociaux** : renforcer l'autonomisation des femmes apicultrices, moteur des coopératives
- **Data-driven** : piloter les campagnes de récolte et les interventions par la donnée
- **Technologiques** : déployer une infrastructure IoT robuste en connectivité limitée (LoRaWAN, edge computing)
- **Sécuritaires** : protéger l'infrastructure et les données d'une association opérant sur plusieurs sites sensibles

> 💡 *Explication.* Le problème de fond : aujourd'hui on ne sait qu'après coup qu'une ruche va mal. QueenBee veut passer d'un suivi **réactif et manuel** à un suivi **continu, prédictif et sécurisé**, malgré un réseau Internet souvent absent. Cette contrainte de réseau est la clé de toute l'architecture (tout doit fonctionner **hors ligne** puis se synchroniser plus tard).

### 1.2 Vision du projet

QueenBee ambitionne de transformer le suivi apicole solidaire en un service **intelligent, connecté et résilient**, où l'IoT, l'intelligence artificielle, le DevOps et la cybersécurité convergent pour protéger les colonies, sécuriser les revenus des coopératives et renforcer la capacité opérationnelle de l'**association BeeAfrica** sur l'ensemble de ses sites africains.

**Notre vision repose sur 6 piliers :**

| Pilier | Description | Spécialité principale |
|--------|-------------|-----------------------|
| 🐝 Connectivité IoT | Ruches connectées : capteurs poids, température, humidité, acoustique | Cyber-Réseaux |
| 🤖 Intelligence Artificielle | Prédiction de la santé des colonies, du risque d'essaimage et du rendement | Data Science |
| ⚙️ DevOps & Exploitation | Déploiement, automatisation et supervision multi-sites en connectivité limitée | **Développement** |
| 📊 Analytics | Dashboards consolidés pour l'association et ses bailleurs | Data Science |
| 🌐 Infrastructure résiliente | Interconnexion sécurisée des sites, edge computing, continuité de service | Cyber-Réseaux |
| 📱 Mobilité terrain | Application mobile hors-ligne pour les apicultrices et coordinateurs | **Développement** |

### 1.3 Objectifs stratégiques

| Objectif | Indicateur | Cible | Spécialité |
|----------|-----------|-------|-----------|
| Anticiper les essaimages | Détection précoce | **+80 % détecté ≥ 48 h avant** | Data |
| Prédire les rendements | Erreur de prédiction (MAE) | **< 15 %** | Data |
| Réduire les visites inutiles | Visites terrain évitées | **-25 %** | Data/Dev |
| Fiabiliser le déploiement | Déploiements réussis sans incident | **> 95 %** | **Dev (DevOps)** |
| Assurer la continuité de service | Uptime plateforme centrale | **> 99 %** | Cyber |
| Sécuriser les données bénéficiaires | Incidents de sécurité majeurs | **0** | Cyber |
| Autonomiser les coopératives | Coopératives actives sur la plateforme | **25** | Tous |

### 1.4 Périmètre du projet

- **Géographie** : 3 pays pilotes (**Sénégal, Côte d'Ivoire, Cameroun**), **8 sites** ruchers
- **Infrastructure** : **400 ruches connectées**, passerelles LoRaWAN par site
- **Bénéficiaires** : **25 coopératives**, ~**300** apicultrices et apiculteurs actifs
- **Utilisateurs plateforme** : 300 apiculteurs/trices, 8 coordinateurs régionaux, 6 gestionnaires association, 3 administrateurs

---

## II. ANALYSE DU BESOIN

### 2.1 Problématiques actuelles

#### Suivi manuel et réactif
- Les visites de terrain suivent un calendrier fixe, sans tenir compte de l'état réel des colonies.
- Déplacements longs et coûteux vers des sites parfois isolés
- Anomalies détectées trop tard (essaimage déjà en cours, colonie affaiblie)
- Charge de travail élevée pour un nombre limité de coordinateurs

#### Colonies vulnérables non détectées à temps
- Absence de visibilité continue sur le poids, la température et l'activité des ruches.
- Essaimages non anticipés, entraînant une perte de colonies et de rendement
- Maladies ou stress thermique détectés uniquement lors des visites
- Pertes économiques directes pour les coopératives

#### Manque de données consolidées
- Aucune vision agrégée multi-sites pour l'association et ses bailleurs.
- Décisions de récolte basées sur l'expérience plutôt que sur la donnée
- Impossible de mesurer l'impact réel des programmes de soutien
- Rapports d'impact bailleurs réalisés manuellement, peu fiables

#### Infrastructure exposée et fragile
- Sites distants interconnectés de façon ad hoc, sans politique de sécurité homogène.
- Passerelles IoT non supervisées, vulnérables aux coupures et intrusions
- Données sensibles des bénéficiaires stockées sans chiffrement ni sauvegarde fiable
- Aucune procédure de continuité en cas d'incident sur un site

### 2.2 Solution proposée : QueenBee

QueenBee est une **plateforme IoT intelligente** qui transforme le suivi apicole solidaire en un système **connecté, prédictif, exploité de façon industrialisée (DevOps) et sécurisé** sur l'ensemble des sites de l'association BeeAfrica.

| Composante | Description | Spécialité |
|-----------|-------------|-----------|
| 🐝 Capteurs IoT | 400 ruches équipées de capteurs de poids, température, humidité et son. Transmission LoRaWAN vers passerelles locales. | Cyber |
| 🤖 Prédiction Colonies | Modèles ML : risque d'essaimage, santé de la colonie, prévision de rendement miel. | Data |
| 📱 Application Terrain | App mobile **offline-first** pour apicultrices et coordinateurs, synchronisation différée. | **Dev (DevOps)** |
| 📊 Analytics Consolidés | Dashboards multi-sites, rapports d'impact automatisés pour bailleurs. | Data |
| ⚙️ Plateforme DevOps | Pipelines CI/CD, conteneurisation, déploiement automatisé sur sites à connectivité limitée. | **Dev** |
| 🔒 Infrastructure Sécurisée | Interconnexion chiffrée des sites, supervision centralisée, continuité d'activité. | Cyber |

---

## III. ACTEURS ET UTILISATEURS

### 3.1 Parties prenantes

| Partie prenante | Rôle | Attentes |
|----------------|------|----------|
| Association BeeAfrica | Commanditaire | Impact mesurable, pilotage multi-sites, rapports bailleurs |
| Coopératives locales | Bénéficiaires | Meilleurs rendements, moins de pertes de colonies |
| Apicultrices / Apiculteurs | Terrain | Application simple, utilisable hors connexion |
| Coordinateurs régionaux | Encadrement | Outils de priorisation des visites, alertes fiables |
| Bailleurs de fonds | Financeurs | Transparence, indicateurs d'impact, sécurité des données |
| Étudiants M1 | Développeurs | Projet formateur, technologies modernes, contexte à impact |

### 3.2 Profils utilisateurs

#### Apiculteur / Apicultrice (~300)
- Consulter l'état de ses ruches (poids, alertes) **même hors connexion**
- Enregistrer une visite d'inspection (photos, observations)
- Recevoir une alerte en cas de risque détecté (essaimage, chute de poids anormale)
- Consulter l'historique de récolte de ses ruches

#### Coordinateur régional (8)
- Visualiser l'état de toutes les ruches de son site
- Prioriser les visites terrain selon les alertes générées par le modèle prédictif
- Valider les récoltes déclarées par les coopératives
- Faire remonter les anomalies d'infrastructure (capteur hors ligne, passerelle en panne)

#### Gestionnaire association (6)
- Superviser l'ensemble des sites et coopératives
- Consulter les analytics consolidés et prédictions de rendement
- Générer les rapports d'impact pour les bailleurs
- Gérer les alertes critiques (santé colonie, infrastructure)

#### Administrateur (3)
- Gérer les utilisateurs, rôles et permissions
- Superviser les déploiements et l'état de l'infrastructure (**vue DevOps**)
- Superviser la sécurité et les journaux (**vue Cyber**)
- Configurer les seuils d'alerte par type de ruche et de site

> 💡 *Explication.* Quatre rôles = quatre niveaux de permissions (RBAC). Le total d'utilisateurs est d'environ **317 comptes** (300 + 8 + 6 + 3). L'administrateur est le seul profil qui voit à la fois la vue DevOps (déploiements) et la vue Cyber (sécurité) : c'est donc l'utilisateur direct des dashboards produits par notre spécialité.

---

## IV. SCÉNARIOS ET CAS D'UTILISATION

### 4.1 Cas d'utilisation Apiculteur / Apicultrice

#### UC-A01 : Enregistrement d'une visite d'inspection (hors ligne)
- **Acteur** : apiculteur/trice authentifié(e)
- **Précondition** : application mobile installée, session ouverte (avec ou sans réseau)
- **Scénario principal** :
  1. L'apiculteur ouvre l'application, même sans connexion
  2. Il sélectionne la ruche concernée (liste ou QR code)
  3. Il renseigne l'inspection : état visuel, présence de la reine, comportement
  4. Il peut ajouter une photo
  5. Il valide l'inspection, stockée localement
  6. Dès reconnexion, l'application synchronise automatiquement les données vers le serveur central
  7. Le coordinateur reçoit une notification si une anomalie est signalée
- **Post-condition** : inspection enregistrée, synchronisée dès que possible.
- **Exceptions** : conflit de synchronisation (double saisie), ruche introuvable.

#### UC-A02 : Réception d'une alerte de risque
- **Acteur** : apiculteur/trice
- **Scénario principal** :
  1. Le système détecte un risque (chute de poids anormale, activité acoustique atypique)
  2. Une alerte est envoyée à l'apiculteur concerné (push si connecté, sinon au prochain accès)
  3. L'apiculteur consulte le détail : type de risque, niveau de confiance, recommandation
  4. Il peut planifier ou signaler une visite anticipée

#### UC-A03 : Déclaration d'une récolte
- **Acteur** : apiculteur/trice
- **Scénario principal** :
  1. L'apiculteur sélectionne la ruche récoltée
  2. Il saisit le volume de miel récolté et la date
  3. Le système compare la déclaration à la prédiction de rendement du modèle
  4. La coopérative et le coordinateur sont notifiés

### 4.2 Cas d'utilisation Coordinateur régional

#### UC-C01 : Priorisation des visites terrain
- **Acteur** : coordinateur régional authentifié
- **Scénario principal** :
  1. Le coordinateur accède au tableau de bord de son site
  2. Il visualise les ruches classées par niveau de risque (score prédictif)
  3. Il planifie les visites en fonction de la criticité et de la géolocalisation
  4. Il assigne les visites aux apiculteurs concernés

#### UC-C02 : Validation d'une récolte
- **Acteur** : coordinateur régional
- **Scénario principal** :
  1. Le coordinateur consulte les récoltes déclarées en attente
  2. Il compare avec les données de poids issues des capteurs
  3. Il valide ou signale un écart à investiguer

### 4.3 Cas d'utilisation Gestionnaire association

#### UC-G01 : Consultation des analytics consolidés
- **Acteur** : gestionnaire association
- **Scénario principal** :
  1. Le gestionnaire accède au dashboard multi-sites
  2. Il visualise les indicateurs clés : rendement, colonies à risque, taux de couverture réseau
  3. Il compare les sites et pays entre eux
  4. Il identifie les tendances nécessitant une intervention

#### UC-G02 : Génération d'un rapport d'impact bailleur
- **Acteur** : gestionnaire association
- **Scénario principal** :
  1. Le gestionnaire sélectionne la période et le(s) site(s) concernés
  2. Il choisit les indicateurs à inclure (rendement, colonies sauvées, coopératives actives)
  3. Le système génère un rapport PDF structuré avec graphiques
  4. Le rapport est téléchargé ou envoyé par email au bailleur

### 4.4 Cas d'utilisation Administrateur

#### UC-AD01 : Gestion des utilisateurs et des rôles
1. L'administrateur consulte la liste des utilisateurs multi-sites
2. Il crée, modifie ou désactive un compte
3. Il assigne les rôles et permissions par site
4. Toutes les actions sont tracées

### 4.5 Cas d'utilisation transversaux

#### UC-T01 : Authentification et synchronisation sécurisée
- L'utilisateur s'authentifie (email/mot de passe, **MFA** pour coordinateurs/gestionnaires/admins)
- Le système génère un **JWT** avec expiration adaptée aux usages hors-ligne prolongés
- Les données locales sont **chiffrées avant synchronisation**
- **Exceptions** : identifiants incorrects (**blocage après 5 tentatives**), conflit de synchronisation

#### UC-T02 : Réception de données IoT
- Le capteur mesure poids, température, humidité et activité acoustique
- Il transmet via LoRaWAN vers la passerelle du site : `hive_id`, mesures, `timestamp`
- La passerelle agrège et transmet en différé au broker central dès que la liaison le permet
- Les données transitent vers le pipeline de traitement puis la base centrale
- **Fréquence** : toutes les 30 minutes, ou immédiatement en cas de dépassement de seuil

> ⚠️ *Point d'attention.* UC-T02 indique « toutes les 30 minutes » alors que le chapitre 6.4 fixe poids/température/humidité à **1 mesure / 15 min** (seule l'acoustique est à 1 échantillon / 30 min). Voir la section C.7 (incohérences).

### 4.6 Cas d'utilisation Cyber — Gestion des incidents techniques

Les sites étant isolés, alimentés parfois par panneaux solaires, et reliés par une liaison radio ou cellulaire instable, la spécialité Cyber doit détecter et traiter des incidents spécifiques au contexte multi-sites, en plus des menaces classiques.

#### UC-CY01 : Détection d'une passerelle hors-ligne / site isolé
- **Acteur** : système de supervision (Cyber)
- **Déclencheur** : absence de heartbeat de la passerelle du site au-delà de **15 minutes**
- **Scénario principal** :
  1. Le système de supervision détecte l'absence de battement de cœur de la passerelle
  2. Une alerte est levée (niveau site) vers le tableau de bord central
  3. La passerelle bascule automatiquement en **mode dégradé** : mise en cache locale des mesures
  4. Dès rétablissement, la passerelle resynchronise l'ensemble des données mises en cache
- **Résultat attendu** : aucune perte de donnée, visibilité claire de l'indisponibilité pour les coordinateurs.
- **Livrable** : dashboard de disponibilité par site + procédure de reprise documentée.

#### UC-CY02 : Détection d'une falsification ou d'un rejeu de données capteur
- **Acteur** : pipeline d'ingestion (Cyber/Data)
- **Déclencheur** : trame hors plage physique valide, ou timestamp/compteur déjà reçu (rejeu)
- **Scénario principal** :
  1. Le pipeline d'ingestion valide chaque trame reçue (plages physiques, unicité, authentification capteur)
  2. Une trame invalide ou dupliquée est rejetée et journalisée
  3. Une alerte d'intégrité est levée si le phénomène se répète sur une même ruche/passerelle
  4. L'équipe Cyber investigue (capteur compromis, erreur matérielle, tentative d'intrusion)
- **Résultat attendu** : les décisions (alertes essaimage, rapports bailleurs) ne reposent jamais sur une donnée non fiable.
- **Livrable** : règles de validation à l'ingestion + journal d'intégrité.

#### UC-CY03 : Détection d'un brouillage ou d'une interférence radio LoRaWAN
- **Acteur** : passerelle LoRaWAN / supervision réseau
- **Déclencheur** : taux d'échec de réception anormal sur un canal radio
- **Scénario principal** :
  1. La passerelle mesure en continu le taux de trames perdues/corrompues par canal
  2. Un seuil anormal déclenche une alerte de brouillage potentiel
  3. Le système peut proposer un changement de canal ou de spreading factor
  4. L'incident est journalisé pour analyse de tendance (brouillage ponctuel vs récurrent)
- **Résultat attendu** : maintien de la couverture radio malgré les perturbations.
- **Livrable** : dashboard qualité radio par site + procédure d'escalade.

#### UC-CY04 : Détection d'un déplacement anormal (vol de ruche)
- **Acteur** : pipeline d'ingestion / supervision géospatiale (Cyber + Data)
- **Déclencheur** : la position GPS transmise par la ruche s'écarte de sa position de référence au-delà d'un seuil
- **Scénario principal** :
  1. Chaque trame capteur inclut la position GPS de la ruche (latitude/longitude)
  2. Le système compare en continu la position reçue à la position de référence enregistrée
  3. Un écart significatif (hors zone de tolérance) déclenche une alerte de déplacement
  4. Le système distingue un déplacement **déclaré** (transhumance planifiée par l'apiculteur) d'un déplacement **non déclaré**
  5. En cas de déplacement non déclaré, une alerte prioritaire est envoyée au coordinateur et à l'administrateur
- **Résultat attendu** : détection rapide d'un vol de ruche, levier de dissuasion et de récupération pour les coopératives.
- **Livrable** : règle de détection de dérive géospatiale (PostGIS) + workflow d'alerte prioritaire.

#### Autres types d'incidents techniques à superviser

| Type d'incident | Détection | Impact | Action attendue |
|----------------|-----------|--------|-----------------|
| Capteur silencieux (batterie/panne) | Absence de trame après 2 cycles de mesure | Ruche non supervisée | Alerte technique au coordinateur |
| Rupture du tunnel VPN site-central | Perte de tunnel > 5 min | Synchronisation bloquée | Bascule cache local, reprise automatique |
| Coupure d'alimentation prolongée (solaire/batterie) | Monitoring onduleur/batterie | Arrêt total de la passerelle | Bascule secours, alerte si durée excessive |
| Tentative d'intrusion sur une passerelle | IDS local, logs d'authentification | Compromission possible du site | Isolement réseau + alerte SOC |
| Saturation de la file de synchronisation | Taille de file > seuil | Retard d'actualisation des données | Priorisation des alertes critiques |

> 💡 *Explication.* Pour la spécialité Dev, les incidents « **saturation de la file de synchronisation** » et « **rupture du tunnel VPN** » sont les plus directement liés à son périmètre (file de messages, cache local, reprise automatique). Les UC-CY01 à CY04 sont portés par Cyber, mais s'appuient sur l'infrastructure edge et le simulateur que Dev fournit.

---

## V. SPÉCIFICATIONS FONCTIONNELLES PAR SPÉCIALITÉ

### 5.1 Modules communs (toutes spécialités)

| Module | Fonctionnalités clés |
|--------|---------------------|
| Authentification | Inscription, login, JWT, RBAC (4 rôles), MFA pour rôles à privilèges |
| Dashboard | Carte multi-sites, état des ruches, KPIs consolidés |
| Notifications | Alertes push différées, email, synchronisation hors-ligne |
| Profil utilisateur | Gestion compte, site de rattachement, historique |

### 5.2 Modules — Spécialité DÉVELOPPEMENT (orientation DevOps)

Sur QueenBee, la spécialité Développement se positionne sur son domaine **DevOps** : elle **industrialise, déploie et exploite** la plateforme construite avec Data et Cyber, plutôt que de développer l'intégralité du frontend/backend. Ce choix s'appuie sur les modules du tronc commun M1 (CI/CD Fondamentaux, Docker & Containers, Cloud Basics AWS/Azure) et sur les modules de spécialité DEV touchant l'exploitation (Observability & Monitoring Basics, Event-Driven & Message Queues, Security Best Practices).

| Module | Fonctionnalités clés |
|--------|---------------------|
| Conteneurisation | Conteneurisation des services (API, pipelines, app mobile backend) avec Docker |
| CI/CD Multi-sites | Pipelines de build, test et déploiement automatisé vers les passerelles de site |
| Infrastructure as Code | Provisioning reproductible des environnements (site pilote + central) |
| Orchestration Edge | Déploiement conteneurisé léger sur passerelles locales (K3s ou équivalent) |
| Observabilité & Monitoring | Supervision des déploiements, des files de synchronisation et des services |
| Gestion des synchronisations | Files de messages pour la synchronisation différée site ↔ central (event-driven) |
| Support applicatif | Backend d'API minimal nécessaire à l'exploitation (santé, endpoints techniques) |
| Workflows n8n | Automatisation des intégrations API (notifications, webhooks) et des tâches de synchronisation |
| DevSecOps (Snyk) | Scan des dépendances et des conteneurs à chaque build, porte de sécurité avant déploiement |

**Livrables attendus** : pipelines CI/CD fonctionnels, conteneurs versionnés, scripts IaC documentés, dashboards d'exploitation, documentation de déploiement multi-sites, intégration Snyk dans la CI/CD.

### 5.3 Modules — Spécialité DATA SCIENCE

| Module | Fonctionnalités clés |
|--------|---------------------|
| PostGIS & Géospatial | Géolocalisation des ruchers et sites, clustering, cartes de densité |
| Prédiction Santé Colonie | Détection précoce du risque d'essaimage et d'affaiblissement (ML) |
| Prévision de Rendement | Modèles prédictifs du volume de miel par ruche/site/saison |
| ETL / Pipelines | Ingestion des données capteurs, inspections et météo, en mode batch et streaming |
| Analytics & Reporting | Dashboards multi-sites, rapports d'impact automatisés pour bailleurs |
| Data Warehouse | Modèle en étoile pour l'historisation des mesures et des récoltes |
| Orchestration n8n | Automatisation des pipelines de reporting et des déclenchements de rafraîchissement |
| Sécurité des pipelines (Snyk) | Scan des dépendances Python et des images des pipelines ETL |

#### Focus : estimation de la population et score de santé de la colonie

Le comptage direct des abeilles n'étant pas réalisable par capteur, la population est estimée **indirectement** à partir de plusieurs signaux corrélés — c'est un point clé du modèle prédictif à concevoir par les étudiants Data.

- **Population de référence** : une colonie saine compte entre **20 000 et 60 000 abeilles** selon la saison (pic en période de miellée, minimum en saison sèche/hivernale)
- **Indicateur acoustique** : la fréquence et l'intensité du bourdonnement (features extraites en edge) sont corrélées à l'activité et à la taille de la colonie, ainsi qu'à la présence de la reine (signature acoustique différente en cas d'absence de reine)
- **Indicateur de poids** : une variation de poids anormale (hors miellée) est un indicateur indirect de variation de population
- **Indicateur thermique** : les abeilles régulent la température du couvain autour de **34-35 °C** ; un écart prolongé signale un stress, une maladie ou une perte de reine

**Indicateurs de risque de mortalité / d'essaimage à modéliser :**

| Signal | Seuil indicatif | Risque associé |
|--------|----------------|----------------|
| Chute de poids brutale | > 0,5 kg en moins de 2 h (hors récolte) | Essaimage en cours |
| Chute d'activité acoustique | > 30 % de baisse en 72 h | Affaiblissement / mortalité de la colonie |
| Écart de température du couvain | > 3 °C d'écart sur plus de 6 h | Stress thermique, maladie, perte de reine |
| Immobilité quasi totale prolongée | Activité quasi nulle > 24 h | Colonie probablement morte |
| Canicule externe (donnée météo) | Température externe > seuil local | Risque de stress thermique accru |

Ces seuils sont **indicatifs** et doivent être affinés par les étudiants à partir de données réelles ou de la littérature apicole ; ils servent de base à la construction d'un **score de santé de colonie (0-100)** combinant les différents signaux, alimentant les alertes envoyées aux apiculteurs et coordinateurs (cf. UC-A02, UC-C01).

### 5.4 Modules — Spécialité CYBER-RÉSEAUX

Sur QueenBee, la spécialité Cyber-Réseaux est responsable de l'**infrastructure de l'association BeeAfrica** : sécurisation des sites distants, interconnexion, protection des données des bénéficiaires et continuité d'activité.

| Module | Fonctionnalités clés |
|--------|---------------------|
| Infrastructure Multi-sites | Architecture réseau par site (DMZ, LAN, IoT, Management) et interconnexion centrale |
| Sécurité Passerelles IoT | Authentification des passerelles LoRaWAN, chiffrement des communications |
| Firewall & Segmentation (Fortinet) | FortiGate par site : filtrage inter-zones, isolement du trafic IoT, VPN |
| Monitoring & Supervision | Supervision de la disponibilité des sites et passerelles |
| Continuité d'Activité | Sauvegardes chiffrées, procédures de reprise en cas de coupure prolongée |
| SIEM/SOC (FortiAnalyzer/FortiSIEM) | Centralisation des journaux et détection d'anomalies multi-sites |
| Réponse automatisée (n8n) | Playbooks déclenchés par les alertes : isolement, notification SOC, journalisation |
| Sécurité de l'infrastructure (Snyk) | Scan des scripts Infrastructure as Code (Ansible) avant déploiement |

---

## VI. ARCHITECTURE SYSTÈME MULTI-SPÉCIALITÉS

### 6.1 Architecture globale intégrée

```
┌─────────────────────────────────────────────────────────────────┐
│                    UTILISATEURS                                 │
│   (Apicultrices/teurs, Coordinateurs, Gestionnaires, Admins)    │
└───────────────────────────┬─────────────────────────────────────┘
                            │ HTTPS (TLS 1.3) / App offline-first
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│              CLOUD CENTRAL (Cyber + Dev DevOps)                 │
│   Reverse Proxy / LB   │   API Backend   │   Monitoring central │
└───────────────────────────┬─────────────────────────────────────┘
                            │
┌───────────────────────────▼─────────────────────────────────────┐
│                 ZONE DATA (Data Science)                        │
│   PostgreSQL + PostGIS   │   Data Warehouse   │   Pipelines ML   │
└───────────────────────────┬─────────────────────────────────────┘
                            │ Synchronisation différée (VPN)
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│           SITE LOCAL (x8) — Edge (Dev DevOps + Cyber)           │
│   Passerelle LoRaWAN   │   Edge compute (cache local)           │
└───────────────────────────┬─────────────────────────────────────┘
                            │ LoRaWAN
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│         RUCHES CONNECTÉES (400) — Capteurs IoT (Cyber)          │
│   Poids · Température · Humidité · Acoustique                   │
└─────────────────────────────────────────────────────────────────┘
```

> 💡 *Explication.* Quatre couches empilées : (1) **utilisateurs**, (2) **cloud central** (API, proxy, monitoring — Dev + Cyber), (3) **zone Data** (base, entrepôt, ML), (4) **8 sites locaux** avec une passerelle LoRaWAN et un cache edge (Dev + Cyber), et tout en bas les **400 ruches**. La liaison site ↔ central est **différée et chiffrée (VPN)** parce que le réseau est intermittent.

### 6.2 Flux de données inter-spécialités

- **Flux 1 : Capteur → Dashboard central (asynchrone)**
  Capteur IoT → Passerelle LoRaWAN (Cyber) → Edge cache (Dev) → Synchronisation VPN → Pipeline (Data) → Dashboard
- **Flux 2 : Mesures → Prédiction (batch)**
  Passerelle → Staging (Data) → ETL → Data Warehouse (Data) → Modèle prédictif → Alerte
- **Flux 3 : Inspection terrain → Validation (transactionnel)**
  App mobile (offline) → Synchronisation (Dev DevOps) → API centrale → Base (Data) → Logs (Cyber)

### 6.3 Architecture réseau (spécialité Cyber-Réseaux)

*Note : cette architecture présente une cible simplifiée par site. Les étudiants Cyber-Réseaux doivent la concevoir et la documenter en détail pour un site pilote, puis généraliser aux autres sites.*

#### Zones de sécurité par site

| Zone | VLAN | Réseau | Fonction | Niveau de confiance |
|------|------|--------|----------|---------------------|
| DMZ locale | 10 | 10.10.1.0/24 | Passerelle exposée, VPN vers central | 🔴 Faible |
| LAN Applicatif | 20 | 10.10.2.0/24 | Edge compute, cache local | 🟡 Moyen |
| IoT | 40 | 10.10.4.0/24 | Ruches connectées, broker LoRaWAN | 🔴 Faible |
| Management | 30 | 10.10.3.0/24 | Supervision, sécurité, administration | 🟢 Élevé |

#### Interconnexion des sites
- VPN site-à-site (**WireGuard ou IPsec**) entre chaque site et le cloud central
- Bascule automatique en **mode dégradé** (cache local) en cas de coupure de liaison
- Chiffrement systématique des données en transit et au repos
- Journalisation centralisée dès rétablissement de la liaison

### 6.4 Volumétrie et fréquence de collecte des données

Le LoRaWAN impose des contraintes fortes (**duty cycle réglementaire ~1 % en bande EU868**, **payload utile de l'ordre de 20 à 51 octets** selon le spreading factor). L'échantillonnage doit donc être **adaptatif** : fréquence réduite en fonctionnement normal, resserrée automatiquement en cas de suspicion d'anomalie.

#### Fréquences de mesure par capteur

| Capteur | Fréquence normale | Fréquence en surveillance renforcée | Taille trame LoRaWAN |
|---------|------------------|-------------------------------------|---------------------|
| Poids | 1 mesure / 15 min | 1 mesure / 5 min pendant 6 h si anomalie | ~6 octets |
| Température (interne/externe) | 1 mesure / 15 min | 1 mesure / 5 min | ~4 octets |
| Humidité | 1 mesure / 15 min | 1 mesure / 5 min | ~2 octets |
| Acoustique / vibration (activité colonie) | 1 échantillon de 10 s / 30 min, analysé en local | 1 échantillon / 10 min | ~8 octets (features, pas l'audio brut) |

Le signal acoustique brut **n'est jamais transmis** par LoRaWAN : son traitement (extraction de fréquence, estimation d'activité) est réalisé **en local sur la passerelle** (edge computing, périmètre **Dev DevOps**), et seul un vecteur de features compact est transmis — point de conception important pour Cyber (surface d'attaque réduite) et Dev (charge de calcul edge).

#### Volumétrie estimée (400 ruches, 8 sites)

| Indicateur | Calcul | Valeur estimée |
|-----------|--------|---------------|
| Mesures poids/temp/humidité par jour | 400 ruches × 96 mesures/jour (1/15 min) | ≈ **38 400 mesures/jour** |
| Débit moyen en fonctionnement normal | 38 400 / 1 440 min | ≈ **27 mesures/minute** (réseau entier) |
| Estimations acoustiques par jour | 400 ruches × 48 échantillons/jour (1/30 min) | ≈ **19 200 estimations/jour** |
| Volume radio brut (trames capteurs) | 38 400 × ~20 octets | ≈ **750 Ko/jour** sur l'ensemble du réseau |
| Volume en base (avec métadonnées) | (38 400 + 19 200) × ~180 octets | ≈ **10 Mo/jour**, soit ≈ **300 Mo/mois** |
| Charge moyenne par passerelle de site | 400 ruches / 8 sites | ≈ **50 ruches**, ≈ **4 800 mesures/jour/site** |

Ces ordres de grandeur restent modestes en volume brut : **l'enjeu technique n'est pas le stockage mais la fiabilité de la collecte en connectivité intermittente** (mise en cache locale, synchronisation différée, déduplication) et le respect du duty cycle LoRaWAN. Ils doivent être vérifiés et affinés par les étudiants Data/Dev/Cyber en fonction du matériel réellement choisi.

### 6.5 Format des messages capteurs

Chaque trame inclut la **géolocalisation** de la ruche. Au-delà de la cartographie (PostGIS, Data), ce champ alimente une détection de vol de ruche : une ruche est immobile par nature, tout déplacement non déclaré est un signal fort (cf. UC-CY04).

```json
{
  "hive_id": "SN-CASA-014",
  "site_id": "SN-CASA",
  "timestamp": "2027-03-14T08:15:00Z",
  "position_lat": 12.5833,
  "position_lon": -16.2833,
  "weight_kg": 34.2,
  "temp_internal_c": 34.8,
  "temp_external_c": 27.1,
  "humidity_pct": 58,
  "acoustic_activity_score": 0.72,
  "battery_pct": 91
}
```

La position est transmise à chaque trame (surcoût négligeable au regard de la marge calculée en 6.4). Sur le terrain, ce message correspond à la donnée déjà agrégée par la passerelle ; le payload LoRaWAN brut reste encodé de façon compacte (binaire), le JSON ci-dessus représentant la donnée telle que reçue et stockée côté central.

### 6.6 Simulateur de capteurs et de scénarios

Les ruchers réels étant situés en Afrique et le développement se déroulant à Paris/Évry, un **simulateur est indispensable dès le Sprint 0** pour que les trois spécialités puissent travailler avant tout déploiement matériel. C'est un **livrable d'infrastructure transverse, porté par la spécialité Développement (DevOps)**, utilisé par les trois.

> 🎯 *Responsabilité directe de notre spécialité : le simulateur est un livrable Dev critique, bloquant pour Data et Cyber dès le Sprint 0.*

#### Principe
- Le simulateur joue le rôle exact d'une **passerelle LoRaWAN + capteurs** : il publie sur le **même point d'entrée (topic MQTT)** que le matériel réel utiliserait
- Le reste de la chaîne (ingestion, dashboards, modèles Data, supervision Cyber) **ne fait aucune différence** entre donnée simulée et donnée réelle
- Un **facteur d'accélération temporelle** configurable (ex : 1 minute réelle = 1 heure simulée) permet de rejouer une saison complète en quelques heures de test, ou un scénario complet en quelques minutes pour une démonstration

#### Modèle de génération par ruche
- **Tendance saisonnière** : poids qui augmente en période de miellée, diminue en saison sèche
- **Cycle journalier** : température/humidité selon l'heure, activité acoustique circadienne (forte le jour, quasi nulle la nuit)
- **Bruit réaliste** : variabilité gaussienne type capteur bas coût
- **Dérive batterie** : silence progressif d'un capteur en fin de vie
- **Position GPS stable**, avec possibilité d'injection d'une dérive pour tester la détection de vol (UC-CY04)

#### Profils climatiques par site (8 sites, 3 pays)

| Pays | Sites | Profil climatique | Impact sur le signal simulé |
|------|-------|-------------------|----------------------------|
| Sénégal (Casamance) | 3 | Soudano-sahélien : saison sèche longue (nov-mai), pluies courtes (juin-oct) | Une seule miellée marquée, stress thermique fréquent en saison sèche |
| Côte d'Ivoire (zone forestière) | 3 | Tropical humide bimodal (2 saisons des pluies) | Deux miellées par an, humidité élevée en continu |
| Cameroun (Ouest, altitude) | 2 | Tropical d'altitude, plus frais | Miellée plus étalée, moins de stress thermique, plus de variabilité jour/nuit |

Chaque site a ses propres paramètres (température de base, amplitude saisonnière, calendrier de miellée, humidité de base) plutôt qu'un profil unique dupliqué — ce qui permet à Data de vérifier si son modèle **généralise entre sites** ou surapprend sur un seul climat.

#### Comportement simulé des apiculteurs

Le simulateur ne se limite pas à l'IoT : il simule aussi des **utilisateurs humains imparfaits**, pour que Dev et Data travaillent sur des données réalistes (inspections manquantes, connexions sporadiques) plutôt qu'un flux propre irréaliste.

| Profil | Part simulée | Comportement |
|--------|-------------|-------------|
| Assidu | ~30 % | Inspection hebdomadaire, synchronise dès que possible |
| Régulier | ~50 % | Inspection toutes les 2-3 semaines |
| Occasionnel | ~20 % | Inspection mensuelle ou irrégulière, connexion sporadique |

Les déclarations de récolte sont générées automatiquement autour des pics de miellée par site, avec un écart aléatoire par rapport à la prédiction du modèle, pour donner à Data un signal réel à comparer (cf. UC-C02).

#### Moteur de scénarios

Un scénario est une **timeline déclarative**, pas du code figé — ce qui permet de connaître le **moment exact d'injection** d'une anomalie et donc de mesurer objectivement si un modèle ou une supervision la détecte (précision, délai de détection).

```yaml
scenario: "essaimage_ruche_014"
hive: SN-CASA-014
timeline:
  - t=0j     : comportement normal
  - t=10j    : début dérive (activité acoustique -2%/jour)
  - t=15j    : chute de poids brutale (-0.8kg en 1h)
  - t=15j+1h : retour à une activité normale (population réduite)
```

- **Scénarios prévus au minimum** : essaimage, mortalité/affaiblissement progressif, stress thermique, passerelle hors-ligne, brouillage radio, injection/rejeu de données falsifiées, déplacement non déclaré (vol)
- Chaque scénario est **rejouable à la demande**, avec un **horodatage de vérité terrain** servant à l'évaluation des modèles Data et des automatisations Cyber

#### Déploiement du simulateur

| Mode | Utilisateurs | Caractéristiques |
|------|-------------|-----------------|
| Local (Docker) | Dev, Data | `docker-compose up` ; sous-ensemble léger (1-2 sites) ; redémarrable à volonté, itération rapide |
| Central (serveur Proxmox) | Cyber | Instance persistante, flotte complète (8 sites, 400 ruches) ; nécessaire pour un flux stable à superviser en continu (SIEM, dashboards de disponibilité) |

Sur l'instance centrale, les scénarios d'incident sont déclenchables via une **commande/API du simulateur**, pour que Cyber puisse tester et démontrer ses automatisations de réponse (cf. 6.7) sans dépendre d'un pilotage manuel externe.

### 6.7 Boucle d'automatisation de la réponse à incident

La spécialité Cyber ne se contente pas de détecter les incidents injectés par le simulateur : elle **automatise la réponse**. Cette boucle s'appuie sur trois outils partenaires intégrés au projet : **Fortinet, n8n et Snyk**, chacun sur un maillon différent.

```
Simulateur : injecte un incident (scénario)
        │
        ▼
FortiGate (par site) + FortiAnalyzer/FortiSIEM (central)   ← détection / corrélation (Cyber)
        │  webhook / alerte
        ▼
n8n   ← orchestration du playbook de réponse (appelle l'API FortiGate,
         isole le site/VLAN concerné, notifie le SOC)
        │
        ▼
Action exécutée + journalisée (cf. UC-CY01 à UC-CY04)
```

| Outil | Rôle dans QueenBee | Spécialité(s) |
|-------|--------------------|---------------|
| Fortinet (FortiGate, FortiAnalyzer/FortiSIEM) | Firewall par site, détection et corrélation des incidents (remplace/complète pfSense) | Cyber |
| n8n | Orchestrateur : playbooks de réponse à incident (Cyber) ; workflows d'intégration API et de notification (Dev) ; orchestration ETL et de rapports (Data) | Cyber / Dev / Data |
| Snyk | Porte de sécurité DevSecOps dans chaque pipeline CI/CD : dépendances et conteneurs (Dev), dépendances et images des pipelines (Data), scripts Infrastructure as Code (Cyber) | Dev / Data / Cyber |

Fortinet et Snyk s'appuient sur des modules déjà cartographiés dans le référentiel (NSE4/NSE5 pour Fortinet sur Réseaux Avancés & Firewall et SIEM Basics ; Snyk sur DevSecOps M2 DEV et Security Testing & SAST/DAST M1 CYBER). n8n est traité comme un **outil transverse** : trois usages distincts (playbooks Cyber, intégrations Dev, orchestration Data) plutôt qu'un seul module dédié.

---

## VII. MODÈLE DE DONNÉES

La conception détaillée du modèle de données fait partie du travail attendu des étudiants. Ce chapitre présente uniquement les **concepts métier** à modéliser, sans imposer de structure.

### 7.1 Concepts métier à modéliser
- **Utilisateurs** : apiculteur/trice, coordinateur, gestionnaire, admin
- **Ruches** : identifiant, site, coopérative, capteurs associés, position GPS de référence
- **Sites / Coopératives** : localisation, pays, apicultrices rattachées
- **Mesures IoT** : poids, température, humidité, acoustique, horodatage
- **Inspections** : observations terrain, photos, statut de la colonie
- **Récoltes** : volume déclaré, date, ruche, écart vs prédiction
- **Alertes** : type de risque, niveau de confiance, statut de traitement

### 7.2 Contraintes de conception

**Contraintes fonctionnelles :**
- Gestion de **400 ruches** avec historique complet des mesures
- Fonctionnement en **mode déconnecté** côté terrain, avec synchronisation différée
- **Traçabilité complète** des actions utilisateurs (bénéficiaires vulnérables)

**Contraintes techniques :**
- Base **PostgreSQL** avec extension **PostGIS** pour la géolocalisation des sites
- Gestion des **conflits de synchronisation** (données saisies hors-ligne)
- Support des **séries temporelles** pour les mesures capteurs

### 7.3 Livrables attendus (conception)
- Dictionnaire de données
- Modèle Conceptuel (MCD)
- Modèle Logique (MLD)
- Scripts DDL
- Justification des choix

---

## VIII. EXIGENCES NON FONCTIONNELLES

### 8.1 Performance

| Métrique | Cible | Responsable |
|----------|-------|-------------|
| Temps de réponse API centrale | **< 500 ms (p95)** | Dev |
| Requêtes SQL analytiques | **< 200 ms (90 %)** | Data |
| Synchronisation après reconnexion | **< 2 min pour 1 jour de données** | Dev (DevOps) |
| Débit LoRaWAN par site | 50 messages/min | Cyber |
| Disponibilité edge local en coupure | Fonctionnement dégradé garanti | Dev/Cyber |

### 8.2 Sécurité (focus Cyber)

| Exigence | Implémentation | Responsable |
|----------|----------------|-------------|
| Chiffrement transport | TLS 1.3 + VPN site-à-site | Cyber |
| Authentification | JWT + MFA (rôles à privilèges) | Dev/Cyber |
| RBAC | 4 rôles, moindre privilège | Dev |
| Protection données bénéficiaires | Chiffrement au repos, minimisation | Cyber |
| Audit trail | Logs centralisés dès reconnexion | Cyber |
| Sécurité passerelles IoT | Authentification par certificat | Cyber |

### 8.3 Disponibilité et continuité

| Métrique | Cible | Responsable |
|----------|-------|-------------|
| Uptime cloud central | 99 % | Cyber |
| RTO (reprise après incident) | < 8 h | Cyber |
| RPO | < 24 h | Cyber/Data |
| Sauvegardes | Quotidiennes, chiffrées | Cyber |

#### Ce qui est réellement attendu (à lire avant de s'inquiéter)

Ce chapitre décrit une **exigence de conception**, pas une astreinte opérationnelle. Vous n'êtes pas évalués sur la disponibilité réelle d'un service en production 24/7 — QueenBee est un **projet pédagogique**, pas un déploiement commercial. Vous êtes évalués sur la **pertinence de votre conception** et sur votre capacité à la **démontrer par un test contrôlé et documenté**, pas sur un monitoring ininterrompu pendant 5 mois.

- **Concevoir** : proposer un mécanisme de redondance/reprise réaliste pour l'architecture BeeAfrica (ex : réplication du SIEM central, bascule d'un composant, sauvegarde et restauration)
- **Démontrer** : provoquer une panne contrôlée à l'aide du simulateur (cf. UC-CY01 : coupure de passerelle) et montrer que le mécanisme fonctionne, **chronométré**
- **Documenter** : rédiger la procédure de reprise comme vous la donneriez à un collègue qui n'a jamais vu votre système

**Ce qui n'est pas attendu :**
- Un cluster actif-actif avec bascule automatique en quelques secondes (disproportionné pour ce contexte)
- Une disponibilité surveillée en continu hors des séances de projet
- Une haute disponibilité sur les sites locaux eux-mêmes : le mode dégradé (cache local, cf. section VI) suffit

#### Mécanismes suggérés (à adapter, pas à copier tel quel)

| Composant | Mécanisme suggéré | Ce qui est démontré |
|-----------|------------------|--------------------|
| Cloud central (API, base) | Sauvegarde régulière + procédure de restauration testée | RPO tenu, restauration fonctionnelle |
| SIEM central | Export/réplication périodique des journaux vers un second emplacement | Pas de perte de visibilité en cas de panne |
| Broker MQTT central | Redémarrage automatisé + files de synchronisation qui rattrapent le retard | Aucune donnée perdue après une coupure |
| FortiGate (VDOM du groupe) | Sauvegarde de configuration versionnée | Restauration rapide d'une politique de pare-feu |

> **Un seul de ces mécanismes, bien conçu et réellement démontré lors d'une panne simulée, vaut mieux que plusieurs mécanismes théoriques non testés.**

### 8.4 Conformité
- Protection des **données à caractère personnel** des bénéficiaires (consentement, minimisation)
- **Souveraineté** et localisation des données conforme aux exigences des pays hôtes
- **Accessibilité** de l'application mobile pour des utilisateurs peu familiers du numérique

---

## IX. STACK TECHNIQUE RECOMMANDÉE PAR SPÉCIALITÉ

Les technologies ci-dessous sont **recommandées et non imposées**. Les étudiants peuvent proposer des alternatives justifiées, à condition de respecter les objectifs fonctionnels et les contraintes de connectivité intermittente.

### 9.1 Spécialité DÉVELOPPEMENT (DevOps)
**Focus : industrialisation, conteneurisation, déploiement multi-sites, exploitation**

- Conteneurisation : **Docker**
- Orchestration edge : **K3s** (ou Docker Compose pour sites à faible capacité)
- CI/CD : **GitHub Actions** ou GitLab CI
- Infrastructure as Code : **Ansible** (recommandé) ou Terraform
- Monitoring : **Prometheus + Grafana**
- Messaging (sync différée) : **MQTT** ou RabbitMQ
- API technique minimale : **Node.js/Express** ou Python/FastAPI
- Automatisation de workflows : **n8n** (intégrations API, notifications, synchronisation)
- DevSecOps : **Snyk** (scan dépendances et conteneurs, intégré à la CI/CD)

**Modules obligatoires :**
- Pipeline CI/CD complet (build, test, déploiement) avec porte de sécurité Snyk
- Conteneurisation de l'ensemble des services applicatifs
- Scripts IaC pour le provisioning d'un site pilote
- Dashboard d'exploitation (déploiements, synchronisations, incidents)
- Mécanisme de synchronisation différée site ↔ central
- Au moins un workflow n8n fonctionnel (intégration API ou notification)
- Documentation de déploiement multi-sites

**Livrables spécifiques :**
- Code source (GitHub)
- Pipelines CI/CD fonctionnels avec scan Snyk
- DCT 30-35 pages
- Scripts IaC documentés
- Workflows n8n exportés
- Environnement de démonstration déployé

### 9.2 Spécialité DATA SCIENCE
**Focus : prédiction, analytics, ETL, géospatial**

- Base de données : PostgreSQL + PostGIS
- ETL : Airflow (concepts) + dbt
- Analytics : Python (Pandas, NumPy, Scikit-learn)
- DataViz : Grafana, Metabase ou Superset
- ML : Scikit-learn (classification, régression, séries temporelles)
- Orchestration low-code : n8n (déclenchement de rapports, alertes, rafraîchissements)
- DevSecOps : Snyk (scan dépendances Python et images des pipelines)

**Modules obligatoires :**
- Data Warehouse en étoile (faits + dimensions)
- PostGIS pour la géolocalisation des sites et ruchers, incluant la détection de dérive de position (UC-CY04)
- Pipelines ETL batch (et streaming en concept)
- Modèle prédictif : risque d'essaimage / santé colonie
- Modèle prédictif : rendement de miel
- Dashboards consolidés multi-sites
- Rapports d'impact automatisés
- Au moins un workflow n8n d'orchestration (ex : déclenchement de rapport)

**Livrables spécifiques :** scripts SQL DW (DDL, ETL), notebooks d'analyse, dashboards, modèles ML entraînés avec métriques, workflows n8n exportés, documentation data.

### 9.3 Spécialité CYBER-RÉSEAUX
**Focus : infrastructure multi-sites, sécurité IoT, continuité, automatisation de la réponse**

- Virtualisation : Proxmox ou Docker
- Firewall : **Fortinet FortiGate** (recommandé, partenariat NSE4) ou pfSense/OPNsense en repli
- VPN interconnexion : WireGuard, IPsec, ou VPN FortiGate
- Monitoring : Prometheus + Grafana
- Logs / SIEM : FortiAnalyzer / FortiSIEM (recommandé, NSE5) ou Wazuh/ELK en repli
- Orchestration de la réponse à incident : n8n (playbooks déclenchés par webhook SIEM)
- DevSecOps : Snyk (scan des scripts Infrastructure as Code)
- IaC : Ansible

**Modules obligatoires :**
- Architecture réseau multi-zones par site (DMZ, LAN, IoT, Management)
- Interconnexion sécurisée des sites (VPN)
- Sécurisation des passerelles LoRaWAN
- Monitoring de disponibilité multi-sites
- Détection automatisée des incidents (UC-CY01 à UC-CY04) via FortiAnalyzer/FortiSIEM
- Au moins un playbook n8n de réponse automatisée à incident
- Procédures de continuité d'activité (coupures prolongées)
- Documentation sécurité (PSSI adaptée au contexte multi-pays)

**Livrables spécifiques :** schéma réseau multi-sites, configurations firewall/VPN (FortiGate), dashboards monitoring, playbooks n8n de réponse à incident, documentation PSSI, procédures d'incident et de reprise.

---

## X. INTERFACES ET INTÉGRATIONS

### 10.1 API principales (conception étudiants)
- **Authentification** — inscription, login, refresh token, profil
- **Ruches** — CRUD, historique des mesures, statut
- **Inspections** — création, consultation, synchronisation différée
- **Récoltes** — déclaration, validation, écart vs prédiction
- **Alertes** — génération, consultation, traitement
- **Analytics** — KPIs multi-sites, génération de rapports

### 10.2 Intégrations externes possibles

| Service | Usage | Spécialité |
|---------|-------|-----------|
| Cartographie | OpenStreetMap, Leaflet | Dev/Data |
| Météo | OpenWeatherMap API (corrélation avec la santé des colonies) | Data |
| Notifications | Firebase Cloud Messaging (différées) | Dev |
| Email | Nodemailer, SendGrid (rapports bailleurs) | Dev |

### 10.3 Protocoles IoT

| Protocole | Usage | Spécialité |
|-----------|-------|-----------|
| LoRaWAN | Transport capteurs → passerelle (longue portée, faible débit) | Cyber |
| MQTT | Passerelle → cloud central (synchronisation différée) | Cyber/Dev |
| TLS 1.3 / VPN | Chiffrement des communications inter-sites | Cyber |

---

## XI. ORGANISATION ET MÉTHODOLOGIE

### 11.1 Méthodologie projet
- Sprints de **2 semaines**
- Daily standups (15 min)
- Sprint planning et rétrospective
- Backlog priorisé
- Démonstrations régulières

### 11.2 Jalons projet

| Jalon | Semaine | Livrables |
|-------|---------|-----------|
| Kick-off | S1 | Équipes constituées, backlog initial |
| Sprint 0 | S2-3 | Architecture, environnement, cadrage |
| Sprint 1-2 | S4-7 | Fondations, modules core |
| Sprint 3-4 | S8-11 | Fonctionnalités avancées |
| Sprint 5 | S12-14 | Intégration, tests, polish |
| Soutenance | S15-16 | Présentation finale |

### 11.3 Points de synchronisation inter-spécialités

| Fréquence | Objectif |
|-----------|----------|
| Lundi | Planning hebdo, points bloquants |
| Mercredi | Revue technique, intégrations |
| Vendredi | Démo intégration, rétrospective |

### 11.4 Outils de collaboration recommandés
- Git/GitHub — versionning code
- Jira/Trello — gestion backlog
- Slack/Discord — communication équipe
- Miro/Draw.io — schémas
- Notion/Confluence — documentation

---

## XII. LIVRABLES PAR SPÉCIALITÉ

### 12.1 Livrables communs

| Livrable | Description | Format |
|----------|-------------|--------|
| DCT | Document de Cadrage Technique (30-35 pages) | DOCX/PDF |
| README | Guide d'installation et d'utilisation | Markdown |
| Présentation | Support soutenance (20-25 slides) | PPTX |
| Démo | Environnement fonctionnel déployé | URL / Vidéo |

### 12.2 Livrables — spécialité Développement (DevOps)
- Pipelines CI/CD fonctionnels (build, test, déploiement)
- Conteneurs versionnés (registry)
- Scripts Infrastructure as Code documentés
- Dashboards d'exploitation
- Documentation de déploiement multi-sites

### 12.3 Livrables — spécialité Data Science
- Scripts SQL (DDL, ETL)
- Notebooks d'analyse et d'entraînement ML
- Dashboards (Grafana/Metabase)
- Modèles ML avec métriques
- Documentation data (catalogue, lignage)

### 12.4 Livrables — spécialité Cyber-Réseaux
- Schéma réseau multi-sites détaillé
- Configurations firewall / VPN / IDS
- Dashboards monitoring
- Documentation sécurité (PSSI)
- Procédures d'incident et de continuité

---

## XIII. CRITÈRES D'ÉVALUATION

### 13.1 Grille d'évaluation commune

| Critère | Description |
|---------|-------------|
| Conception | Architecture, modélisation, choix techniques |
| Implémentation | Qualité, fonctionnalités, tests |
| Documentation | DCT, README, schémas |
| Exploitation | Fiabilité des pipelines/déploiements, monitoring |
| Présentation | Soutenance, démo, réponses au jury |

### 13.2 Critères spécifiques par spécialité

**Développement (DevOps) :**
- Pipeline CI/CD opérationnel de bout en bout
- Conteneurisation cohérente et documentée
- IaC reproductible
- Monitoring d'exploitation fonctionnel

**Data Science :**
- Modèles prédictifs avec métriques pertinentes (MAE, F1, etc.)
- PostGIS fonctionnel
- ETL documenté
- Dashboards clairs et actionnables

**Cyber-Réseaux :**
- Architecture multi-sites opérationnelle
- VPN et segmentation fonctionnels
- Documentation sécurité complète
- Procédures de continuité crédibles

---

## XIV. ANNEXES

### Annexe A : Glossaire technique

| Terme | Définition |
|-------|-----------|
| IoT | Internet of Things — objets connectés communicants |
| LoRaWAN | Protocole radio longue portée / faible consommation pour capteurs distants |
| MQTT | Protocole de messagerie léger pour l'IoT |
| PostGIS | Extension PostgreSQL pour les données géographiques |
| CI/CD | Intégration et déploiement continus |
| IaC | Infrastructure as Code |
| Edge computing | Traitement des données au plus proche de leur source |
| JWT | JSON Web Token — standard d'authentification |
| RBAC | Contrôle d'accès basé sur les rôles |
| Star Schema | Modèle de Data Warehouse (faits + dimensions) |
| ETL | Extract, Transform, Load |
| SIEM | Security Information and Event Management |
| PSSI | Politique de Sécurité du Système d'Information |
| RTO / RPO | Recovery Time / Point Objective — indicateurs de continuité d'activité |
| n8n | Plateforme d'automatisation de workflows (low-code) utilisée pour l'orchestration et les playbooks |
| Snyk | Outil DevSecOps de scan de vulnérabilités (dépendances, conteneurs, Infrastructure as Code) |
| FortiGate | Firewall nouvelle génération (NGFW) de Fortinet, gère filtrage et VPN |
| FortiAnalyzer / FortiSIEM | Solutions Fortinet de centralisation et corrélation des journaux de sécurité |
| SOAR | Security Orchestration, Automation and Response — automatisation de la réponse à incident |
| Playbook | Séquence d'actions automatisées déclenchée en réponse à un incident détecté |

### Annexe B : Références RNCP

RNCP **EADL / EASRSI** — blocs de compétences mobilisés :
- **Bloc 1** : Planifier et organiser
- **Bloc 2** : Concevoir et développer des solutions techniques
- **Bloc 3** : Piloter la mise en production et la sécurité
- **Bloc 4** : Piloter des projets numériques

### Annexe C : Ressources pédagogiques
- PostgreSQL / PostGIS : documentation officielle
- Docker / Kubernetes (K3s) : documentation officielle
- The Things Network (LoRaWAN) : documentation communautaire
- Grafana / Prometheus : documentation officielle
- Wazuh / Suricata : documentation officielle

### Annexe D : Environnement de projet fourni

> **Important** : ce chapitre décrit l'**infrastructure réelle mise à disposition** pour réaliser le projet — à ne pas confondre avec l'architecture de BeeAfrica que vous concevez (chapitres VI et VIII). Vous ne partez pas de zéro : une partie des services est déjà fournie et administrée, vous n'avez pas à réinstaller un pare-feu ou un SIEM depuis rien.

#### Ce qui est fourni (vous ne le construisez pas)

| Ressource | Où | Contenu |
|-----------|----|---------|
| VM partagée | On-prem (serveur école, 16 Go) | FortiGate (1 VDOM par groupe), SIEM central (Wazuh, comptes scopés), simulateur central de référence, broker MQTT central |
| VM de groupe | Cloud (Oracle Cloud en priorité, 14 Go) | Environnement libre du groupe : site pilote, n8n, sous-ensemble du simulateur, outils de travail |

#### Ce que chaque groupe reçoit concrètement
- Un **VDOM FortiGate** isolé, avec vos propres accès — vous configurez vos règles, votre VPN, vos politiques, sans risque d'impacter les autres groupes
- Un **compte SIEM scopé** — vous voyez et exploitez vos propres journaux, pas ceux des autres groupes
- Un **accès au simulateur central (lecture)** et un **sous-ensemble dédié sur votre propre VM** (pour vos scénarios sans gêner personne)
- Une **VM cloud entièrement à vous** pour tout le reste (site pilote, automatisations, tests)

#### Continuité de l'environnement fourni (ce n'est pas votre responsabilité)

La disponibilité de la VM partagée est assurée par l'équipe pédagogique, pas par les groupes.
- Réplication de stockage (ZFS) entre les deux serveurs de l'école, toutes les 15-30 minutes
- Sauvegarde complète quotidienne, restauration testée régulièrement
- Objectifs réalistes pour un contexte pédagogique : reprise en moins de 4 h en heures ouvrées, perte de données maximale de 30 minutes

Si la VM partagée est indisponible en séance, ce n'est pas un incident à gérer par votre groupe — signalez-le simplement à l'équipe pédagogique et poursuivez sur votre VM de groupe en attendant.

*Document réalisé dans le cadre du projet fil rouge INGETIS-ITIS — © 2027 — Usage pédagogique uniquement.*

---
---

# PARTIE B — DOSSIERS PROFESSIONNELS (GABARITS D'ÉVALUATION)

> 💡 *Explication générale.* Les deux fichiers `TEMPLATE_BLOC1_DEV_B.docx` et `TEMPLATE_BLOC2_DEV_B.docx` ne décrivent **pas l'application** : ce sont les **gabarits des dossiers professionnels** que l'étudiant en spécialité Développement devra rédiger et soutenir pour valider la certification **EADL (Expert en Architecture et Développement Logiciel) — RNCP38822 — niveau 7 (EU)**. QueenBee est le « terrain d'expérience » qui permet de fournir les preuves demandées. Les deux gabarits ont une structure et des consignes communes, détaillées en B.1, puis chacun a ses parties propres (B.2 et B.3).

## B.1 Informations communes aux deux gabarits

### B.1.1 Page de garde (identique dans les deux)

- **École** : INGETIS — École d'ingénierie informatique — 62 bis rue Gay-Lussac, 75005 Paris
- **Titre** : DOSSIER PROFESSIONNEL
- **Référentiel** : Expert en Architecture et Développement Logiciel (EADL)
- **Spécialité** : Développement logiciel
- **Certification visée** : EADL — RNCP38822 — niveau 7 (EU)
- **Champs à remplir** : Candidat(e) · Entreprise · Numéro apprenant · Maître d'apprentissage · Année : 2026-2027 · Tuteur pédagogique · Date de soutenance (__/__/____) · Note obtenue (__/20)
- **Soutenance** : **20 minutes de présentation**, puis **20 minutes d'entretien** avec le jury.
- *Document confidentiel — INGETIS 2026-2027 — usage académique strictement réservé.*

| Gabarit | Bloc | Activité du référentiel | Titre |
|---------|------|------------------------|-------|
| `TEMPLATE_BLOC1_DEV_B` | Bloc 1 | **A1** | Planifier et organiser un projet de développement logiciel |
| `TEMPLATE_BLOC2_DEV_B` | Bloc 2 | **A2** | Concevoir et développer des solutions logicielles |

### B.1.2 Pages pédagogiques (à supprimer à la remise)

Les gabarits contiennent des « pages pédagogiques » et des encadrés de consigne en tête de chaque partie. **Ils sont supprimés avant la remise.** Le dossier remis comporte : **page de garde, table des matières, parties rédigées, bibliographie, annexes.**

Plan des pages pédagogiques (identique dans les deux) : *Plan de ce document* · *Nature du dossier attendu* · *Avant de commencer* · *Correspondance entre le référentiel et le dossier* · *Modèle : comment nous attendons une partie rédigée* · *Modalités de remise et volume attendu*.

> Ce document est un **gabarit de rédaction**. Il n'est pas un dossier et ne constitue pas un support d'évaluation : **le jury évalue uniquement le dossier remis par l'étudiant.**

### B.1.3 Nature du dossier attendu

Ce dossier n'est **ni un guide technique, ni un journal de projet**. C'est un travail à la fois **professionnel, académique et technique** : l'étudiant y rend compte, devant un jury de professionnels, de la façon dont il a conduit une situation réelle, en justifiant ses décisions et en prenant du recul. La technique y figure comme **objet de choix et comme preuve**, jamais comme une fin en soi.

| Dimension | Ce que le jury y cherche | Où cela se trouve |
|-----------|--------------------------|-------------------|
| **Professionnelle** | Une situation réelle avec ses enjeux, ses contraintes et ses parties prenantes ; un rôle assumé ; des décisions prises et leurs conséquences pour l'organisation ; des résultats mesurés. | Corps du texte, à la première personne pour les décisions. |
| **Académique** | Une problématique posée clairement ; une démarche méthodique ; des choix comparés à des alternatives ; des sources et des référentiels cités ; un regard critique sur les limites ; une rédaction en prose structurée. | Introduction, argumentation de chaque partie, conclusion, bibliographie. |
| **Technique** | La maîtrise et l'exactitude des solutions mises en œuvre, démontrées par des preuves vérifiables. | Synthèse dans le corps du texte ; détails (code, configurations, journaux, captures) en annexes. |

**Ce que ce dossier n'est pas :**
- Un **tutoriel** ou une documentation d'installation : les commandes et les fichiers de configuration vont en annexe.
- Une **liste d'outils** : un outil n'est pas une compétence ; ce qui compte est la raison de son choix et ce qu'il a permis.
- Un **compte rendu chronologique** (« d'abord, puis, ensuite ») : le dossier est organisé **par problèmes à résoudre**.
- Un texte que vous **ne pourriez pas défendre à l'oral** : chaque affirmation doit pouvoir être justifiée devant le jury.

**Règle de répartition entre le texte et les annexes.** Le corps du texte contient ce qui permet de juger le raisonnement : *le problème, les options, le choix, la preuve résumée, le résultat, la limite*. Tout ce qui permet de **reproduire** (code, configurations, journaux complets, captures) figure **en annexe** et est cité par son numéro. Un lecteur professionnel, non spécialiste de l'outil, doit pouvoir suivre le fil du texte. **Test simple** : après chaque affirmation technique, on doit pouvoir écrire « *parce que* » ou « *ce qui a permis de* ».

### B.1.4 Support du dossier : deux options possibles

1. **Le projet fil rouge QueenBee**, conduit au Mastère 1 : la plateforme de suivi de ruches connectées de l'association BeeAfrica (trois pays, huit sites, environ 400 ruches), dont le cahier des charges commun fixe le besoin, le périmètre de la spécialité et les objectifs à atteindre.
2. **Un projet réel mené en entreprise**, à condition qu'il permette de démontrer l'ensemble des compétences du bloc et que l'entreprise ait donné son accord sur la confidentialité et l'anonymisation des éléments présentés.

La structure du dossier est **identique dans les deux cas**. Si un projet d'entreprise est retenu, la mention « *Support QueenBee et projet d'entreprise* » de chaque partie indique ce qui est attendu. Lorsque le projet retenu ne permet pas de démontrer une compétence, il faut le **signaler explicitement** et produire la preuve à partir d'un **cadre complémentaire validé avec le tuteur pédagogique**, exposé dans l'introduction. Il est conseillé de **faire valider le choix de support avant de commencer la rédaction**.

> ✅ *Pour ce document : le support retenu est QueenBee.*

### B.1.5 Principes de rédaction : exemple « insuffisant » vs « attendu »

Les deux gabarits illustrent la différence entre une rédaction descriptive et une rédaction professionnelle/académique (situation et chiffres **fictifs**, à ne pas recopier).

**Bloc 1 (exemple fictif).**
- ❌ *Insuffisant* : « Nous avons réalisé une étude de faisabilité avec une analyse SWOT et un calcul de retour sur investissement. Le projet est faisable et rentable. »
- ✅ *Attendu* : « L'analyse des contraintes montre que la capacité des passerelles et la disponibilité de l'équipe (une semaine sur quatre) limitent le projet avant le budget : un orchestrateur complet sur chaque site n'est pas réaliste (annexe A3). Je recommande donc un déploiement en deux temps, site pilote puis généralisation. Dans ce cadre, le gain est positif dès le troisième site dans l'hypothèse basse (annexe A4), mais il suppose que le mode de déploiement des passerelles soit validé avec l'équipe Cyber. Ma conclusion est donc conditionnelle, et je précise laquelle. »

**Bloc 2 (exemple fictif).**
- ❌ *Insuffisant* : « L'architecture utilise K3s sur les passerelles, un courtier MQTT, PostgreSQL et Grafana, le tout déployé avec Ansible. »
- ✅ *Attendu* : « Le cahier des charges impose de synchroniser environ 38 400 mesures en moins de deux minutes après une coupure, et de fonctionner hors ligne (annexe A1). J'ai écarté l'orchestrateur léger sur les passerelles les plus modestes, dont la consommation de mémoire est excessive, et une file supplémentaire, qui ajoute un composant à exploiter (annexe A2). J'ai retenu un courtier MQTT avec persistance, déjà nécessaire au trafic des capteurs. Les outils cités en découlent ; leur liste est en annexe A3. »

### B.1.6 Exemple de partie rédigée complète — Bloc 1, Partie 2 (extrait fictif)

| Texte rédigé par l'étudiant (fictif) | Ce que le jury y repère |
|--------------------------------------|-------------------------|
| L'association BeeAfrica exploite des ruches connectées sur huit sites répartis dans trois pays, avec une connectivité intermittente. Avant de m'engager sur une chaîne de déploiement, j'ai cherché à établir si l'industrialisation de la plateforme était réalisable par une équipe de quatre personnes sur la durée du projet, et ce qu'elle apporterait à l'association (annexe A1). | La question de faisabilité est posée avant toute solution, avec l'enjeu pour l'organisation. |
| J'ai recueilli le besoin auprès de trois profils : un coordinateur régional, l'administrateur de la plateforme et l'équipe Cyber. Le désaccord principal portait sur le mode de déploiement sur site : les sites les moins équipés ne supportent pas une orchestration lourde, alors que l'administrateur souhaite une procédure unique pour les huit sites. Ce désaccord conditionnait l'architecture de déploiement ; je l'ai traité comme un risque (annexe A2). | Méthode de recueil identifiable. Une tension réelle entre parties prenantes est transformée en risque. |
| Cinq contraintes pesaient sur le plan : des passerelles à faible capacité, une liaison intermittente, une équipe disponible une semaine sur quatre, un calendrier fixé par la soutenance et l'obligation de protéger les données personnelles des bénéficiaires. La disponibilité de l'équipe et la capacité des passerelles étaient les plus contraignantes : elles rendaient irréaliste un orchestrateur complet sur chaque site et m'ont conduit à prévoir deux modes de déploiement. | Les contraintes de plusieurs natures sont hiérarchisées, et reliées à une conséquence sur le plan. |
| Le risque principal, noté 12 sur 16 dans la matrice (annexe A3), était l'échec d'un déploiement sur un site isolé, sans possibilité d'intervention rapide. J'ai retenu deux mesures : un déploiement en deux temps (site pilote, puis généralisation) et une procédure de retour arrière testée avant tout déploiement. | Niveau de risque estimé, puis mesures proportionnées. |
| Sur le plan économique, j'ai comparé le coût d'une chaîne automatisée, environ 60 heures de travail d'équipe avec des outils gratuits, à la réduction attendue des interventions manuelles sur site, estimée entre 30 et 50 % selon les hypothèses de l'annexe A4. Le gain devient positif dès le troisième site dans l'hypothèse basse, mais il devient fragile si chaque passerelle impose une configuration propre. | Faisabilité économique chiffrée, hypothèses explicitées, point de fragilité identifié. |
| Je conclus à une faisabilité conditionnée : poursuivre avec un déploiement en deux temps et faire valider le mode de déploiement des passerelles avec l'équipe Cyber avant le chiffrage définitif. Les gains attendus proviennent d'une étude sectorielle [3] et n'ont pas été vérifiés sur le terrain ; c'est la principale limite de cette étude. | Décision argumentée avec conditions, et limite assumée. |

### B.1.7 Exemple de partie rédigée complète — Bloc 2, Partie 2 (extrait fictif)

| Texte rédigé par l'étudiant (fictif) | Ce que le jury y repère |
|--------------------------------------|-------------------------|
| Le cahier des charges impose de synchroniser une journée de données, soit environ 38 400 mesures, en moins de deux minutes après une reconnexion, de fonctionner hors ligne et de chiffrer les données des bénéficiaires. J'en ai déduit trois exigences structurantes : un stockage local sur chaque site, une file de synchronisation tolérante aux coupures et un chiffrement avant transmission (annexe A1). | L'architecture est déduite des exigences et non posée a priori. Chiffres tirés du cahier des charges. |
| J'ai comparé deux modes d'exécution sur les passerelles (un orchestrateur léger et des conteneurs simples décrits par un fichier de composition) et deux mécanismes de synchronisation (un courtier MQTT et une file RabbitMQ). L'orchestrateur permet des mises à jour progressives mais consomme environ 500 Mo de mémoire au repos, excessif pour les passerelles les plus modestes ; RabbitMQ garantit la livraison mais ajoute un composant à exploiter (annexe A2). | Options réellement comparées, avec le motif d'écart de chacune et une estimation chiffrée. |
| J'ai retenu des conteneurs simples sur les passerelles les moins équipées, l'orchestrateur léger sur celles qui le permettent, et un courtier MQTT avec persistance, déjà nécessaire au trafic des capteurs. Ce choix évite un composant supplémentaire et garde une procédure de déploiement commune aux deux modes (figures 1 et 2, annexe A3). | Choix argumenté, renvoyé à des schémas. Le détail est en annexe. |
| L'architecture est représentée en UML (diagrammes de composants et de déploiement), langage connu de tous les relecteurs prévus. Les décisions sont consignées dans un journal daté, afin qu'un nouvel arrivant comprenne pourquoi une option a été écartée (annexe A4). | Modélisation normalisée et lisible sans l'auteur. |
| Les échanges entre sites et serveur central sont chiffrés et authentifiés par certificat, conformément aux recommandations de l'ANSSI [4]. L'application terrain, destinée à des utilisateurs peu familiers du numérique, suit les critères du RGAA [5] ; un audit les vérifie (annexe A5). | Sécurité et accessibilité intégrées à l'architecture, appuyées sur des sources citées. |
| Pour limiter l'impact environnemental, l'extraction des caractéristiques acoustiques est réalisée sur la passerelle : seul un vecteur d'environ 8 octets par échantillon est transmis, au lieu du signal brut, ce qui réduit le trafic radio et l'énergie consommée sur des sites alimentés par panneaux solaires. Je n'ai pas mesuré le surcroît de calcul sur la passerelle ; c'est la limite de ce choix, un essai est prévu (annexe A6). | Éco-conception argumentée, avec une limite et une perspective. |

### B.1.8 Modèles de renvois, de légendes et de références (communs)

| Élément | Forme attendue |
|---------|----------------|
| Renvoi à une annexe | …le pipeline bloque la fusion en cas d'échec (annexe A3, p. 2). |
| Légende de figure | Figure 2 — Chronologie de traitement d'un incident (source : auteur, 2027). |
| Citation dans le texte | …conformément aux recommandations de l'organisme de référence [2]. |
| Entrée de bibliographie | [2] ORGANISME ou AUTEUR, Titre du document, année, adresse web, consultée le jj/mm/aaaa. |
| Ligne d'index des annexes | A3 — Configuration du pipeline (extrait commenté) — renvoi : partie 3 — page 41. |

### B.1.9 Ce que ces modèles montrent (communs)
- Le texte raconte **un raisonnement** (*situation, problème, options, choix, preuve, résultat, limite*) et non une configuration.
- Chaque affirmation technique est suivie de **sa raison ou de sa preuve**, renvoyée à une **annexe numérotée**.
- Les décisions sont écrites **à la première personne** et justifiées par rapport à des **alternatives écartées**.
- Le texte se termine par **une limite assumée et une perspective**, ce qui démontre le regard critique.

### B.1.10 Modalités de remise (communes)

- Remise à l'équipe pédagogique **entre deux et quatre semaines avant la date de soutenance**, selon le calendrier communiqué par le responsable de formation. Un dossier remis hors délai peut entraîner **le report de la soutenance**.
- Format : **PDF natif**, nommé `NOM_Prenom_BLOC[N]_[SPECIALITE]_[ANNEE].pdf`.
- Les **annexes** (code, captures, rapports d'outils, comptes rendus) sont numérotées (A1, A2…), référencées dans le corps du texte, et **ne comptent pas dans le volume**, pas plus que la **bibliographie**.
- *« La qualité de l'argumentation et la rigueur de l'analyse priment sur le volume. »*
- **Bibliographie** : sources citées dans le texte (normes et référentiels, textes réglementaires, documentation officielle des outils, publications professionnelles ou académiques, sources anglophones de la veille). **Une seule norme de citation** pour tout le dossier.
- **Annexes** : chacune est numérotée, titrée, **citée au moins une fois** dans le texte, contient une preuve (code, configuration, journal, capture, rapport, compte rendu) **accompagnée d'une ligne indiquant ce qu'elle démontre**. Index : `N° | Intitulé | Ce qu'elle démontre | Partie de renvoi`.
- Après suppression des pages pédagogiques, **mettre à jour la table des matières** : clic droit → *Mettre à jour les champs* → *Mettre à jour toute la table*.

### B.1.11 Compétences transversales (communes, évaluées dans chaque bloc et à chaque soutenance)

Le référentiel impose la validation de **deux compétences transversales**. Elles ne sont pas traitées à part : il faut **repérer dans le dossier où elles sont démontrées** et produire les éléments manquants.

| Compétence | Preuve à fournir dans ce dossier |
|-----------|----------------------------------|
| **Maîtrise de l'anglais technique** | Compte rendu de veille technologique ou réglementaire **rédigé en français à partir de sources anglophones** citées avec leurs références ; références anglophones intégrées au dossier ; capacité à **échanger en anglais lors de l'entretien** si le jury le sollicite. |
| **Numérique responsable** | Principes d'**éco-conception** appliqués à la solution (par exemple limitation des données collectées et transmises, optimisation des requêtes et des ressources affichées, dimensionnement et arrêt des environnements inutilisés), **estimation ou mesure de l'impact**, **arbitrage argumenté entre performance et sobriété**, et prise en compte des règles et référentiels en vigueur. |

À remplir dans le dossier : *« Indiquez où, dans le dossier, chaque preuve se trouve (partie, annexe, page). »*

---

## B.2 BLOC 1 — Planifier et organiser un projet de développement logiciel

**Référentiel EADL — activité A1 — Spécialité Développement logiciel — RNCP38822, niveau 7 (EU).**

### B.2.1 Correspondance référentiel ↔ dossier

| Code | Compétence visée | Partie du dossier | Pièce attendue |
|------|------------------|-------------------|----------------|
| **C1.1** | Réaliser une étude de faisabilité du projet de développement logiciel | Partie 2 | Étude de faisabilité avec matrice des risques et retour sur investissement |
| **C1.2** | Concevoir un système de veille technologique | Partie 3 | Plan de veille et comptes rendus de veille |
| **C1.3** | Concevoir la solution informatique associée au projet | Partie 4 | Cahier des charges fonctionnel |
| **C1.4** | Établir la feuille de route du projet de développement logiciel | Partie 5 | Feuille de route, backlog, budget, indicateurs |
| **C1.5** | Mettre en place le projet de développement logiciel | Partie 6 | Comptes rendus d'exécution, registre des risques, budget réalisé |
| **C1.6** | Mesurer la performance du projet de développement logiciel | Partie 7 | Tableau de bord à deux dates, grille de conformité |
| **C1.7** | Superviser le déroulement du projet de développement logiciel | Partie 8 | Journal des écarts, plan mis à jour |
| Transv. | Anglais technique ; numérique responsable | Partie 9 | Compte rendu de veille ; mesures d'éco-conception |

### B.2.2 Volume attendu (hors annexes et bibliographie)

| Partie | Pages min. | Pages max. |
|--------|-----------|-----------|
| 1. Introduction | 1 | 2 |
| 2. Étude de faisabilité | 3 | 5 |
| 3. Plan de veille | 2 | 4 |
| 4. Cahier des charges fonctionnel | 3 | 5 |
| 5. Feuille de route | 2 | 4 |
| 6. Mise en place du projet | 2 | 4 |
| 7. Mesure de la performance | 2 | 3 |
| 8. Supervision et contrôle | 2 | 3 |
| 9. Compétences transversales | 1 | 2 |
| 10. Conclusion et bilan | 1 | 2 |
| **Total hors annexes** | **19** | **34** |

### B.2.3 Plan du dossier Bloc 1
1. Introduction · 2. Étude de faisabilité · 3. Plan de veille technologique · 4. Cahier des charges fonctionnel · 5. Feuille de route du projet · 6. Mise en place du projet · 7. Mesure de la performance du projet · 8. Supervision et contrôle du projet · 9. Compétences transversales · 10. Conclusion et bilan · Bibliographie et sources · Annexes.

### B.2.4 Partie 1 — Introduction

- **Objectif** : situer le dossier — l'organisation et son orientation stratégique, le besoin auquel le projet répond, le support retenu et la démarche de planification conduite. Rédaction en prose, **300 à 500 mots**.
- **À traiter** :
  1. L'organisation (l'association BeeAfrica et son réseau de coopératives apicoles), son orientation stratégique et la place que le projet logiciel y occupe.
  2. Le support retenu (QueenBee ou projet d'entreprise), la raison de ce choix, le rôle du candidat et celui de l'équipe.
  3. La problématique : pourquoi planifier et organiser ce projet est difficile (enjeux, incertitudes, contraintes), et ce que la démarche doit permettre de décider.
  4. L'annonce du plan, en reliant chaque partie à une compétence du bloc.

### B.2.5 Partie 2 — Étude de faisabilité (C1.1)

- **Objectif** : établir, avant d'engager des moyens, si le projet est réalisable et à quelles conditions, en analysant ses dimensions **organisationnelle, technique et financière**.
- **Question centrale** : *Ce projet est-il réalisable et rentable pour l'organisation, dans quelles conditions et avec quels risques ?*
- **Critères d'évaluation du référentiel** :

| Réf. | Énoncé |
|------|--------|
| Ce1.1.1 | L'analyse des besoins, de l'environnement et des risques du projet de développement logiciel permet une vision synthétique des objectifs et des contraintes du projet. |
| Ce1.1.2 | L'analyse des objectifs et des contraintes (budgétaires, RH, techniques, temporelles, organisationnelles, légales, environnementales, etc.) du projet de développement logiciel permet de vérifier si la mise en place du plan sera possible et d'estimer le niveau de risque. |
| Ce1.1.3 | La faisabilité (économique, technique et opérationnelle) du projet de développement logiciel est analysée par rapport au retour sur investissement du projet. |

- **Ce que le jury attend** : une étude qui **aide à décider**, et non une description du projet. Les besoins, les contraintes et les risques sont analysés avec une **méthode identifiable** ; la faisabilité est comparée au **retour sur investissement** attendu ; la conclusion (**poursuivre, adapter, renoncer**) est argumentée et assumée.
- **Éléments à développer, en prose argumentée** :
  1. Le contexte, les parties prenantes et les besoins exprimés, avec la méthode d'analyse retenue (entretiens, analyse de l'environnement, étude des risques).
  2. Les objectifs et les contraintes budgétaires, humaines, techniques, de calendrier, organisationnelles, légales et environnementales, et ce qu'elles impliquent pour le plan de mise en œuvre.
  3. Le niveau de risque estimé et les mesures envisagées pour les réduire (matrice des risques).
  4. La faisabilité économique, technique et opérationnelle, rapportée au retour sur investissement, avec les hypothèses de calcul explicitées.
  5. La décision proposée et ses conditions de réussite.
- **Preuves techniques à renvoyer en annexe** : matrice des risques ; hypothèses et calcul du retour sur investissement ; compte rendu d'entretiens ou de recueil de besoins.
- **Support QueenBee** : faisabilité de l'industrialisation DevOps de la plateforme de BeeAfrica (3 pays, 8 sites, connectivité intermittente), à partir du besoin décrit aux **chapitres I et II** du cahier des charges. *Projet d'entreprise : étude préalable réellement conduite, ou reconstituée à partir des documents disponibles.*
- **Forme de rédaction** : prose — la situation, les options envisagées, le choix et sa justification, la preuve (renvoi à l'annexe), le résultat, les limites.

### B.2.6 Partie 3 — Plan de veille technologique (C1.2)

- **Objectif** : concevoir un dispositif de veille adapté au projet et en tirer des apports concrets pour la solution proposée.
- **Question centrale** : *Comment éviter que le projet se construise sur des choix déjà dépassés ou ignorants des alternatives qui existent ?*
- **Critères d'évaluation** :

| Réf. | Énoncé |
|------|--------|
| Ce1.2.1 | Le plan de veille technologique est conçu pour répondre aux objectifs et contraintes du projet de développement logiciel. |
| Ce1.2.2 | Le plan de veille technologique s'appuie sur un ensemble d'outils et méthodes qui permettent d'identifier les informations pertinentes au projet de développement logiciel. |
| Ce1.2.3 | L'analyse des informations issues de la veille technologique permettent d'inclure des apports opérationnels et innovants à la solution de développement logiciel. |

- **Ce que le jury attend** : une veille **pensée pour le projet** — des questions de veille précises, des sources et des outils justifiés, une fréquence et un tri. Il vérifie surtout que **l'analyse a modifié ou confirmé des choix** de la solution. *Une liste de sites suivis ne démontre pas le critère.*
- **Éléments à développer** :
  1. Les objectifs de la veille, déduits des objectifs et des contraintes du projet : ce que l'on cherche à savoir et pourquoi.
  2. Les sources, outils et méthodes (agrégateur, alertes, newsletters, publications, bases de référence) et l'organisation de la veille (fréquence, tri, diffusion à l'équipe).
  3. L'analyse comparative des outils, modèles d'architecture, solutions et services existants, **y compris concurrents**.
  4. Les apports opérationnels et innovants retenus pour la solution, et ceux écartés avec la raison.
  5. Un **exemple complet de bout en bout** : de l'information repérée à la décision qu'elle a influencée.
- **Preuves en annexe** : plan de veille (tableau : sujet, sources, outil, fréquence, responsable) ; **au moins deux comptes rendus de veille, dont un rédigé en français à partir de sources anglophones** ; tableau comparatif de solutions.
- **Support QueenBee** : déploiement en périphérie et en connectivité limitée, files de messages, sécurité de la chaîne de livraison (DevSecOps), outils d'automatisation, solutions comparables sur le marché. *Projet d'entreprise : veille réellement menée sur la technologie du projet.*

### B.2.7 Partie 4 — Cahier des charges fonctionnel (C1.3)

- **Objectif** : décrire la solution attendue sous forme de spécifications fonctionnelles et techniques **vérifiables**, en identifiant les risques et en intégrant l'**accessibilité** et la **sobriété numérique** dès la conception.
- **Question centrale** : *Qu'attend exactement l'utilisateur de la solution, et comment le formuler pour que l'équipe puisse la construire sans ambiguïté et pour tous les publics ?*
- **Critères d'évaluation** :

| Réf. | Énoncé |
|------|--------|
| Ce1.3.1 | L'analyse fonctionnelle permet de décrire et lister les fonctionnalités attendues de la solution informatique dans le cahier des charges fonctionnel, en adéquation avec les objectifs du projet. |
| Ce1.3.2 | Les fonctionnalités, niveaux de performance cible et les contraintes (techniques, réglementaires, budgétaires, etc.) identifiées pour la solution informatique sont adéquates par rapport aux besoins identifiés des utilisateurs. |
| Ce1.3.3 | Les principes d'accessibilité sont respectés, et la solution proposée est adaptée aux exigences et besoins des personnes en situation de handicap. |
| Ce1.3.4 | Les principes du numérique responsable sont respectés, en particulier en terme d'impact environnemental de la solution informatique proposée. |

- **Ce que le jury attend** : un cahier des charges **exploitable** — des fonctionnalités reliées aux besoins des utilisateurs, des **niveaux de performance cibles chiffrés**, des contraintes explicites. L'**accessibilité** et le **numérique responsable** sont des **exigences de la solution, rédigées comme telles**, et non des remarques en fin de document.
- **Éléments à développer** :
  1. L'analyse fonctionnelle : utilisateurs, cas d'utilisation ou user stories, fonctionnalités et priorités (**méthode de priorisation retenue**).
  2. Les niveaux de performance cibles et les contraintes techniques, réglementaires (dont données personnelles) et budgétaires.
  3. Les risques techniques et fonctionnels, et leur prise en compte dans les spécifications.
  4. L'accessibilité : exigences retenues pour les personnes en situation de handicap, avec le **référentiel utilisé**.
  5. Le numérique responsable : exigences d'éco-conception et **estimation de l'impact environnemental** de la solution proposée.
- **Preuves en annexe** : cahier des charges fonctionnel complet ; **matrice besoins / fonctionnalités** ; **grille d'exigences d'accessibilité et d'éco-conception**.
- **Support QueenBee** : le **Document de Cadrage Technique (DCT, 30 à 35 pages)** précise les exigences de la solution d'industrialisation (niveaux de service, déploiement, accessibilité, sobriété), **chapitres V et VIII**. *Projet d'entreprise : cahier des charges, spécification ou backlog structuré du projet.*

> 💡 *Lien avec ce document.* C'est précisément à cette partie que **ce fichier « cahier de charge.md »** sert : il constitue la matière première du cahier des charges fonctionnel de l'application. Les sections « accessibilité » et « numérique responsable » du présent document (voir Partie C) comblent les deux critères Ce1.3.3 et Ce1.3.4 que le cahier des charges commun n'explicite que partiellement.

### B.2.8 Partie 5 — Feuille de route du projet (C1.4)

- **Objectif** : établir la feuille de route — méthode, organisation des tâches, livrables, échéances, budget, ressources et indicateurs de pilotage.
- **Question centrale** : *Comment organiser le travail pour livrer ce qui est attendu, à la bonne date, au bon coût, avec cette équipe ?*
- **Critères d'évaluation** :

| Réf. | Énoncé |
|------|--------|
| Ce1.4.1 | Les éléments du plan du projet de développement logiciel s'appuient sur une méthodologie spécifique (ex. Agile, DevOps). |
| Ce1.4.2 | L'organisation et la gestion des tâches du projet s'appuie sur un outil pertinent (ex. tableaux Kanban) et permet une utilisation efficace des ressources de l'équipe. |
| Ce1.4.3 | La planification précise des livrables et des budgets est en accord avec les objectifs, ressources et contraintes du projet. |
| Ce1.4.4 | Les outils de pilotage et les indicateurs de performance définis permettent d'évaluer l'avancement du projet. |

- **Ce que le jury attend** : une feuille de route **cohérente avec le cahier des charges et les ressources réelles** de l'équipe, et un **choix de méthode argumenté par rapport à d'autres**. Les indicateurs doivent **permettre de décider**, pas seulement de rendre compte.
- **Éléments à développer** :
  1. La méthodologie retenue (Agile, DevOps, autre) : pourquoi elle convient à ce projet et à cette équipe, et ce qui a été écarté.
  2. L'organisation des tâches (backlog, tableau Kanban ou équivalent) et l'affectation des ressources de l'équipe.
  3. La planification des livrables, des échéances et du budget, et sa cohérence avec les objectifs et les contraintes.
  4. Les outils de pilotage et les indicateurs de performance choisis : **pour chacun, ce qu'il mesure et le seuil qui déclenche une réaction**.
- **Preuves en annexe** : feuille de route ou diagramme de planification ; extrait du backlog / tableau de tâches ; budget prévisionnel ; tableau des indicateurs.
- **Support QueenBee** : **sprints de deux semaines**, jalons du **chapitre XI** (lancement, Sprint 0, Sprints 1 à 5, soutenance), backlog priorisé de la spécialité Développement. *Projet d'entreprise : plan de la mission ou de l'évolution dont on a la charge.*

### B.2.9 Partie 6 — Mise en place du projet (C1.5)

- **Objectif** : rendre compte de l'**exécution** du plan — application de la méthode, gestion des ressources, du budget, des risques et du changement, dans le respect du calendrier et de l'environnement.
- **Question centrale** : *Que s'est-il réellement passé quand le plan a rencontré la réalité : ce qui a été tenu, ce qui a dérivé, et à quel coût ?*
- **Critères d'évaluation** :

| Réf. | Énoncé |
|------|--------|
| Ce1.5.1 | Le plan du projet de développement logiciel est déployé selon la méthodologie choisie (ex. Agile, DevOps). |
| Ce1.5.2 | L'implémentation du plan du projet de développement logiciel respecte le budget, la gestion établie des ressources humaines et matérielles, les risques identifiés, et minimise l'impact sur l'environnement. |
| Ce1.5.3 | La mise en place du plan du projet de développement logiciel respecte les échéances, les normes associées aux objectifs définis et les exigences identifiées pour les personnes présentant un handicap. |

- **Ce que le jury attend** : un **récit d'exécution appuyé sur des traces** (comptes rendus, registres, budget réalisé), qui montre des **écarts réels** et la manière dont ils ont été traités. *Un plan parfaitement suivi, sans aucun écart, est peu crédible et ne permet pas de démontrer la compétence.*
- **Éléments à développer** :
  1. Le déploiement du plan selon la méthode choisie : rituels, livrables produits, adaptations nécessaires.
  2. La gestion des ressources humaines et matérielles, du budget et des risques identifiés : ce qui s'est confirmé, ce qui est apparu.
  3. Le **plan de gestion du changement** : comment les utilisateurs et l'équipe ont été préparés aux évolutions.
  4. Le respect des échéances et des normes associées, et la prise en compte des exigences liées au handicap.
  5. L'**impact environnemental du projet lui-même** (environnements, hébergement, déplacements) et les mesures de sobriété retenues.
- **Preuves en annexe** : comptes rendus de sprints ou de revues ; registre des risques à jour ; budget prévu et réalisé ; plan de gestion du changement.
- **Support QueenBee** : exécution des sprints avec les équipes Data et Cyber, **points de synchronisation hebdomadaires** du chapitre XI, démonstrations régulières. *Projet d'entreprise : suivi de la mission ou du projet réel.*

### B.2.10 Partie 7 — Mesure de la performance du projet (C1.6)

- **Objectif** : mesurer l'avancement, le respect du budget et des délais, la qualité des livrables et la conformité du projet, pour en tirer des améliorations.
- **Question centrale** : *Comment sait-on, chiffres à l'appui, que le projet avance bien et respecte les règles qui s'imposent à lui ?*
- **Critères d'évaluation** :

| Réf. | Énoncé |
|------|--------|
| Ce1.6.1 | Le suivi de l'évolution du projet de développement logiciel est réalisé par le biais des indicateurs clefs de performance (KPI) définis. |
| Ce1.6.2 | Les outils utilisés permettent de mesurer l'efficacité et l'avancement du projet de développement logiciel (calendrier, budget, qualité des livrables) par rapport au plan initial. |
| Ce1.6.3 | La mesure de la performance permet de mesurer la conformité du projet aux normes réglementaires, telles que le RGPD, et aux standards de qualité, comme ITIL ou les préconisations de l'ANSSI. |
| Ce1.6.4 | L'analyse des informations issues de l'évaluation du projet de développement logiciel permet d'identifier les axes et propositions concrètes d'amélioration du projet. |

- **Ce que le jury attend** : des indicateurs **définis à l'avance, mesurés dans le temps, comparés au plan initial, puis interprétés**. La conformité (RGPD, standards de qualité) est **vérifiée** sur le projet et non seulement citée. Les propositions d'amélioration sont **concrètes et datées**.
- **Éléments à développer** :
  1. Les indicateurs clés suivis (calendrier, budget, qualité des livrables) et leur définition.
  2. Les outils de mesure utilisés et la comparaison des résultats avec le plan initial, **à au moins deux dates**.
  3. La vérification de la conformité réglementaire (RGPD) et des standards de qualité retenus (ITIL, préconisations de l'ANSSI).
  4. L'analyse des écarts et les propositions d'amélioration, avec leur effet attendu.
- **Preuves en annexe** : tableau de bord du projet à deux dates ; grille de conformité RGPD et qualité ; compte rendu de rétrospective.
- **Support QueenBee** : objectifs chiffrés du cahier des charges (**déploiements réussis sans incident > 95 %**, **synchronisation en moins de 2 minutes pour une journée de données**) et indicateurs de sprint. *Projet d'entreprise : indicateurs réels du projet, anonymisés si nécessaire.*

### B.2.11 Partie 8 — Supervision et contrôle du projet (C1.7)

- **Objectif** : superviser le déroulement du projet — détecter les écarts, résoudre les problèmes, réajuster calendrier et ressources, et informer les parties prenantes.
- **Question centrale** : *Quand le projet s'écarte du plan, qui le voit, qui décide quoi, et comment le client est-il informé ?*
- **Critères d'évaluation** :

| Réf. | Énoncé |
|------|--------|
| Ce1.7.1 | L'identification des actions nécessitant des corrections permet d'actualiser le projet de développement logiciel. |
| Ce1.7.2 | La résolution de problèmes permet de contrôler le projet de développement logiciel par la définition des nouvelles tâches à réaliser. |
| Ce1.7.3 | Le projet de développement logiciel est mis à jour par des ajustements effectuées au niveau du calendrier et des ressources. |
| Ce1.7.4 | Les parties prenantes et notamment le client final sont informés du déroulement du projet par le biais d'une communication efficace. |

- **Ce que le jury attend** : des **décisions de pilotage réelles** — un écart repéré grâce aux indicateurs, une résolution, un plan mis à jour, une communication adaptée au client. *Les situations difficiles sont les plus démonstratives.*
- **Éléments à développer** :
  1. Deux ou trois **écarts significatifs** : comment ils ont été détectés et les actions correctives décidées.
  2. La résolution des problèmes et les nouvelles tâches qui en ont découlé dans le plan.
  3. Les ajustements de calendrier et de ressources, avec la **version du plan avant et après**.
  4. La communication avec les parties prenantes et le client final : contenu, fréquence, canal, et ce qu'elle a produit.
- **Preuves en annexe** : journal des écarts et décisions ; plan mis à jour (versions avant et après) ; comptes rendus de points avec le client.
- **Support QueenBee** : revues de sprint et démonstrations devant le commanditaire, **représenté par l'équipe pédagogique dans le rôle de l'association BeeAfrica**. *Projet d'entreprise : points avec le commanditaire.*

### B.2.12 Partie 9 — Compétences transversales
Voir **B.1.11**. À compléter par l'indication de l'endroit (partie, annexe, page) où se trouve chaque preuve.

### B.2.13 Partie 10 — Conclusion et bilan
- **Objectif** : bilan de la planification et du pilotage — ce qui est atteint, ce qui ne l'est pas, ce que l'on ferait autrement.
- **À traiter** :
  1. Les décisions de planification qui se sont révélées justes, et celles que la réalité a corrigées.
  2. L'écart entre le plan initial et l'exécution, et ce que cet écart enseigne sur l'estimation et sur la gestion des risques.
  3. Les limites de la démarche et les améliorations prévues pour un prochain projet.
  4. Ce que cette expérience a appris sur le rôle de **responsable de projet**.

### B.2.14 Bibliographie et annexes
Voir **B.1.10**.

---

## B.3 BLOC 2 — Concevoir et développer des solutions logicielles

**Référentiel EADL — activité A2 — Spécialité Développement logiciel — RNCP38822, niveau 7 (EU).**

### B.3.1 Correspondance référentiel ↔ dossier

| Code | Compétence visée | Partie du dossier | Pièce attendue |
|------|------------------|-------------------|----------------|
| **C2.1** | Élaborer l'architecture de l'application logicielle | Partie 2 | Diagrammes d'architecture, journal des décisions, prototype |
| **C2.2** | Préparer l'intégrité du code | Partie 3 | Règles de contribution, listes de contrôle, rapport d'analyse statique |
| **C2.3** | Piloter le développement front-end | Partie 4 | Maquettes, interface réalisée, audit d'accessibilité |
| **C2.4** | Piloter le développement back-end | Partie 5 | Contrat d'interface, schéma de données, tests de sécurité |
| **C2.5** | Coordonner le développement de solutions de traitement de données à grande échelle | Partie 6 | Schéma de flux, chaîne de traitement, résultats d'analyse |
| Transv. | Anglais technique ; numérique responsable | Partie 7 | Compte rendu de veille ; mesures d'éco-conception |

### B.3.2 Volume attendu (hors annexes et bibliographie)

| Partie | Pages min. | Pages max. |
|--------|-----------|-----------|
| 1. Introduction | 1 | 2 |
| 2. Architecture de la solution | 4 | 6 |
| 3. Intégrité et qualité du code | 3 | 5 |
| 4. Développement front-end | 3 | 5 |
| 5. Développement back-end | 3 | 5 |
| 6. Traitement des données à grande échelle | 3 | 5 |
| 7. Compétences transversales | 1 | 2 |
| 8. Conclusion et bilan | 1 | 2 |
| **Total hors annexes** | **19** | **32** |

### B.3.3 Plan du dossier Bloc 2
1. Introduction · 2. Architecture de la solution logicielle · 3. Intégrité et qualité du code · 4. Développement front-end · 5. Développement back-end · 6. Traitement des données à grande échelle · 7. Compétences transversales · 8. Conclusion et bilan · Bibliographie et sources · Annexes.

### B.3.4 Partie 1 — Introduction
- **Objectif** : situer le dossier — le projet de solution logicielle innovante, son contexte, le support retenu, les choix d'ensemble et **ce qui a réellement été développé**. Prose, **300 à 500 mots**.
- **À traiter** :
  1. Le contexte de la solution (la plateforme QueenBee de l'association BeeAfrica), les utilisateurs visés et le rôle tenu dans la conception et le développement.
  2. Le support retenu, la raison de ce choix, et l'**état d'avancement** de la solution à la date du dossier.
  3. La problématique technique : quelles difficultés de conception et de développement le projet pose, et en quoi la solution est **innovante**.
  4. L'annonce du plan, en reliant chaque partie à une compétence du bloc.

### B.3.5 Partie 2 — Architecture de la solution logicielle (C2.1)

- **Objectif** : concevoir et justifier l'architecture, la représenter avec un **langage de modélisation normalisé** et en démontrer la conformité aux exigences de **sécurité, d'accessibilité et de sobriété**.
- **Question centrale** : *Quelle architecture répond aux besoins, aux contraintes et à la sécurité, avec le moindre impact, et comment la rendre lisible à quelqu'un qui ne l'a pas construite ?*
- **Critères d'évaluation** :

| Réf. | Énoncé |
|------|--------|
| Ce2.1.1 | La schématisation de l'architecture de la solution logicielle répond aux spécifications techniques et fonctionnelles, ainsi qu'aux contraintes identifiées. |
| Ce2.1.2 | L'architecture de l'application logicielle répond aux cas d'utilisation identifiés et aux contraintes réglementaires et de sécurité. |
| Ce2.1.3 | Les langages de modélisations (ex. BPMN, UML) et les outils utilisés (ex. Draw.io) permettent de conceptualiser et visualiser clairement l'architecture de l'application. |
| Ce2.1.4 | L'architecture proposée est conformes aux exigences de sécurité et aux normes réglementaires. |
| Ce2.1.5 | La solution d'architecture logicielle proposée répond aux divers scénarios d'utilisation, et elle est adaptée aux personnes en situation de handicap (ex. compatibilité avec les lecteurs d'écran et les sous-titres) assurant ainsi une réponse adaptée et inclusive aux besoins de tous les utilisateurs. |
| Ce2.1.6 | L'architecture proposée permet de réduire l'impact environnemental de la solution (ex. pas de redondance inutile, utilisation de microservices, de la virtualisation et de la conteneurisation pour réduire l'utilisation des ressources, gestion dynamique des ressources, caching etc.). |

- **Ce que le jury attend** : une architecture qui **découle des exigences** (cahier des charges, cas d'utilisation, contraintes), choisie **parmi des options comparées**, et représentée de façon claire et normalisée. La sécurité, l'inclusion et l'impact environnemental sont des **critères de choix** de l'architecture, et non des commentaires ajoutés après coup.
- **Éléments à développer** :
  1. Les exigences et contraintes qui structurent l'architecture, issues du cahier des charges (partie reliée au Bloc 1).
  2. Les options d'architecture envisagées (monolithe modulaire, microservices, architecture pilotée par les événements), leur comparaison et le choix argumenté.
  3. La représentation avec un langage de modélisation (UML, BPMN, autre) et un outil, et la façon dont ces schémas permettent de la lire sans explication orale.
  4. La conformité aux exigences de sécurité et aux normes réglementaires, avec les mesures intégrées à l'architecture.
  5. La réponse aux scénarios d'utilisation, y compris l'adaptation aux personnes en situation de handicap.
  6. La réduction de l'impact environnemental (virtualisation, conteneurs, mise en cache, absence de redondance inutile) et l'arbitrage éventuel avec la performance.
- **Preuves en annexe** : diagrammes d'architecture (composants, déploiement, séquence) ; journal des décisions d'architecture ; matrice cas d'utilisation / composants ; prototype de la solution.
- **Support QueenBee** : architecture d'exploitation du cahier des charges (cloud central, zone de données, sites en périphérie, simulateur), flux de données du **chapitre VI**, fonctionnement hors ligne, **calcul local des caractéristiques acoustiques**. *Projet d'entreprise : architecture de l'application dont on a la charge, schémas anonymisés si nécessaire.*

### B.3.6 Partie 3 — Intégrité et qualité du code (C2.2)

- **Objectif** : préparer un développement sûr et maîtrisé — outils, indicateurs de qualité, listes de contrôle, sécurité et conformité intégrées dès le début du cycle.
- **Question centrale** : *Quelles règles et quels contrôles donnent confiance dans le code dès qu'il est écrit, et pas seulement au moment de la livraison ?*
- **Critères d'évaluation** :

| Réf. | Énoncé |
|------|--------|
| Ce2.2.1 | Les processus et les outils à mettre en place pour intégrer la sécurité du code dès le début du cycle de développement (**shift-left**) sont clairement spécifiés. |
| Ce2.2.2 | Les indicateurs de référence définis permettent de garantir continuellement la qualité du code. |
| Ce2.2.3 | Les listes de contrôle permettent d'assurer la complétude, la conformité, l'intégrité et la qualité du code tout au long du processus de développement. |
| Ce2.2.4 | Les exigences attendues sur la sécurité dans le développement et la confidentialité du code source, ainsi que le respect réglementaire des normes (ITIL, RGPD) sont intégrés dans le cadre du projet tout au long du processus de développement. |
| Ce2.2.5 | Les outils et les fonctionnalités collaboratives de versionning (ex. GitHub) sont clairement précisés et permettent de gérer les versions et les mises à jour et d'éviter les conflits. |
| Ce2.2.6 | Les bonnes pratiques de codage établies permettent l'identification précoce des vulnérabilités, la réduction du temps de mise en production et une gestion des performances adéquate. |

- **Ce que le jury attend** : des règles **réellement appliquées**, des **indicateurs chiffrés assortis de seuils** et une sécurité traitée **dès l'écriture du code**, justifiées par les risques qu'elles couvrent.
- **Éléments à développer** :
  1. La gestion des versions : outils, branches, revue de code, conflits.
  2. Les indicateurs de qualité du code (couverture, complexité, dette) et leurs seuils.
  3. Les listes de contrôle (définition de fini, revue, sécurité) et ce qu'elles garantissent.
  4. La sécurité dès le début du cycle (analyse statique, dépendances, secrets).
  5. Le respect des normes et de la réglementation dans le processus (RGPD, ITIL).
  6. Les bonnes pratiques de codage et leur effet sur les vulnérabilités, les performances et le délai de mise en production.
- **Preuves en annexe** : règles de contribution et de revue ; listes de contrôle ; rapport d'analyse statique et de contrôle des dépendances ; extrait d'historique de revue de code.
- **Support QueenBee** : dépôt et pipelines de la spécialité, **contrôle Snyk** des dépendances et des conteneurs avant déploiement (chapitres V et VI). *Projet d'entreprise : règles de l'équipe, avec ce qui est de son fait.*

### B.3.7 Partie 4 — Développement front-end (C2.3)

- **Objectif** : piloter le développement de l'interface — choix d'outils et de frameworks, collaboration avec les métiers de la conception, ergonomie et accessibilité démontrées.
- **Question centrale** : *Comment l'interface permet-elle à chaque utilisateur, y compris en situation de handicap, d'accomplir sa tâche, et comment les choix techniques ont-ils été arbitrés ?*
- **Critères d'évaluation** :

| Réf. | Énoncé |
|------|--------|
| Ce2.3.1 | Les outils et les solutions de développement utilisés pour le front-end s'appuient sur la veille technologique des meilleures pratiques et standards actuels. |
| Ce2.3.2 | Les éléments graphiques, dynamiques et le design responsive de l'interface utilisateur intègrent avec succès les contributions d'autres professionnels (ex. web-designer, UX/UI designer) pour enrichir le projet et améliorer la qualité du produit final. |
| Ce2.3.3 | L'application intègre l'ensemble des dernières évolutions des outils et techniques de développement front-end, en utilisant des langages spécifiques tels que HTML5, CSS3, JavaScript, et en mettant à jour et appliquant les meilleures pratiques et standards actuels dans le développement front-end. |
| Ce2.3.4 | L'utilisation des bibliothèques de fonctions et de frameworks (ex. ReactJS, AngularJS, VueJS) répond aux besoins spécifiques du projet et améliore la fonctionnalité et l'interactivité des applications. |
| Ce2.3.5 | L'interface propose une navigation fluide, ergonomique, intuitive et inclusive, et elle est accessible à tous, y compris aux personnes en situation de handicap (ex. sous-titres, transcriptions, etc.). |

- **Ce que le jury attend** : des choix techniques **fondés sur la veille**, une interface **testée par des utilisateurs** et une accessibilité **démontrée par un audit**, non affirmée.
- **Éléments à développer** :
  1. Les outils et frameworks retenus, justifiés par la veille et les besoins.
  2. La collaboration avec les autres professionnels (designer, ergonome) : maquettes, retours.
  3. Les langages et standards (HTML5, CSS3, JavaScript) et le design adaptatif.
  4. L'ergonomie et la fluidité de la navigation, vérifiées auprès d'utilisateurs.
  5. L'accessibilité : référentiel retenu, audit réalisé, corrections apportées.
- **Preuves en annexe** : maquettes et captures de l'interface ; rapport d'audit d'accessibilité ; compte rendu de tests utilisateurs ; extraits de code d'un composant.
- **Support QueenBee** : **l'orientation DevOps limite le développement d'interface** ; la compétence doit être démontrée sur l'**application terrain hors ligne (UC-A01 à UC-A03)** ou le **tableau de bord de l'administrateur**, **après accord du tuteur**. *Projet d'entreprise : interface de l'application, captures anonymisées ; c'est le recours si QueenBee ne permet pas de la démontrer.*

> ⚠️ *Point d'attention majeur.* La spécialité Dev étant orientée DevOps, la compétence C2.3 (front-end) n'est **pas couverte naturellement** par le périmètre du cahier des charges. Il faut **obtenir l'accord du tuteur** pour la démontrer sur un livrable d'interface précis (app terrain offline ou dashboard admin). Voir C.6.

### B.3.8 Partie 5 — Développement back-end (C2.4)

- **Objectif** : piloter le développement du serveur, des bases de données, des interfaces de programmation et du back-office, selon des normes de sécurité et dans une démarche de numérique responsable.
- **Question centrale** : *Comment le serveur, les données et les interfaces de programmation assurent-ils le fonctionnement attendu, la sécurité et la sobriété ?*
- **Critères d'évaluation** :

| Réf. | Énoncé |
|------|--------|
| Ce2.4.1 | L'application back-end répond aux objectifs et aux contraintes techniques identifiées. |
| Ce2.4.2 | Le back-office permet la gestion de l'application dans le respect du cahier des charges et la liaison avec le front-end est assurée par APIs. |
| Ce2.4.3 | Les outils, technologies et langages objet (Python, Java ou Node.js) sont correctement mis en œuvre pour répondre aux besoins spécifiques du projet et en les utilisant pour développer des solutions back-end robustes et conformes aux normes de sécurisation. |
| Ce2.4.4 | La configuration des serveurs et des bases de données permet de répondre aux objectifs et contraintes du projet, et d'assurer la sécurité des données. |
| Ce2.4.5 | Les standards techniques, les normes de sécurisation (ex. W3C, OWASP) et les conformités réglementaires (ex. RGPD) sont respectés. |
| Ce2.4.6 | Les choix d'implémentation garantissent une utilisation efficace des ressources et permet de minimiser l'impact environnemental dans le cadre d'un développement numérique responsable (ex. code efficace et optimisé, gestion dynamique des ressources, caching etc.). |

- **Ce que le jury attend** : un back-end qui répond aux objectifs et contraintes identifiés, des **choix de technologies justifiés**, une **sécurité vérifiée par des tests** et non par déclaration, et une attention aux ressources consommées. La liaison avec le front-end par interface de programmation doit être **documentée**.
- **Éléments à développer** :
  1. Les objectifs et contraintes techniques, et les choix de langage, de technologies et de système de gestion de données qui en découlent.
  2. Les interfaces de programmation : contrat, documentation, liaison avec le front-end, et le back-office de gestion de l'application.
  3. La configuration des serveurs et des bases de données et les mesures qui assurent la sécurité des données.
  4. Le respect des standards techniques, des normes de sécurisation (W3C, OWASP) et de la réglementation (RGPD), avec les vérifications effectuées.
  5. Les choix d'implémentation qui limitent la consommation de ressources (code optimisé, mise en cache, gestion dynamique) et leur mesure.
  6. La collaboration avec les autres équipes (front-end, infrastructure, données).
- **Preuves en annexe** : contrat d'interface de programmation documenté ; schéma de la base de données ; extraits de code commentés ; rapport de tests de sécurité ; mesures de performance.
- **Support QueenBee** : **interface de programmation technique minimale** (santé, points d'accès techniques), **authentification et rôles (UC-T01)**, **synchronisation différée** entre sites et serveur central. *Projet d'entreprise : services dont on a la charge.*

### B.3.9 Partie 6 — Traitement des données à grande échelle (C2.5)

- **Objectif** : coordonner le développement des solutions de collecte, de traitement, de stockage et d'analyse de données à grande échelle, et justifier les choix technologiques.
- **Question centrale** : *Comment collecter, stocker et exploiter à grande échelle les données de la solution pour en tirer une valeur d'usage, et pourquoi ces technologies ?*
- **Critères d'évaluation** :

| Réf. | Énoncé |
|------|--------|
| Ce2.5.1 | La mise en œuvre de la collecte et du traitement par lot ou en temps réel des données par des outils technologiques (ex. Open Refine, Nifi, Apache Spark ou Storm) permet de répondre aux contraintes techniques et fonctionnelles du projet. |
| Ce2.5.2 | La mise en œuvre du stockage de données massives structurées ou non structurées, dans des bases de données analytiques ou opérationnelles, permet de répondre aux contraintes techniques et fonctionnelles du projet, et d'assurer la sécurité et l'intégrité des données. |
| Ce2.5.3 | La mise en œuvre d'analyses descriptives et prédictives sur des données massives, y compris l'utilisation de techniques de machine learning, permettent d'extraire de la valeur de la donnée de manière innovante et de répondre aux objectifs et contraintes du projet. |
| Ce2.5.4 | Les choix technologiques, les frameworks et les outils utilisés tout au long du projet sont présentés clairement, de manière argumentée, pour démontrer comment ces choix contribuent à l'efficacité et à l'innovation de la solution développée. |

- **Ce que le jury attend** : des choix de traitement et de stockage **justifiés par les volumes et les usages**, une analyse dont la **valeur est démontrée** et une sécurité des données traitée.
- **Éléments à développer** :
  1. La collecte et le traitement des données, par lots ou en temps réel : besoin, outils retenus, volumes visés.
  2. Le stockage des données structurées ou non, et leur sécurité et intégrité.
  3. Les analyses descriptives et prédictives mises en œuvre, y compris par apprentissage automatique, et la valeur obtenue, avec ses limites.
  4. La coordination de l'équipe : découpage, interfaces, intégration.
  5. L'argumentation d'ensemble des technologies et outils, au regard de l'efficacité et de l'innovation.
- **Preuves en annexe** : schéma des flux de données ; extraits du traitement ou de la chaîne de données ; résultats d'analyse ou de modèle avec indicateurs d'évaluation ; mesures de volume et de délai de traitement.
- **Support QueenBee** : chaîne d'**ingestion et de synchronisation des mesures (UC-T02)**, files de messages, stockage de séries temporelles. **Les volumes du cahier des charges sont modestes (environ 10 Mo par jour) : il faut justifier un dimensionnement cible et le démontrer avec le simulateur accéléré.** *Projet d'entreprise : données du projet, anonymisées.*

### B.3.10 Partie 7 — Compétences transversales
Voir **B.1.11**.

### B.3.11 Partie 8 — Conclusion et bilan
- **Objectif** : bilan de la conception et du développement — ce qui fonctionne, ce qui reste à faire, ce que l'on ferait autrement.
- **À traiter** :
  1. Les choix techniques qui se sont révélés pertinents et ceux que l'on reverrait.
  2. Ce que la solution démontre au regard du besoin initial, avec les mesures qui l'établissent (qualité, performance, accessibilité).
  3. Les limites de la solution et les évolutions envisagées.
  4. Ce que cette réalisation a appris sur la conception d'une solution logicielle innovante.

### B.3.12 Bibliographie et annexes
Voir **B.1.10**.

---
---

# PARTIE C — SYNTHÈSE CROISÉE POUR LA SPÉCIALITÉ DÉVELOPPEMENT (DEVOPS)

> 💡 *Cette partie est la valeur ajoutée de la synthèse.* Elle n'existe dans aucun des trois fichiers d'origine : elle les **relie** pour répondre à la question « *concrètement, que doit construire l'équipe Dev, avec quels objectifs mesurables, et comment cela valide-t-il les compétences EADL ?* ». Elle ne contient aucun fait nouveau sur le produit ; elle ne fait que recouper et organiser ce qui est écrit dans les sources.

## C.1 Rôle exact de la spécialité Développement

- **Positionnement** : *DevOps*. La spécialité **industrialise, déploie et exploite** la plateforme construite avec Data et Cyber ; elle ne développe **pas** l'intégralité du frontend/backend (CDC §5.2).
- **Ce que Dev possède en propre** : conteneurisation (Docker), CI/CD multi-sites, Infrastructure as Code, orchestration edge (K3s ou Docker Compose), observabilité (Prometheus/Grafana), files de synchronisation différée (MQTT/RabbitMQ), API technique minimale (Node/Express ou FastAPI), workflows n8n d'intégration, DevSecOps (Snyk), **et le simulateur de capteurs** (livrable transverse, dès le Sprint 0).
- **Ce que Dev partage** : le calcul acoustique en edge (charge de calcul sur la passerelle), le RBAC/JWT (avec Cyber), l'app terrain offline-first et sa synchronisation, la cartographie (avec Data), les notifications push/email.
- **Ce que Dev ne possède pas** : réseau/VLAN/VPN/firewall/SIEM (Cyber) ; modèles ML, entrepôt, PostGIS, ETL, dashboards analytiques (Data).

## C.2 Backlog fonctionnel et technique de la spécialité Dev

Regroupement par thème de tout ce que les sources demandent à Dev (références entre parenthèses).

### C.2.1 Obligatoire (« modules obligatoires », CDC §9.1)
| # | Élément | Détail | Source |
|---|---------|--------|--------|
| D1 | Pipeline CI/CD complet | Build + test + déploiement, **avec porte de sécurité Snyk** | §5.2, §9.1 |
| D2 | Conteneurisation | De **tous** les services applicatifs ; conteneurs versionnés dans un registry | §5.2, §9.1, §12.2 |
| D3 | IaC | Provisioning reproductible d'un **site pilote** (+ central) ; scripts documentés | §5.2, §9.1 |
| D4 | Dashboard d'exploitation | Déploiements, synchronisations, incidents | §9.1 |
| D5 | Synchronisation différée site ↔ central | File de messages, event-driven, déduplication | §5.2, §6.4, §9.1 |
| D6 | Workflow n8n | **Au moins un** fonctionnel (intégration API ou notification) ; workflows exportés | §5.2, §9.1 |
| D7 | Documentation de déploiement multi-sites | — | §9.1, §12.2 |

### C.2.2 Livrables spécifiques Dev
Code source GitHub · pipelines CI/CD fonctionnels avec scan Snyk · **DCT 30-35 pages** · scripts IaC documentés · workflows n8n exportés · environnement de démonstration déployé.

### C.2.3 Livrables communs aux 3 spécialités
DCT (30-35 p., DOCX/PDF) · README (Markdown) · Présentation de soutenance (20-25 slides, PPTX) · Démo (URL ou vidéo).

### C.2.4 Fonctionnel applicatif lié à Dev
| Élément | Cas d'utilisation / spec |
|---------|--------------------------|
| App mobile offline-first (inspection, alertes, récolte) | UC-A01, UC-A02, UC-A03 |
| Authentification JWT + MFA + RBAC 4 rôles + blocage après 5 tentatives | UC-T01, §5.1, §8.2 |
| Chiffrement des données locales avant synchronisation | UC-T01 |
| Gestion des conflits de synchronisation (double saisie) | UC-A01, §7.2 |
| API : Auth, Ruches, Inspections, Récoltes, Alertes, Analytics | §10.1 |
| Notifications push différées (Firebase) + email (Nodemailer/SendGrid) | §5.1, §10.2 |
| Cartographie (OpenStreetMap/Leaflet) | §10.2 |
| Édge : extraction des features acoustiques en local sur la passerelle | §6.4 |
| Simulateur (MQTT, accélération temporelle, 8 profils de sites, comportements humains, moteur de scénarios déclaratif, API de déclenchement) | §6.6 |

## C.3 Matrice exigences du produit ↔ compétences à démontrer

Pour chaque compétence EADL, ce que le projet QueenBee peut fournir comme **matière à preuve**.

### C.3.1 Bloc 1 — Planifier et organiser

| Compétence | Matière disponible dans QueenBee | À produire en plus |
|------------|----------------------------------|--------------------|
| C1.1 Faisabilité | Chap. I-II (contexte, problèmes, solution) ; périmètre (§1.4) ; contraintes connectivité, solaire, budget pédagogique ; ressources fournies (Annexe D : VM 16 Go + VM cloud 14 Go) | Matrice des risques, calcul de ROI avec hypothèses, compte rendu de recueil de besoins |
| C1.2 Veille | Thèmes imposés par le Bloc 1 : edge/connectivité limitée, files de messages, DevSecOps, automatisation, solutions comparables | Plan de veille, ≥ 2 comptes rendus (dont 1 FR depuis sources EN), tableau comparatif |
| C1.3 Cahier des charges | **Ce document** + chap. V (spécif.) et VIII (non fonctionnel) | Matrice besoins/fonctionnalités ; grille accessibilité + éco-conception (voir C.3.3) |
| C1.4 Feuille de route | Sprints 2 sem., jalons S1→S16 (§11.2), synchro lundi/mercredi/vendredi (§11.3), outils (§11.4) | Backlog priorisé, budget prévisionnel, indicateurs avec seuils de réaction |
| C1.5 Mise en place | Exécution des sprints, démos régulières | Comptes rendus de sprint, registre des risques, budget réalisé, plan de gestion du changement |
| C1.6 Mesure | Objectifs chiffrés : déploiements > 95 % sans incident, sync < 2 min/jour de données, API p95 < 500 ms | Tableau de bord à 2 dates, grille RGPD/qualité (ITIL, ANSSI), rétrospective |
| C1.7 Supervision | Revues de sprint devant l'équipe pédagogique (rôle BeeAfrica) | Journal des écarts, plans avant/après, comptes rendus de points |

### C.3.2 Bloc 2 — Concevoir et développer

| Compétence | Matière disponible dans QueenBee | À produire en plus |
|------------|----------------------------------|--------------------|
| C2.1 Architecture | §6.1-6.3 (couches, flux, zones réseau), §6.4 (edge, acoustique local), UC-CY01 (mode dégradé) | Diagrammes UML (composants, déploiement, séquence), journal des décisions (ADR), matrice UC/composants, prototype |
| C2.2 Intégrité du code | Snyk en CI/CD (§5.2, §6.7) ; GitHub/GitHub Actions (§9.1) | Règles de contribution, DoD, listes de contrôle, rapport d'analyse statique, indicateurs (couverture, complexité) avec seuils |
| C2.3 Front-end | UC-A01 à A03 (app offline) ou dashboard admin (vue DevOps) | **Accord du tuteur**, maquettes, audit d'accessibilité, tests utilisateurs |
| C2.4 Back-end | API technique minimale, auth/RBAC (UC-T01), sync différée, API §10.1 | Contrat OpenAPI, schéma BDD, tests sécurité (OWASP), mesures perf |
| C2.5 Données grande échelle | Ingestion UC-T02, MQTT, séries temporelles, 38 400 mesures/jour, 10 Mo/jour | Dimensionnement cible justifié + démonstration avec **simulateur accéléré** ; mesures volume/délai |

### C.3.3 Exigences d'accessibilité et de numérique responsable (à rédiger comme exigences)

Les critères **Ce1.3.3 / Ce1.3.4** (Bloc 1) et **Ce2.1.5 / Ce2.1.6 / Ce2.4.6** (Bloc 2) exigent que ces dimensions soient **explicites**. Le cahier des charges commun n'en dit que peu (§8.4 : « *accessibilité de l'application mobile pour des utilisateurs peu familiers du numérique* »). Voici les **éléments déjà présents dans les sources** qui peuvent être érigés en exigences :

**Accessibilité (à compléter avec un référentiel — les gabarits citent le RGAA, exemple Bloc 2 §Architecture) :**
- Application terrain utilisable par des **utilisateurs peu familiers du numérique** (§8.4) → interface simple, QR code pour la sélection de ruche (UC-A01), peu de saisie.
- Compatibilité lecteurs d'écran et sous-titres/transcriptions (Ce2.1.5, Ce2.3.5).
- Utilisation **hors connexion** comme condition d'accès équitable (§3.2).
- *À préciser par l'équipe* : référentiel retenu (RGAA / WCAG 2.2 AA), tailles de cibles tactiles, contrastes, langues (français, langues locales ?), audit réalisé.

**Numérique responsable (déjà présent dans les sources) :**
- Traitement acoustique **en local** : transmission de ~8 octets au lieu de l'audio brut (§6.4 ; exemple Bloc 2) → réduit trafic radio et énergie sur sites solaires.
- Échantillonnage **adaptatif** : fréquence réduite en normal, resserrée en anomalie (§6.4).
- Données minimisées (RGPD, §8.2/§8.4), position GPS à surcoût négligeable (§6.5).
- Conteneurisation, virtualisation, arrêt des environnements inutilisés, mise en cache (Ce2.1.6, Ce2.4.6, B.1.11).
- Dimensionnement frugal : la volumétrie est modeste (~10 Mo/j), donc pas de sur-dimensionnement (C2.5).
- *À mesurer par l'équipe* : consommation CPU/mémoire des conteneurs, surcoût du calcul acoustique sur passerelle (« limite assumée » de l'exemple Bloc 2), poids des pages/API, durée de vie batterie.

## C.4 Interfaces avec Data et Cyber

| Avec | Dev fournit | Dev reçoit |
|------|-------------|-----------|
| **Data** | Simulateur local (Docker) ; flux MQTT ; pipeline CI/CD + Snyk pour les images ETL ; API ; workflows n8n d'intégration ; infra de déploiement | Modèle de données (PostGIS/DW) ; scores de santé/risque (pour alertes UC-A02/UC-C01) ; dashboards à héberger ; rapports PDF (UC-G02) |
| **Cyber** | Instance centrale du simulateur (**Proxmox**, 8 sites/400 ruches) avec API de déclenchement de scénarios ; edge/cache local ; scripts Ansible (scannés par Snyk) ; monitoring | Réseau/VLAN/VPN/firewall FortiGate ; SIEM ; certificats passerelles ; playbooks n8n de réponse ; règles de validation à l'ingestion (UC-CY02) |

*Rappel des points de synchronisation hebdomadaires* : **Lundi** planning + blocages · **Mercredi** revue technique/intégrations · **Vendredi** démo d'intégration + rétrospective (§11.3).

## C.5 Objectifs chiffrés à atteindre (récapitulatif consolidé)

| Domaine | Indicateur | Cible | Responsable | Source |
|---------|-----------|-------|-------------|--------|
| Déploiement | Déploiements réussis sans incident | **> 95 %** | Dev | §1.3 |
| API | Temps de réponse p95 | **< 500 ms** | Dev | §8.1 |
| Synchronisation | Rattrapage après reconnexion | **< 2 min pour 1 jour de données** | Dev | §8.1 |
| Edge | Fonctionnement en coupure | Mode dégradé garanti | Dev/Cyber | §8.1 |
| Heartbeat passerelle | Détection d'absence | **> 15 min** → alerte | Cyber (supervision) | UC-CY01 |
| Tunnel VPN | Détection de rupture | **> 5 min** | Cyber | §4.6 |
| Capteur silencieux | Détection | **2 cycles** de mesure sans trame | Cyber | §4.6 |
| Auth | Verrouillage | **5 tentatives** | Dev/Cyber | UC-T01 |
| Disponibilité | Uptime central | **99 %** (§8.3) / **> 99 %** (§1.3) | Cyber | — |
| Reprise | RTO / RPO | **< 8 h / < 24 h** | Cyber / Cyber+Data | §8.3 |
| Sauvegardes | Fréquence | Quotidiennes, chiffrées | Cyber | §8.3 |
| LoRaWAN | Débit par site | 50 messages/min | Cyber | §8.1 |
| SQL analytique | Requêtes | **< 200 ms (90 %)** | Data | §8.1 |
| Rendement | Erreur MAE | **< 15 %** | Data | §1.3 |
| Essaimage | Détection ≥ 48 h avant | **+80 %** | Data | §1.3 |
| Visites évitées | Réduction | **-25 %** | Data/Dev | §1.3 |
| Coopératives actives | Nombre | **25** | Tous | §1.3 |
| Incidents sécurité majeurs | Nombre | **0** | Cyber | §1.3 |
| Rendement miel (enjeu) | Hausse visée | **+15 %** | — | §1.1 |
| Volumétrie | Mesures/jour | ≈ 38 400 (+ 19 200 estim. acoustiques) | — | §6.4 |
| Volumétrie | Volume en base | ≈ 10 Mo/jour (≈ 300 Mo/mois) | — | §6.4 |
| Volumétrie | Charge/passerelle | ≈ 50 ruches ; ≈ 4 800 mesures/jour/site | — | §6.4 |
| Env. fourni (info) | Reprise VM partagée | < 4 h heures ouvrées ; perte max 30 min | Équipe pédagogique | Annexe D |

## C.6 Risques et points d'attention

| # | Risque / point d'attention | Pourquoi c'est important | Mesure suggérée (déduite des sources) |
|---|----------------------------|-------------------------|---------------------------------------|
| R1 | **Simulateur = chemin critique** | Data et Cyber en dépendent dès le Sprint 0 (§6.6). S'il est en retard, tout est bloqué. | Le livrer en priorité (version minimale : MQTT + 1 site + 1 scénario), puis enrichir. |
| R2 | **Compétence C2.3 (front-end) hors périmètre naturel** | L'orientation DevOps limite l'interface (Bloc 2 §4). | Obtenir tôt l'accord du tuteur sur un livrable d'interface (app offline minimale ou dashboard admin). |
| R3 | **Passerelles à capacité variable** | Un orchestrateur lourd (K3s ≈ 500 Mo au repos, exemple du gabarit) peut ne pas tenir partout. | Prévoir deux modes de déploiement : K3s / Docker Compose (§9.1). |
| R4 | **Connectivité intermittente** | Cache local, déduplication, file de sync, reprise automatique sont critiques (§6.4). | Tests de coupure chronométrés avec le simulateur (cf. §8.3 « concevoir / démontrer / documenter »). |
| R5 | **Surcoût du calcul acoustique en edge non mesuré** | Cité comme « limite » dans le gabarit. | Mesurer CPU/RAM/énergie sur passerelle ; en faire un indicateur. |
| R6 | **Sécurité de la chaîne CI/CD** | Snyk est une « porte » obligatoire avant déploiement (§5.2). | Faire échouer le pipeline sur vulnérabilité critique ; garder le rapport en annexe (Ce2.2.x). |
| R7 | **Ressources fournies limitées** | VM cloud de groupe 14 Go ; VM partagée 16 Go (Annexe D). | Dimensionner frugalement ; arrêter les environnements inutilisés (numérique responsable). |
| R8 | **Disponibilité de l'équipe** | Les gabarits citent l'exemple d'une équipe disponible 1 semaine sur 4. | Documenter la capacité réelle dans l'étude de faisabilité. |
| R9 | **Confidentialité / RGPD** | Données de bénéficiaires vulnérables, localisation de ruchers (§1.1, §7.2, §8.4). | Minimisation, chiffrement, traçabilité complète, souveraineté des données. |
| R10 | **Écart plan / réalité à documenter** | Le Bloc 1 exige des écarts réels (« un plan parfaitement suivi est peu crédible »). | Tenir un journal des écarts dès le Sprint 0. |
| R11 | **Délais de remise des dossiers** | Remise 2 à 4 semaines **avant** la soutenance ; retard = report possible. | Rétro-planifier la rédaction dans le calendrier S1-S16. |

## C.7 Incohérences et points à clarifier dans les sources

Relevés lors de la lecture croisée. **Aucune n'a été « corrigée » dans les parties A et B** : elles sont reproduites telles quelles, et signalées ici pour décision par l'équipe / le tuteur.

| # | Constat | Détail | Suggestion |
|---|---------|--------|------------|
| I1 | **Durée du projet** | Page de garde : « 5 mois (Janvier – Mai) ». Tableau des jalons (§11.2) : titre « 4 mois », soit S1 → S16 (≈ 16 semaines). | Clarifier avec l'école ; 5 mois ≈ 20 semaines vs 16 semaines de jalons. |
| I2 | **Fréquence de mesure IoT** | UC-T02 : « toutes les **30 min** ». §6.4 : poids/temp/humidité **15 min**, acoustique 30 min. Volumétrie calculée avec 96 mesures/jour (15 min). | Retenir §6.4 (plus détaillé et chiffré) ; corriger UC-T02. |
| I3 | **Disponibilité cible** | §1.3 : uptime « **> 99 %** » ; §8.3 : « **99 %** ». | Choisir une formulation ; rappel : non évalué en production réelle (§8.3). |
| I4 | **Zones réseau — VLAN** | Tableau §6.3 : Management = VLAN **30** (10.10.3.0/24) et IoT = VLAN **40** (10.10.4.0/24), listés dans l'ordre DMZ(10) / LAN(20) / IoT(40) / Mgmt(30). | Pas une erreur, mais l'ordre est non séquentiel ; vérifier côté Cyber. |
| I5 | **Pare-feu** | §6.7 : Fortinet « remplace/complète pfSense » ; §9.3 : pfSense/OPNsense « en repli ». | Fortinet = choix principal ; pfSense = repli seulement. |
| I6 | **RTO/RPO** | Cible projet : RTO < 8 h, RPO < 24 h (§8.3). Environnement fourni (Annexe D) : reprise < 4 h, perte max 30 min. | Pas une contradiction (périmètres différents : conception BeeAfrica vs VM école) ; à ne pas confondre. |
| I7 | **Numérotation du tronc des RNCP** | Annexe B parle de « RNCP EADL / EASRSI » (4 blocs) ; les gabarits visent « EADL — **RNCP38822** » (blocs 1 et 2 seulement ici). | Les blocs 3 et 4 (mise en production/sécurité ; pilotage) ne font pas l'objet de gabarit dans ce dossier. |
| I8 | **Gabarits : phrases dupliquées** | Dans `TEMPLATE_BLOC1` (Parties 2 et 3) et `TEMPLATE_BLOC2` (Partie 2), la phrase « *Projet d'entreprise : …* » est répétée deux fois, et le Bloc 1 Partie 2 contient un fragment tronqué (« …pilotage des tournées). »). | Coquilles de gabarit, sans impact sur le fond. Reproduites sans la duplication ici. |
| I9 | **« Cahier des charges » : double sens** | Le Bloc 1 Partie 4 demande un *cahier des charges fonctionnel* rédigé par l'étudiant, alors que le CDC commun QueenBee existe déjà. | Le CDC commun est la source ; le « DCT » de 30-35 pages (livrable) est le document dérivé qui précise les exigences de **notre** spécialité (Bloc 1 §4 : « chapitres V et VIII »). Ce fichier-ci en est la base. |
| I10 | **Nom de fichier du volume** | Les gabarits indiquent le format `NOM_Prenom_BLOC[N]_[SPECIALITE]_[ANNEE].pdf`. | Rappel pour la remise. |
| I11 | **Exemples de gabarit « fictifs »** | Les exemples (équipe de 4, 60 h de travail, risque 12/16, 500 Mo K3s, etc.) sont **fictifs** et « ne doivent ni être recopiés ni servir de plan type ». | Ne pas les réutiliser comme faits du projet. |

## C.8 Glossaire consolidé

Reprend l'Annexe A du CDC et ajoute les termes issus des gabarits.

| Terme | Définition |
|-------|-----------|
| IoT | Internet of Things — objets connectés communicants |
| LoRaWAN | Protocole radio longue portée / faible consommation pour capteurs distants |
| MQTT | Protocole de messagerie léger pour l'IoT |
| PostGIS | Extension PostgreSQL pour les données géographiques |
| CI/CD | Intégration et déploiement continus |
| IaC | Infrastructure as Code |
| Edge computing | Traitement des données au plus proche de leur source |
| JWT | JSON Web Token — standard d'authentification |
| RBAC | Contrôle d'accès basé sur les rôles |
| Star Schema | Modèle de Data Warehouse (faits + dimensions) |
| ETL | Extract, Transform, Load |
| SIEM | Security Information and Event Management |
| PSSI | Politique de Sécurité du Système d'Information |
| RTO / RPO | Recovery Time / Point Objective — indicateurs de continuité d'activité |
| n8n | Plateforme d'automatisation de workflows (low-code) pour l'orchestration et les playbooks |
| Snyk | Outil DevSecOps de scan de vulnérabilités (dépendances, conteneurs, IaC) |
| FortiGate | Firewall nouvelle génération (NGFW) de Fortinet, filtrage et VPN |
| FortiAnalyzer / FortiSIEM | Solutions Fortinet de centralisation et corrélation des journaux de sécurité |
| SOAR | Security Orchestration, Automation and Response |
| Playbook | Séquence d'actions automatisées déclenchée en réponse à un incident |
| **EADL** | Expert en Architecture et Développement Logiciel — certification visée (RNCP38822, niveau 7 EU) |
| **RNCP** | Répertoire National des Certifications Professionnelles |
| **DCT** | Document de Cadrage Technique (30-35 pages) — livrable commun |
| **DevSecOps** | Intégration de la sécurité dans la chaîne DevOps (shift-left) |
| **Shift-left** | Traiter la sécurité/qualité le plus tôt possible dans le cycle de développement |
| **Duty cycle** | Pourcentage de temps d'émission radio autorisé (≈ 1 % en EU868 pour LoRaWAN) |
| **Spreading factor** | Paramètre LoRa qui règle portée et débit (plus il est élevé, plus la portée est grande et le débit faible) |
| **VDOM** | Virtual Domain FortiGate — instance de pare-feu isolée (un par groupe) |
| **K3s** | Distribution Kubernetes légère pour l'edge |
| **Offline-first** | Conception d'une application qui fonctionne d'abord hors ligne, puis se synchronise |
| **Heartbeat** | Signal périodique prouvant qu'un équipement est vivant |
| **Transhumance** | Déplacement planifié de ruches (déplacement *déclaré*, par opposition à un vol) |
| **Miellée** | Période de floraison pendant laquelle les abeilles produisent le miel (pic de poids de la ruche) |
| **Couvain** | Zone de la ruche où la reine pond ; maintenue autour de 34-35 °C |
| **Essaimage** | Départ d'une partie de la colonie avec une reine — provoque une chute brutale de poids |
| **RGAA** | Référentiel Général d'Amélioration de l'Accessibilité (France) |
| **WCAG** | Web Content Accessibility Guidelines |
| **OWASP** | Open Web Application Security Project — référentiel de sécurité applicative |
| **ANSSI** | Agence nationale de la sécurité des systèmes d'information (France) |
| **ITIL** | Référentiel de bonnes pratiques de gestion des services IT |
| **RGPD** | Règlement Général sur la Protection des Données |
| **ADR** | Architecture Decision Record — journal daté des décisions d'architecture |
| **KPI** | Key Performance Indicator — indicateur clé de performance |
| **Kanban** | Méthode de gestion visuelle des tâches (tableau) |

---

## Fin du document

*Synthèse établie à partir des trois fichiers du dossier `D:\Projets\QueenBee`. Les parties A et B reprennent le contenu des sources sans omission ; la partie C et les blocs « 💡 Explication / ⚠️ Point d'attention / 🎯 Responsabilité » sont des ajouts de synthèse, clairement identifiés.*
