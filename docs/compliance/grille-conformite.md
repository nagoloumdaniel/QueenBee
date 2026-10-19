# Grille de conformité - RGPD, ITIL, ANSSI, qualité

> Pièce du Bloc 1 (C1.6, critère Ce1.6.3 : la conformité est **vérifiée** sur le projet, pas seulement citée) et du Bloc 2 (Ce2.2.4, Ce2.4.5). À remplir **à deux dates au moins** (mi-projet puis fin de projet) pour montrer l'évolution. Statut : **Conforme / Partiel / Non conforme / N/A** ; toujours une **preuve** (fichier, test, rapport, PR).

| Date de relevé | Auteur | Version du projet / tag |
|---|---|---|
| | | |

## 1. RGPD
| # | Exigence | Statut | Preuve | Écart / action |
|---|---|---|---|---|
| G1 | Registre des traitements tenu (`rgpd-registre.md`) | Partiel | brouillon présent | faire valider bases légales et durées |
| G2 | Minimisation des données (seulement le nécessaire) | | revue du schéma `docs/data-dictionary.md` | |
| G3 | Consentement recueilli et tracé (`consent_at`) | | test E2E | |
| G4 | PII chiffrées au repos (pgcrypto, SQLCipher) | | migration + test | |
| G5 | Droit d'accès / effacement implémenté | | endpoint + test | |
| G6 | Durées de conservation appliquées (rétention Timescale, purge) | | politique + job | |
| G7 | Souveraineté : hébergement dans la région exigée | | décision ROADMAP §9-6 | |
| G8 | Sous-traitants encadrés (hébergeur, FCM, e-mail) | | contrats / DPA | |
| G9 | Procédure de violation de données (72 h) | | runbook | |
| G10 | AIPD simplifiée réalisée | | document | |
| G11 | Aucune PII en clair dans les logs | | revue des logs, test | |

## 2. ITIL (gestion des services)
| # | Pratique | Statut | Preuve | Écart / action |
|---|---|---|---|---|
| I1 | Gestion des incidents (sévérités, runbooks, post-mortem sans blâme) | | `docs/runbooks/`, post-mortems | |
| I2 | Gestion des changements (PR relue, CI verte, déploiement pilote puis généralisation, rollback testé) | | `docs/jira/PLAYBOOK.md`, workflows CI | |
| I3 | Gestion des problèmes (cause racine, ticket de suivi) | | tickets | |
| I4 | Gestion des mises en production / releases (checklist, notes de version, tags SemVer) | | CHANGELOG, tags | |
| I5 | Gestion de la configuration (IaC versionné, reconstruction en une commande) | | `infra/` | |
| I6 | Gestion des niveaux de service (disponibilité 99 %, RTO < 8 h, RPO < 24 h) | | mesures, démo chronométrée | |
| I7 | Continuité / sauvegardes (quotidiennes chiffrées, restauration testée) | | `docs/runbooks/restore-database.md` | |

## 3. ANSSI (recommandations d'hygiène et de configuration)
| # | Recommandation | Statut | Preuve | Écart / action |
|---|---|---|---|---|
| A1 | TLS conforme aux recommandations (TLS 1.3, suites modernes, HSTS) | | scan, config Caddy | |
| A2 | Mots de passe : stockage argon2id, politique de longueur, MFA pour les rôles privilégiés | | tests auth | |
| A3 | Cloisonnement réseau (VPN WireGuard site-central, zones de sécurité) | | schéma réseau (Cyber) | |
| A4 | Moindre privilège (comptes de service, conteneurs non-root, RBAC + RLS) | | revue, tests IDOR | |
| A5 | Journalisation et supervision (audit append-only, Loki, Alertmanager) | | dashboards | |
| A6 | Mises à jour et gestion des vulnérabilités (Snyk, Trivy, Dependabot) | | rapports CI | |
| A7 | Sauvegardes hors site et testées | | restauration chronométrée | |
| A8 | Gestion des secrets (SOPS/age, rotation, jamais dans le dépôt) | | Gitleaks vert | |

## 4. Qualité logicielle et accessibilité
| # | Exigence | Statut | Preuve | Écart / action |
|---|---|---|---|---|
| Q1 | OWASP ASVS niveau 2 (`docs/security/asvs-checklist.md`) | | checklist remplie | |
| Q2 | WCAG 2.2 AA / RGAA 4.1 (`docs/accessibility/checklist.md`) | | audit axe-core + TalkBack | |
| Q3 | Éco-conception (`docs/eco-conception/checklist.md`) | | mesures | |
| Q4 | Couverture de tests >= 80 % (API), 0 vulnérabilité critique | | rapports CI | |
| Q5 | API conforme au contrat OpenAPI (Schemathesis) | | rapport | |

## Analyse des écarts et axes d'amélioration (Ce1.6.4)
| Écart | Cause | Amélioration proposée (concrète, datée) | Effet attendu | Échéance |
|---|---|---|---|---|
| | | | | |
