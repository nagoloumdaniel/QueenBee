# components/layout

Cadres de page partagés par le dashboard privé.

- `app-shell.tsx` : en-tête + navigation par rôle + `<main id="contenu">`.

À ajouter (voir tickets WEB) : bannière hors-ligne, menu mobile, sélecteur de thème clair/sombre, pied de page de la landing.

Règles : la navigation est un `<nav aria-label>` ; chaque lien est une cible >= 48 px ; un seul `<main>` par page ; le lien d'évitement (`#contenu`) est dans `src/app/layout.tsx`.
