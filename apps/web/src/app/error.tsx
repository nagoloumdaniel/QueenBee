"use client";

import { useEffect } from "react";

/**
 * Erreur non gérée (frontière d'erreur racine).
 * Ne jamais afficher le message technique ni de donnée personnelle à l'écran.
 * TODO(KAN-xxx, OBS) : envoyer `error.digest` au journal (trace_id) côté serveur.
 */
export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    console.error("Erreur UI", error.digest);
  }, [error]);

  return (
    <main id="contenu" className="mx-auto max-w-xl px-4 py-16 text-center">
      <h1 className="text-3xl font-semibold">Un problème est survenu</h1>
      <p role="alert" className="mt-4 text-base text-muted">
        Nous n&apos;avons pas pu afficher cette page. Vos données ne sont pas perdues.
      </p>
      <button
        type="button"
        onClick={reset}
        className="mt-8 min-h-12 rounded-sm bg-primary px-6 font-medium text-primary-foreground"
      >
        Réessayer
      </button>
    </main>
  );
}
