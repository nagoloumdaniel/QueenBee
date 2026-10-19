import Link from "next/link";

// Page 404 propre (statut HTTP 404 posé par Next). Testée dans tests/e2e/landing.spec.ts.
export default function NotFound() {
  return (
    <main id="contenu" className="mx-auto max-w-xl px-4 py-16 text-center">
      <h1 className="text-5xl font-semibold">Page introuvable</h1>
      <p className="mt-4 text-base text-muted">
        Cette adresse n&apos;existe pas ou a été déplacée.
      </p>
      <Link
        href="/"
        className="mt-8 inline-flex min-h-12 items-center rounded-sm bg-primary px-6 font-medium text-primary-foreground"
      >
        Retour à l&apos;accueil
      </Link>
    </main>
  );
}
