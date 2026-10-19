import { test } from "@playwright/test";

/** EP-08 - parcours gestionnaire (UC-G01, UC-G02). Squelette. */
test.describe("Gestionnaire", () => {
  test.fixme("consulte les KPIs consolidés", async () => {
    // TODO(KAN-xxx, EP-08) : loginAs(page, "manager"); /manager affiche les cartes KPI
  });

  test.fixme("compare plusieurs sites", async () => {
    // TODO(KAN-xxx, EP-08) : /manager/compare -> sélectionner 2 sites -> tableau comparatif
  });

  test.fixme("exporte le rapport bailleur en PDF", async () => {
    // TODO(KAN-xxx, EP-08/EP-06) : POST /reports -> attendre le téléchargement -> type PDF
  });
});
