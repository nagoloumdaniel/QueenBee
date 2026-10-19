import type { Page } from "@playwright/test";

/**
 * Aides E2E partagées.
 *
 * `loginAs` : à implémenter par le ticket EP-03/EP-08. Deux options :
 *  (a) passer par l'UI (/login + code TOTP de test) ;
 *  (b) plus rapide : poser un cookie de session signé par l'API de test (stack Compose e2e).
 * Les comptes de test viennent des seeds (db/seeds) - jamais de vrai mot de passe dans le dépôt.
 */
export type TestRole = "coordinator" | "manager" | "admin";

export async function loginAs(_page: Page, _role: TestRole): Promise<void> {
  throw new Error("TODO(KAN-xxx, EP-08) : implémenter loginAs avec les comptes de seed");
}

/** Collecte les erreurs console : la DoD exige 0 erreur console (ROADMAP §5.4b). */
export function collectConsoleErrors(page: Page): string[] {
  const errors: string[] = [];
  page.on("console", (msg) => {
    if (msg.type() === "error") errors.push(msg.text());
  });
  page.on("pageerror", (err) => errors.push(err.message));
  return errors;
}
