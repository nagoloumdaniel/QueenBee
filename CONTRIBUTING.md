# Contribuer à QueenBee

Résumé des règles. **La référence complète est [docs/jira/PLAYBOOK.md](docs/jira/PLAYBOOK.md)** (équipe, nommage, time-box, cycle d'un ticket, Definition of Done, bonnes pratiques par domaine).

## Cycle d'un ticket (extrait)
1. Lire le ticket Jira (KAN-xxx) et le PLAYBOOK ; poser les questions **avant** de coder.
2. `git switch main && git pull && git switch -c <type>/EP-<nn>-<slug>`.
3. Écrire le **test E2E** (ou d'intégration) : il doit échouer. Coder au plus petit nécessaire jusqu'au vert.
4. Lint + tests locaux (`make lint`, `make test`). Relire son diff (`git diff main`) : pas de secret, pas de code mort, pas de TODO sans ticket.
5. Commit, push, PR, relecteur désigné. Corriger les retours. Merge **par LH uniquement**, après accord.

## Branches
- Jamais de commit direct sur `main` ni `phase/*` ; pas de force-push.
- Format : `<type>/EP-<nn>-<slug>` - types `feat|fix|refactor|test|docs|chore|ci` ; slug minuscule, tirets, sans accent, <= 40 caractères ; exemple `feat/EP-04-migration-site-country`.
- Phase : `phase/<nn>-<slug>` ; hotfix : `hotfix/<slug>` (depuis `main`, PR directe). Une branche = un ticket ; durée de vie <= 3 jours ; rebase fréquent.

## Commits
Conventional Commits, impératif, <= 72 caractères, avec le ticket :
```
feat(db): ajoute la migration site et country (KAN-123)
fix(ingest): rejette les trames rejouées (KAN-140)
docs(adr): documente le choix du bridge MQTT (KAN-98)
```
Types : `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `ci`, `perf`.

## Pull requests
- Modèle : `.github/pull_request_template.md` (Quoi / Pourquoi / Comment tester / Preuves / Risques ; `Closes KAN-123`).
- Contenu : description, tests exécutés (unitaire + intégration + **E2E**), preuves (logs/captures), revue sécurité, limites connues.
- Stratégie : squash pour les features, merge commit pour les PR de phase. Branche supprimée après merge.
- Relecteur : LH -> IG -> WA -> LH. Un propriétaire de zone est défini dans `.github/CODEOWNERS`.

## Definition of Done (tous tickets)
- [ ] Critères d'acceptation du ticket cochés.
- [ ] Test E2E (ou intégration) vert en CI, sortie jointe à la PR.
- [ ] Lint, format et types OK ; Snyk / Gitleaks sans critique.
- [ ] Documentation mise à jour (README, ADR, OpenAPI si concerné).
- [ ] Accessibilité vérifiée si UI ; états loading / erreur / vide / hors-ligne présents.
- [ ] Aucun secret committé ; données personnelles minimisées.
- [ ] Branche nommée selon les règles ; PR relue.

## Normes de code
- **Python** : ruff + mypy strict, black (longueur 120), couches `routers/ services/ repositories/ schemas/`, injection de dépendances FastAPI, pas de SQL dans les routers. Fichiers `snake_case.py`, migrations `NNNN_slug.py`.
- **TypeScript** : `strict`, ESLint, Prettier, composants serveur par défaut. Fichiers `kebab-case.tsx`.
- **Dart** : `very_good_analysis`, Riverpod, repository pattern, `dart format`. Fichiers `snake_case.dart`.
- Logs JSON structurés avec `trace_id`, sans PII. Config par variables d'environnement (12-factor).
- Textes et commentaires en **français**, identifiants en **anglais**.

## Hooks locaux
```bash
pip install pre-commit && pre-commit install
```
Hooks : ruff, black, gitleaks, prettier, end-of-file-fixer, trailing-whitespace, check-yaml.

## Temps et blocages
Chaque ticket a un temps max. À 80 % sans avancée : commenter. À 100 % : STOP, pousser la branche WIP en PR draft et passer le ticket en « bloqué » ou le découper.

## Sécurité
Ne jamais committer de secret. Pour signaler une vulnérabilité : voir [SECURITY.md](SECURITY.md).
