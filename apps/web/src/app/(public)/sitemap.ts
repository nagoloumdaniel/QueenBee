import type { MetadataRoute } from "next";

/**
 * sitemap.xml : uniquement les pages publiques indexables (la landing).
 * Les zones privées n'y figurent JAMAIS. Ajouter ici toute nouvelle page publique (ex. /en).
 * TODO(KAN-xxx, EP-12) : `lastModified` réel (date de build) et entrées hreflang.
 */
export default function sitemap(): MetadataRoute.Sitemap {
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000";
  return [{ url: `${siteUrl}/`, changeFrequency: "monthly", priority: 1 }];
}
