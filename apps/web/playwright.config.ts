import { defineConfig, devices } from "@playwright/test";

/**
 * E2E web (ROADMAP §5.4b : un test E2E par tâche, en CI à chaque PR).
 * Par défaut : l'app tourne via `npm run dev`. En CI, la stack Compose
 * (infra/compose/e2e.yml) fournit l'API et le simulateur, et BASE_URL
 * pointe vers l'app déjà démarrée.
 */
const baseURL = process.env.BASE_URL ?? "http://localhost:3000";

export default defineConfig({
  testDir: "./tests/e2e",
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  reporter: [["html", { open: "never" }], ["list"]],
  use: {
    baseURL,
    trace: "on-first-retry",
    video: "retain-on-failure",
    screenshot: "only-on-failure",
    locale: "fr-FR",
  },
  projects: [
    { name: "chromium", use: { ...devices["Desktop Chrome"] } },
    { name: "mobile-chrome", use: { ...devices["Pixel 7"] } },
  ],
  webServer: process.env.BASE_URL
    ? undefined
    : {
        command: "npm run dev",
        url: baseURL,
        reuseExistingServer: !process.env.CI,
        timeout: 120_000,
      },
});
