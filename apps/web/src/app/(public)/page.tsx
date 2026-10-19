import type { Metadata } from "next";
import Link from "next/link";

/**
 * Landing publique BeeAfrica / QueenBee - SEULE page indexable du site (ROADMAP §6.4, EP-12).
 *
 * Contraintes SEO (à vérifier par tests/e2e/landing.spec.ts + Lighthouse CI) :
 *  - SSG (aucune donnée dynamique, aucun appel API) ;
 *  - un seul <h1> ; title/description uniques ; canonical ; Open Graph ; JSON-LD fidèle au
 *    contenu visible ;
 *  - LCP <= 2,5 s, INP <= 200 ms, CLS <= 0,1 ; budget <= 200 Ko de JS ;
 *  - AUCUNE donnée, avis ou chiffre inventé : tout chiffre vient du cahier des charges.
 *
 * TODO(KAN-xxx, EP-12) : rédiger le contenu définitif (validé par BeeAfrica), ajouter l'image
 * Open Graph (src/app/opengraph-image.png), les `alt` d'images, la section "Contact".
 */
export const dynamic = "force-static";

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000";
const TITLE = "QueenBee - suivi de ruches connectées pour les apiculteurs africains";
const DESCRIPTION =
  "QueenBee aide l'association BeeAfrica et ses coopératives à suivre l'état des ruches, même sans connexion, et à intervenir plus tôt.";

export const metadata: Metadata = {
  title: { absolute: TITLE },
  description: DESCRIPTION,
  alternates: {
    canonical: "/",
    // TODO(KAN-xxx, EP-12) : ajouter `en: "/en"` quand la version anglaise existera.
    languages: { fr: "/", "x-default": "/" },
  },
  robots: { index: true, follow: true },
  openGraph: {
    type: "website",
    locale: "fr_FR",
    url: "/",
    siteName: "QueenBee",
    title: TITLE,
    description: DESCRIPTION,
    // images : fournies par src/app/opengraph-image.png (TODO ticket EP-12)
  },
  twitter: { card: "summary_large_image", title: TITLE, description: DESCRIPTION },
};

// JSON-LD Organization : doit refléter exactement le contenu visible ci-dessous.
const jsonLd = {
  "@context": "https://schema.org",
  "@type": "Organization",
  name: "BeeAfrica",
  description: DESCRIPTION,
  url: siteUrl,
};

export default function LandingPage() {
  return (
    <main id="contenu">
      <script
        type="application/ld+json"
        // Contenu statique maîtrisé (aucune entrée utilisateur) : sérialisation sûre.
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd).replace(/</g, "\\u003c") }}
      />

      <section className="mx-auto max-w-4xl px-4 py-16">
        <h1 className="text-5xl font-semibold">
          Des ruches suivies de près, même sans réseau
        </h1>
        <p className="mt-6 max-w-2xl text-xl">
          QueenBee permet aux apiculteurs des coopératives de BeeAfrica de noter leurs visites
          sur le terrain, de recevoir des alertes et de déclarer leurs récoltes, puis de tout
          synchroniser dès que le réseau revient.
        </p>
        <div className="mt-8">
          <Link
            href="/login"
            className="inline-flex min-h-12 items-center rounded-sm bg-primary px-6 font-medium text-primary-foreground no-underline"
          >
            Accéder à mon espace
          </Link>
        </div>
      </section>

      <section aria-labelledby="titre-fonctions" className="mx-auto max-w-4xl px-4 pb-16">
        <h2 id="titre-fonctions" className="text-3xl font-semibold">
          Ce que fait QueenBee
        </h2>
        {/* TODO(KAN-xxx, EP-12) : 3 à 4 fonctions avec pictogramme + texte court, vérifiées avec BeeAfrica */}
        <ul className="mt-6 grid gap-4 sm:grid-cols-3">
          <li className="rounded-lg bg-surface p-6 shadow-card">
            <h3 className="text-xl font-medium">Visites hors ligne</h3>
            <p className="mt-2 text-base text-muted">
              Saisie des inspections sans connexion, envoi automatique ensuite.
            </p>
          </li>
          <li className="rounded-lg bg-surface p-6 shadow-card">
            <h3 className="text-xl font-medium">Alertes utiles</h3>
            <p className="mt-2 text-base text-muted">
              Les colonies fragiles sont repérées plus tôt pour mieux planifier les visites.
            </p>
          </li>
          <li className="rounded-lg bg-surface p-6 shadow-card">
            <h3 className="text-xl font-medium">Récoltes suivies</h3>
            <p className="mt-2 text-base text-muted">
              Déclaration simple, validation par le coordinateur, rapports pour les bailleurs.
            </p>
          </li>
        </ul>
      </section>

      <footer className="border-t border-border">
        <p className="mx-auto max-w-4xl px-4 py-6 text-sm text-muted">
          BeeAfrica - QueenBee. Projet pédagogique INGETIS. {/* TODO(KAN-xxx) mentions légales */}
        </p>
      </footer>
    </main>
  );
}
