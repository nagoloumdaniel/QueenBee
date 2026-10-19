import { test } from "@playwright/test";

/** EP-08 - parcours administrateur (UC-AD01 + vues DevOps/Cyber). Squelette. */
test.describe("Administrateur", () => {
  test.fixme("crée un utilisateur et l'action est tracée dans l'audit", async () => {
    // TODO(KAN-xxx, EP-08) : /admin/users -> créer -> entrée visible dans GET /audit
  });

  test.fixme("modifie un seuil d'alerte pour un site", async () => {
    // TODO(KAN-xxx, EP-08) : /admin/thresholds -> enregistrer -> valeur persistée
  });

  test.fixme("voit les déploiements et les files de sync", async () => {
    // TODO(KAN-xxx, EP-08/EP-10) : /admin/devops affiche au moins un déploiement seedé
  });

  test.fixme("voit les événements d'intégrité", async () => {
    // TODO(KAN-xxx, EP-08/EP-04) : /admin/cyber liste un événement `replay` injecté par le simulateur
  });
});
