# Playbook des tickets QueenBee

Référence unique pour chaque ticket Jira (projet **QueenBee**, clé `KAN`). Chaque ticket renvoie ici pour les règles communes ; la fiche Jira ne contient que le spécifique à la tâche.

## 1. Équipe et capacité
| Code | Membre | accountId Jira | GitHub |
|---|---|---|---|
| LH | Land Hack (owner, seul à pousser sur `main`) | `6403031c93cf2599462f0b3e` | nagoloumdaniel |
| IG | Ibrahima Gueye | `712020:48221cd5-77a3-4b41-a7ac-0d8881bc4718` | Ibrahima0 |
| WA | Wissam Ait El Hadii | `712020:141ff312-954d-45c3-82d2-33eb5ef1e953` | wissam2005-ait |

Capacité : ~10 h/semaine/personne → ~20 h/sprint/personne. Début 2026-10-20, fin visée 2027-06-11 (soutenance 2027-06-14 au plus tard). Chacun touche à tout : les tickets tournent entre LH, IG, WA par domaine ; le relecteur d'un ticket est la personne suivante (LH→IG→WA→LH).

## 2. Calendrier des sprints (2 semaines)
| Sprint | Début | Fin (due date des tickets) |
|---|---|---|
| S01 | 2026-10-20 | 2026-11-02 |
| S02 | 2026-11-03 | 2026-11-16 |
| S03 | 2026-11-17 | 2026-11-30 |
| S04 | 2026-12-01 | 2026-12-14 |
| S05 | 2026-12-15 | 2026-12-28 |
| S06 | 2026-12-29 | 2027-01-11 |
| S07 | 2027-01-12 | 2027-01-25 |
| S08 | 2027-01-26 | 2027-02-08 |
| S09 | 2027-02-09 | 2027-02-22 |
| S10 | 2027-02-23 | 2027-03-08 |
| S11 | 2027-03-09 | 2027-03-22 |
| S12 | 2027-03-23 | 2027-04-05 |
| S13 | 2027-04-06 | 2027-04-19 |
| S14 | 2027-04-20 | 2027-05-03 |
| S15 | 2027-05-04 | 2027-05-17 |
| S16 | 2027-05-18 | 2027-05-31 |
| S17 | 2027-06-01 | 2027-06-11 |

S05–S06 = vacances : charge réduite volontairement.

## 3. Nommage
- **Ticket** : `[ZONE] Verbe + objet` (ex. `[DB] Écrire la migration des tables site et country`). Zones : GOV, DESIGN, MODEL, INFRA, CI, SIM, DB, AUTH, INGEST, EDGE, API, MOBILE, WEB, N8N, OBS, SEC, QA, SEO, DOC, DOSSIER, REVUE.
- **Branche** : `<type>/EP-<nn>-<slug>` — types `feat|fix|refactor|test|docs|chore|ci` ; slug minuscule, tirets, sans accent, ≤ 40 car. Exemple : `feat/EP-04-migration-site-country`. Une branche = un ticket. Branche de phase : `phase/<nn>-<slug>`. Jamais de commit direct sur `main` ni `phase/*`.
- **Commit** : Conventional Commits, impératif, ≤ 72 car. : `feat(db): ajoute la migration site et country (KAN-123)`.
- **PR** : titre = commit principal ; corps = Quoi / Pourquoi / Comment tester / Preuves (sortie E2E) / Risques ; `Closes KAN-123`. Relecteur obligatoire (voir §1). Merge sur `main` : **LH uniquement**.
- **Fichiers** : `snake_case.py`, `kebab-case.tsx`, `snake_case.dart`, migrations `NNNN_slug.py`.

### Numérotation des epics : Jira fait foi
`ROADMAP.md` §5.4 et les `TODO(EP-xx)` du squelette utilisent une ancienne numérotation. Pour les **branches et tickets, utiliser la numérotation Jira** :

| Jira (à utiliser) | Clé | Sujet | Ancien n° ROADMAP §5.4 |
|---|---|---|---|
| EP-00 | KAN-3 | Gouvernance, cadrage | — |
| EP-01 | KAN-4 | Design, modélisation | — |
| EP-02 | KAN-5 | Infra, CI/CD | EP-00 |
| EP-03 | KAN-6 | Simulateur | EP-01 |
| EP-04 | KAN-7 | Base de données | EP-02 |
| EP-05 | KAN-8 | Auth, RBAC | EP-03 |
| EP-06 | KAN-9 | Ingestion, règles | EP-04 |
| EP-07 | KAN-10 | Edge, sync | EP-05 |
| EP-08 | KAN-11 | API métier | EP-06 |
| EP-09 | KAN-12 | App Flutter | EP-07 |
| EP-10 | KAN-13 | Dashboard web | EP-08 |
| EP-11 | KAN-14 | n8n | EP-09 |
| EP-12 | KAN-15 | Observabilité, reprise | EP-10 + EP-11 |
| EP-13 | KAN-16 | Sécurité, perf, a11y, éco | — |
| EP-14 | KAN-17 | Landing, SEO | EP-12 |
| EP-15 | KAN-18 | Documentation, dossiers | — |

## 4. Règle de temps (time-box)
- Chaque ticket a un **Temps max** (1–4 h). Mesurer réellement.
- À **80 %** du temps sans avancée visible : écrire un commentaire (bloqué sur quoi, essai fait).
- À **100 %** : STOP. Commenter l'état, pousser la branche WIP en PR draft, passer le ticket en « bloqué » ou le découper. Ne jamais dépasser sans le dire à l'équipe.
- Commenter le temps réel dans le ticket à la fin (Travail enregistré).

## 5. Cycle d'un ticket (checklist)
1. Lire le ticket + les fichiers cités ; si flou, poser la question en commentaire avant de coder.
2. `git switch main && git pull && git switch -c <branche>`.
3. Passer le ticket en **En cours**.
4. Écrire le **test E2E** (ou intégration pour les tickets sans parcours) en premier — il doit échouer.
5. Coder au plus petit nécessaire jusqu'au vert. Pas de refactor hors périmètre.
6. Lancer lint + tests locaux.
7. Relire son propre diff (`git diff main`) : pas de secret, pas de code mort, pas de TODO sans ticket.
8. Commit + push + PR vers `main` (ou branche de phase) avec preuves.
9. Passer en **En revue**, notifier le relecteur.
10. Corriger les retours ; après accord de LH → merge → **Terminé**.

## 6. Definition of Done (tous tickets)
- Critères d'acceptation du ticket cochés.
- Test E2E (ou intégration) vert en CI, sortie jointe à la PR.
- Lint/format/types OK ; Snyk/gitleaks sans critique.
- Documentation mise à jour (README/ADR/OpenAPI si concerné).
- Accessibilité vérifiée si UI ; états loading/erreur/vide/hors-ligne présents.
- Aucun secret committé ; données personnelles minimisées.
- Branche nommée selon §3 ; PR relue.

## 7. Bonnes pratiques par domaine
**GOV/DOC** : écrire pour un lecteur qui n'a pas vu le projet ; une décision = un ADR daté (contexte, options, choix, conséquences) ; chiffrer les hypothèses.
**DESIGN** : direction propre à QueenBee (miel/terre/feuille), jamais copier une autre app ; contrastes ≥ 4,5:1 ; cibles ≥ 48 dp ; tout écran a ses 4 états (loading/erreur/vide/hors-ligne) ; textes courts en français simple, icône + mot.
**MODEL** : Mermaid versionné dans `docs/diagrams/` ; un diagramme = une question ; légende + source ; lisible sans l'auteur.
**INFRA/CI** : tout par IaC (jamais de clic manuel) ; idempotent (relancer = même résultat) ; images minimales, utilisateur non-root, versions épinglées ; secrets via SOPS/GitHub Secrets ; chaque pipeline échoue vite ; rollback testé avant déploiement.
**SIM** : même topic/format que le matériel réel ; graine aléatoire fixe pour reproduire ; scénario = YAML déclaratif ; toujours exporter la vérité terrain.
**DB** : migration réversible (up + down) testée sur base vide ; UUID, `timestamptz` UTC ; index créés avec la requête qui les justifie ; jamais de migration destructive sans sauvegarde ; PII chiffrée (pgcrypto).
**AUTH/SEC** : argon2id ; JWT court ; refus par défaut ; vérifier l'autorisation côté serveur à chaque requête ; messages d'erreur génériques ; jamais de secret ou PII en logs ; tests IDOR par rôle.
**INGEST** : idempotent (rejouer = pas de doublon) ; valider avant d'écrire ; rejeter + journaliser plutôt qu'ignorer ; règles de seuil purement fonctionnelles et testées à 100 %.
**EDGE** : prévoir la coupure ; cache disque borné ; reprise automatique ; ne jamais transmettre l'audio brut ; mesurer RAM/CPU.
**API** : contrat OpenAPI d'abord ; Pydantic strict ; pagination curseur ; erreurs RFC 9457 ; idempotency-key sur POST ; pas de SQL dans les routers (service → repository) ; p95 < 500 ms.
**MOBILE (Flutter)** : offline-first (la DB locale est la source de l'UI) ; outbox pour toute écriture ; jamais bloquer l'UI sur le réseau ; Riverpod ; widgets petits et const ; tokens du thème, pas de couleurs en dur ; Semantics sur tout élément interactif.
**WEB (Next.js)** : Server Components par défaut, `use client` seulement si nécessaire ; types générés depuis OpenAPI ; pas de fetch en cascade ; images optimisées ; focus visible ; clavier complet.
**N8N** : workflow exporté en JSON versionné ; credentials hors JSON ; un workflow = un déclencheur clair ; test avec mock.
**OBS** : une alerte = un runbook ; métriques nommées `queenbee_*` ; logs JSON avec `trace_id` ; pas de PII.
**SEC/QA** : tester seulement en environnement de test ; preuves en annexe (rapports) ; un bug corrigé = un test de non-régression.
**SEO** : seulement la landing publique ; zones privées `noindex` ; pas de donnée inventée.
**DOSSIER** : prose argumentée, 1ʳᵉ personne pour les décisions, chaque affirmation technique suivie d'un « parce que » + renvoi annexe numérotée ; pas de tutoriel dans le corps ; limites assumées.

## 8. Skills Claude Code par zone (invoquer via l'outil Skill, caveman toujours actif)
| Zone | Skills |
|---|---|
| Toutes | `caveman`, `verification-before-completion`, `caveman-commit` |
| GOV / DOC | `engineering:documentation`, `writing-plans`, `engineering:architecture` |
| DESIGN | `brainstorming`, `frontend-design`, `taste-skill`, `ui-ux-pro-max`, `design:design-system`, `design:ux-copy`, `bencium-controlled-ux-designer` |
| MODEL | `engineering:system-design`, `artifact-diagramming` |
| INFRA / CI | `engineering:deploy-checklist`, `security-audit`, `systematic-debugging` |
| SIM | `test-driven-development`, `investigate-first` |
| DB | `migration`, `test-driven-development`, `engineering:architecture` |
| AUTH / SEC | `security-audit`, `security-review`, agent `security-auditor` |
| INGEST / EDGE | `test-driven-development`, `systematic-debugging`, `surgical-patch` |
| API | `test-driven-development`, `safe-refactor`, `engineering:testing-strategy` |
| MOBILE | `flutter-animations`, `mobile-native`, `design:accessibility-review`, `test-driven-development` |
| WEB | `react-best-practices`, `composition-patterns`, `web-design-guidelines`, `design:accessibility-review`, `dataviz` |
| N8N | `investigate-first`, `engineering:testing-strategy` |
| OBS | `engineering:incident-response`, `dataviz` |
| QA | `webapp-testing`, agent `qa-e2e`, `engineering:testing-strategy` |
| SEO | `seo-audit`, `schema`, `ai-seo`, agent `seo-auditor` |
| REVUE | `requesting-code-review`, `receiving-code-review`, `code-review`, `simplify`, agent `reviewer` |
| DOSSIER | `content-research-writer`, `copy-editing`, `markdown-to-pdf` |
| Fin de branche | `finishing-a-development-branch` |

Prompt de démarrage conseillé dans Claude Code : « Je prends KAN-xxx. Lis le ticket et `docs/jira/PLAYBOOK.md`. Invoque les skills listés. Écris d'abord le test E2E. Respecte le temps max. »

## 9. Gabarit de description d'un ticket
```
**Réf backlog** : T### · Epic : <nom> · Sprint : S## · Échéance : <date>
**Responsable** : <nom> · **Relecteur** : <nom> · **Temps max** : <n> h

## Objectif
## Détails à réaliser (étapes numérotées)
## Fichiers / endroits concernés
## Critères d'acceptation (cases à cocher)
## Test E2E / preuve à fournir
## Bonnes pratiques de cette tâche
## Skills Claude Code
## Branche / commit / PR (noms exacts)
## Dépendances
## Si bloqué
Voir docs/jira/PLAYBOOK.md §4 (time-box) et §6 (Definition of Done).
```
