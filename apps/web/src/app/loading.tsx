// État de chargement racine (Suspense). Annoncé aux lecteurs d'écran (role="status").
export default function Loading() {
  return (
    <main id="contenu" className="mx-auto max-w-xl px-4 py-16 text-center">
      <p role="status" aria-live="polite" className="text-base text-muted">
        Chargement en cours…
      </p>
    </main>
  );
}
