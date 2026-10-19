import type { MetadataRoute } from "next";
import { PRIVATE_PREFIXES } from "@/lib/rbac";

/**
 * robots.txt : la landing est indexable, toutes les zones privées sont en Disallow
 * (en plus du noindex posé par src/middleware.ts). ROADMAP §6.4.
 *
 * NOTE : un fichier `robots.ts` dans un groupe de routes `(public)` est servi à
 * /robots.txt. Si ce n'est pas le cas avec la version de Next retenue, le déplacer
 * dans `src/app/` (même contenu). Vérifié par tests/e2e/landing.spec.ts.
 */
export default function robots(): MetadataRoute.Robots {
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000";
  return {
    // Disallow est une correspondance de préfixe : "/admin" couvre aussi "/admin/users".
    rules: [{ userAgent: "*", allow: "/", disallow: [...PRIVATE_PREFIXES] }],
    sitemap: `${siteUrl}/sitemap.xml`,
  };
}
