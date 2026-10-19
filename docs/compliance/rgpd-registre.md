# Registre des activités de traitement (RGPD art. 30) - brouillon

> **Brouillon à faire valider** (bases légales, durées, sous-traitants, transferts) avec l'association BeeAfrica et le tuteur : les valeurs ci-dessous sont des **propositions de travail**, pas des avis juridiques. Données de bénéficiaires potentiellement vulnérables et localisation de ruchers : exigences de minimisation, chiffrement, traçabilité et souveraineté (cahier des charges §8.4, ROADMAP §5.7). Une AIPD simplifiée est prévue (ROADMAP §5.7).

## Responsable du traitement
- Organisme : association BeeAfrica (rôle joué par l'équipe pédagogique pour le projet) - Contact RGPD : (à renseigner)
- Hébergement : VM Oracle Cloud (région à trancher, décision ouverte n°6 du ROADMAP §9) - Souveraineté : données hébergées dans la région exigée par les pays hôtes (3 pays, table `country.data_residency`).
- Sous-traitants à lister : hébergeur cloud, Firebase Cloud Messaging (notifications push), SendGrid/SMTP (e-mail), GitHub (code, pas de données personnelles).

## Traitements
| # | Traitement | Finalité | Base légale (proposée) | Personnes concernées | Catégories de données | Destinataires | Durée de conservation (proposée) | Mesures de sécurité | Transfert hors UE |
|---|---|---|---|---|---|---|---|---|---|
| T1 | Gestion des comptes et authentification | Accès sécurisé à la plateforme (UC-T01, UC-AD01) | Exécution du contrat / mission d'intérêt de l'association | Apiculteurs, coordinateurs, gestionnaires, administrateurs | E-mail, nom (chiffré), téléphone (chiffré), rôle, secret MFA (chiffré), hash argon2id, jetons (hash), journaux de connexion | Administrateurs habilités | Durée du compte + délai défini (à fixer) | argon2id, pgcrypto, RBAC + RLS, MFA, verrou 5 essais | à évaluer (hébergeur) |
| T2 | Suivi des ruches et télémétrie | Détection de risques, pilotage des visites (UC-T02, UC-C01) | Intérêt légitime / mission de l'association | Propriétaires de ruches (indirect) | Identifiant et position des ruches (GPS), mesures, alertes | Coordinateurs, gestionnaires (RLS par site) | Mesures 3 ans (rétention Timescale), alertes (à fixer) | TLS 1.3, VPN, RLS, signature capteurs | à évaluer |
| T3 | Inspections de terrain et photos | Traçabilité du suivi sanitaire (UC-A01) | Mission de l'association | Apiculteurs | Notes libres, photos (EXIF nettoyé), auteur, date | Coordinateurs du site | (à fixer) | Ré-encodage photo, SQLCipher sur mobile, accès par site | à évaluer |
| T4 | Déclaration et validation des récoltes | Suivi de production, rapports bailleurs (UC-A03, UC-C02, UC-G02) | Mission de l'association | Apiculteurs | Volumes, dates, ruche, validation | Coordinateurs, gestionnaires, bailleurs (agrégé/anonymisé) | (à fixer) | Agrégation avant export, RBAC | non |
| T5 | Notifications | Alertes aux utilisateurs (UC-A02) | Mission de l'association | Utilisateurs | Jeton d'appareil FCM, e-mail | FCM, fournisseur d'e-mail | Durée de l'appareil enregistré | Minimisation du contenu des notifications (pas de PII) | **oui (FCM)** - à encadrer |
| T6 | Journal d'audit et sécurité | Traçabilité, détection d'incidents (UC-CY02) | Obligation de sécurité / intérêt légitime | Tous les utilisateurs | Acteur, action, entité, IP, horodatage | Administrateurs, équipe Cyber | (à fixer, ex. 12 mois) | Table append-only, accès restreint, pas de PII en clair dans Loki | non |
| T7 | Rapports et analytics consolidés | Pilotage et reporting bailleurs (UC-G01, UC-G02) | Mission de l'association | Bénéficiaires (indirect) | Indicateurs agrégés | Gestionnaires, bailleurs | (à fixer) | Agrégation, seuils de non-diffusion | non |

## Droits des personnes
| Droit | Modalité prévue | Où c'est implémenté |
|---|---|---|
| Information | Mention dans l'app et la landing (TODO ticket EP-12) | web/mobile |
| Consentement | Recueil à la première connexion (`app_user.consent_at`) | API + mobile |
| Accès / portabilité | Export des données d'un utilisateur (à spécifier) | API (TODO) |
| Rectification | Modification du profil | API |
| Effacement | Suppression ou anonymisation d'un compte (soft delete + purge PII) | API + DB (TODO) |
| Opposition / limitation | Désactivation du compte (`active = false`) | API |

## Violation de données (art. 33/34)
Procédure à rédiger (runbook) : détection (UC-CY02), évaluation, notification à l'autorité sous 72 h si nécessaire, information des personnes. TODO(KAN-xxx, SEC).

## AIPD simplifiée (à produire)
Nécessité et proportionnalité, risques pour les personnes (fuite de localisation de ruchers, identification de bénéficiaires), mesures, risque résiduel. TODO(KAN-xxx, SEC/DOSSIER).

## Suivi
| Date | Changement | Auteur |
|---|---|---|
| | | |
