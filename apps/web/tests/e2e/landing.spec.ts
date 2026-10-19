import AxeBuilder from "@axe-core/playwright";
import { expect, test } from "@playwright/test";
import { collectConsoleErrors } from "./helpers";

/**
 * EP-12 Landing SEO (ROADMAP §5.4b). Ces tests ne nécessitent PAS l'API : ils peuvent
 * tourner dès maintenant. À compléter : Lighthouse CI (LCP <= 2,5 s) dans la CI.
 */
test.describe("Landing publique", () => {
  test("a un titre, une description, un canonical, un seul h1 et aucune erreur console", async ({
    page,
  }) => {
    const errors = collectConsoleErrors(page);
    await page.goto("/");
    await expect(page).toHaveTitle(/QueenBee/);
    await expect(page.locator('meta[name="description"]')).toHaveAttribute("content", /.+/);
    await expect(page.locator('link[rel="canonical"]')).toHaveCount(1);
    await expect(page.getByRole("heading", { level: 1 })).toHaveCount(1);
    await expect(page.locator('script[type="application/ld+json"]')).toHaveCount(1);
    expect(errors, "erreurs console").toEqual([]);
  });

  test("n'a aucune violation d'accessibilité critique (axe-core)", async ({ page }) => {
    await page.goto("/");
    const results = await new AxeBuilder({ page })
      .withTags(["wcag2a", "wcag2aa", "wcag22aa"])
      .analyze();
    expect(results.violations.filter((v) => v.impact === "critical")).toEqual([]);
  });

  test("robots.txt interdit les zones privées et sitemap.xml ne contient que la landing", async ({
    request,
  }) => {
    const robots = await (await request.get("/robots.txt")).text();
    for (const path of ["/admin", "/manager", "/coordinator", "/login"]) {
      expect(robots).toContain(`Disallow: ${path}`);
    }
    const sitemap = await (await request.get("/sitemap.xml")).text();
    expect(sitemap).not.toMatch(/admin|manager|coordinator|login/);
  });

  test("renvoie une vraie 404 pour une page inconnue", async ({ page }) => {
    const response = await page.goto("/cette-page-n-existe-pas");
    expect(response?.status()).toBe(404);
    await expect(page.getByRole("heading", { name: "Page introuvable" })).toBeVisible();
  });

  test("les zones privées sont en noindex", async ({ request }) => {
    const res = await request.get("/login");
    expect(res.headers()["x-robots-tag"]).toContain("noindex");
  });
});
