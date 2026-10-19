## Quoi
<!-- Ce que fait cette PR, en 2-3 lignes. Titre de la PR = Conventional Commit : feat(ingest): rejette les trames rejouées (KAN-123) -->

Closes KAN-

## Pourquoi
<!-- Besoin / UC / epic (EP-xx). Lien vers le ticket Jira et l'ADR éventuel. -->

## Comment tester
<!-- Commandes exactes (make ..., npm ..., flutter ...) et résultat attendu. -->

## Preuves
<!-- Sortie du test E2E (obligatoire), tests unitaires/intégration, captures ou logs. Un screenshot seul ne prouve rien. -->
- [ ] Test E2E (ou intégration) vert en CI - lien :
- [ ] Tests unitaires verts
- [ ] Revue sécurité ciblée faite (authz côté serveur, validation des entrées, secrets, PII dans les logs)

## Risques et limites connues
<!-- Régressions possibles, migration (réversible ?), points non traités. -->

## Checklist (Definition of Done - docs/jira/PLAYBOOK.md §6)
- [ ] Branche nommée `<type>/EP-<nn>-<slug>`, commits Conventional Commits
- [ ] Critères d'acceptation du ticket cochés
- [ ] Lint / format / types OK ; Snyk et Gitleaks sans critique
- [ ] Documentation mise à jour (README, ADR, OpenAPI si concerné)
- [ ] UI : accessibilité vérifiée (`docs/accessibility/checklist.md`) ; états loading / erreur / vide / hors-ligne présents
- [ ] Aucun secret committé ; données personnelles minimisées
- [ ] Pas de `TODO` sans ticket ; pas de code mort
- [ ] Relecteur désigné (LH -> IG -> WA -> LH) ; **merge par LH uniquement, après accord**
