# Tests E2E (API)

Ici : parcours complets contre la stack `infra/compose/e2e.yml` (API + base + broker + simulateur),
p. ex. alerte -> plan de visite -> inspection -> récolte -> validation (ROADMAP §5.4b, EP-06).
Contrat : `schemathesis run http://localhost:8000/api/v1/openapi.json` (aucun 500 toléré).

Marqueur : `@pytest.mark.e2e`. Règle : pas de tâche « Done » sans test E2E (ROADMAP §5.4b).
