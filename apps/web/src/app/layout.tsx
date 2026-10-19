import type { Metadata, Viewport } from "next";
import { Fraunces, Inter } from "next/font/google";
import type { ReactNode } from "react";
import "./globals.css";

// Typo QueenBee : Inter (UI) + Fraunces (titres). Chargées via next/font (auto-hébergées).
const inter = Inter({ subsets: ["latin"], variable: "--font-inter", display: "swap" });
const fraunces = Fraunces({ subsets: ["latin"], variable: "--font-fraunces", display: "swap" });

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000";

/**
 * Metadata par défaut. Les zones privées (groupe `(app)`) surchargent `robots`
 * en noindex ; la landing `(public)` définit sa propre metadata complète.
 */
export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  title: { default: "QueenBee", template: "%s | QueenBee" },
  applicationName: "QueenBee",
};

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  themeColor: [
    { media: "(prefers-color-scheme: light)", color: "#FBF5E6" },
    { media: "(prefers-color-scheme: dark)", color: "#1F1610" },
  ],
};

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="fr" className={`${inter.variable} ${fraunces.variable}`}>
      <body className="min-h-screen antialiased">
        {/* Lien d'évitement (WCAG 2.4.1) : cible = <main id="contenu"> de chaque page */}
        <a href="#contenu" className="skip-link">
          Aller au contenu principal
        </a>
        {children}
      </body>
    </html>
  );
}
