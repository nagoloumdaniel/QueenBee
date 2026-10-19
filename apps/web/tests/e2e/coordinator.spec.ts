import { test } from "@playwright/test";

/**
 * EP-08 - parcours coordinateur (UC-C01, UC-C02). Squelette : stack Compose + simulateur requis.
 * Critère E2E de l'epic : login coordinateur -> ruches triées par risque -> planifier une visite.
 */
test.describe("Coordinateur", () => {
  test.fixme("voit les ruches triées par risque décroissant", async () => {
    // TODO(KAN-xxx, EP-08) : loginAs(page, "coordinator"); vérifier l'ordre critique > attention > normal
  });

  test.fixme("planifie une visite pour une ruche à risque", async () => {
    // TODO(KAN-xxx, EP-08) : /coordinator/planning -> formulaire -> la visite apparaît dans la liste
  });

  test.fixme("valide une récolte déclarée", async () => {
    // TODO(KAN-xxx, EP-08) : /coordinator/harvests -> Valider -> statut "validated"
  });

  test.fixme("n'affiche aucune erreur console et 0 violation axe critique", async () => {
    // TODO(KAN-xxx, EP-08) : collectConsoleErrors + AxeBuilder sur chaque page du rôle
  });
});
