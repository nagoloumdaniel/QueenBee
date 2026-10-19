/**
 * RBAC côté web : 4 rôles (enum SQL `user_role`, ROADMAP §4.9).
 *
 * ATTENTION : ceci est un confort d'interface (redirections, menu).
 * Ce N'EST PAS une frontière de sécurité. L'autorisation réelle est faite
 * côté serveur par l'API (RBAC + RLS PostgreSQL) à chaque requête.
 * TODO(KAN-xxx, EP-03/EP-08) : test unitaire de la matrice (tests/unit/rbac.test.ts).
 */
export const ROLES = ["beekeeper", "coordinator", "manager", "admin"] as const;
export type Role = (typeof ROLES)[number];

export function isRole(value: unknown): value is Role {
  return typeof value === "string" && (ROLES as readonly string[]).includes(value);
}

/** Zones privées du dashboard web et rôles autorisés (plus long préfixe d'abord). */
export const ROUTE_RULES: ReadonlyArray<{ prefix: string; roles: readonly Role[] }> = [
  { prefix: "/admin", roles: ["admin"] },
  { prefix: "/manager", roles: ["manager", "admin"] },
  { prefix: "/coordinator", roles: ["coordinator", "admin"] },
];

/** Préfixes qui ne doivent jamais être indexés (noindex + robots Disallow). */
export const PRIVATE_PREFIXES = ["/login", "/coordinator", "/manager", "/admin"] as const;

/** Page d'accueil par rôle après connexion. L'apiculteur utilise l'app mobile, pas le web. */
export const ROLE_HOME: Record<Role, string> = {
  beekeeper: "/login?error=mobile_only",
  coordinator: "/coordinator",
  manager: "/manager",
  admin: "/admin/users",
};

export function isPrivatePath(pathname: string): boolean {
  return PRIVATE_PREFIXES.some((p) => pathname === p || pathname.startsWith(`${p}/`));
}

/** Vrai si `role` peut ouvrir `pathname`. Refus par défaut pour une zone protégée. */
export function canAccess(role: Role | null, pathname: string): boolean {
  const rule = ROUTE_RULES.find((r) => pathname === r.prefix || pathname.startsWith(`${r.prefix}/`));
  if (!rule) return true; // chemin public ou /login
  return role !== null && rule.roles.includes(role);
}
