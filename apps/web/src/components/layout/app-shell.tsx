import Link from "next/link";
import type { ReactNode } from "react";
import { ROLES, type Role } from "@/lib/rbac";

type NavItem = { href: string; label: string };

/** Navigation par rôle. Libellés courts, en français simple. */
const NAV: Record<Role, NavItem[]> = {
  beekeeper: [],
  coordinator: [
    { href: "/coordinator", label: "Ruches à risque" },
    { href: "/coordinator/planning", label: "Planning des visites" },
    { href: "/coordinator/harvests", label: "Récoltes à valider" },
  ],
  manager: [
    { href: "/manager", label: "Indicateurs" },
    { href: "/manager/compare", label: "Comparer les sites" },
  ],
  admin: [
    { href: "/admin/users", label: "Utilisateurs" },
    { href: "/admin/thresholds", label: "Seuils d'alerte" },
    { href: "/admin/devops", label: "Déploiements" },
    { href: "/admin/cyber", label: "Sécurité" },
  ],
};

type Props = { role: Role | null; children: ReactNode };

/**
 * Cadre commun du dashboard privé : en-tête, navigation, zone principale.
 * La cible du lien d'évitement est `#contenu` (voir layout racine).
 * TODO(KAN-xxx, EP-08) : menu mobile, bannière hors-ligne, sélecteur de thème, déconnexion.
 */
export function AppShell({ role, children }: Props) {
  const items = role && ROLES.includes(role) ? NAV[role] : [];
  return (
    <div className="min-h-screen">
      <header className="border-b border-border bg-surface">
        <div className="mx-auto flex max-w-6xl flex-wrap items-center justify-between gap-4 px-4 py-3">
          <Link href="/" className="font-display text-xl font-semibold text-foreground no-underline">
            QueenBee
          </Link>
          {items.length > 0 ? (
            <nav aria-label="Navigation principale">
              <ul className="flex flex-wrap gap-2">
                {items.map((item) => (
                  <li key={item.href}>
                    <Link
                      href={item.href}
                      className="inline-flex min-h-12 items-center rounded-sm px-3 text-base"
                    >
                      {item.label}
                    </Link>
                  </li>
                ))}
              </ul>
            </nav>
          ) : null}
        </div>
      </header>
      <main id="contenu" className="mx-auto max-w-6xl px-4 py-8">
        {children}
      </main>
    </div>
  );
}
