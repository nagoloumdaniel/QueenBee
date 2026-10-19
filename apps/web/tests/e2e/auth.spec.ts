import { expect, test } from "@playwright/test";

/**
 * EP-03 / EP-08 : authentification et matrice d'accès par rôle (squelette).
 * `test.fixme` = test à écrire AVANT le code (TDD) par le ticket concerné, puis retirer fixme.
 */
test.describe("Accès sans session", () => {
  for (const path of ["/coordinator", "/manager", "/admin/users"]) {
    test(`${path} redirige vers /login`, async ({ page }) => {
      await page.goto(path);
      await expect(page).toHaveURL(/\/login/);
    });
  }
});

test.describe("Connexion", () => {
  test.fixme("login + MFA donne accès à l'accueil du rôle", async () => {
    // TODO(KAN-xxx, EP-03) : e-mail/mot de passe seed -> code TOTP -> redirection par rôle
  });

  test.fixme("5 mauvais mots de passe verrouillent le compte (message générique)", async () => {
    // TODO(KAN-xxx, EP-03)
  });

  test.fixme("un coordinateur est redirigé quand il ouvre /admin/users", async () => {
    // TODO(KAN-xxx, EP-08) : matrice complète rôle x URL
  });
});
