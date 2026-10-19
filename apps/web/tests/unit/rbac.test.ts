import { describe, expect, it } from "vitest";
import { canAccess, isPrivatePath, ROLES } from "@/lib/rbac";

/**
 * Matrice rôle x URL (squelette). Premier test unitaire à compléter par le ticket EP-08/EP-03.
 * Le test E2E correspondant est dans tests/e2e/auth.spec.ts.
 */
describe("rbac", () => {
  it("expose les 4 rôles de l'enum SQL user_role", () => {
    expect(ROLES).toEqual(["beekeeper", "coordinator", "manager", "admin"]);
  });

  it("refuse l'accès à une zone protégée sans rôle", () => {
    expect(canAccess(null, "/admin/users")).toBe(false);
  });

  it("autorise le coordinateur sur /coordinator seulement", () => {
    expect(canAccess("coordinator", "/coordinator/planning")).toBe(true);
    expect(canAccess("coordinator", "/admin/users")).toBe(false);
    expect(canAccess("coordinator", "/manager")).toBe(false);
  });

  it("marque les zones privées comme non indexables", () => {
    expect(isPrivatePath("/login")).toBe(true);
    expect(isPrivatePath("/manager/compare")).toBe(true);
    expect(isPrivatePath("/")).toBe(false);
  });

  it.todo("TODO(KAN-xxx, EP-08) : couvrir toute la matrice 4 rôles x toutes les routes");
});
