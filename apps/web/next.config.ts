import type { NextConfig } from "next";

/**
 * Configuration Next.js de QueenBee web.
 *
 * - `output: "standalone"` : image Docker minimale (voir Dockerfile).
 * - En-têtes de sécurité communs. Le `X-Robots-Tag: noindex` des zones privées
 *   est posé dans src/middleware.ts (il dépend du chemin).
 * - TODO(KAN-xxx, EP-08/SEC) : durcir la CSP (nonce par requête) une fois les
 *   dépendances cartographiques (Leaflet/OSM) intégrées.
 */
const securityHeaders = [
  { key: "X-Content-Type-Options", value: "nosniff" },
  { key: "X-Frame-Options", value: "DENY" },
  { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
  {
    key: "Permissions-Policy",
    value: "camera=(), microphone=(), geolocation=(self)",
  },
  {
    key: "Strict-Transport-Security",
    value: "max-age=63072000; includeSubDomains",
  },
];

const nextConfig: NextConfig = {
  output: "standalone",
  poweredByHeader: false,
  reactStrictMode: true,
  async headers() {
    return [{ source: "/:path*", headers: securityHeaders }];
  },
};

export default nextConfig;
