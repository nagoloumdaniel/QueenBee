# apps/web - Dashboard et landing QueenBee

Application **Next.js 15 (App Router) + TypeScript strict + Tailwind + shadcn/ui**.
Elle contient :

- une **landing publique** (SSG, seule page indexable) : `src/app/(public)` ;
- un **dashboard privé** pour 3 rôles : coordinateur, gestionnaire, administrateur : `src/app/(app)`.
  (L'apiculteur utilise l'app mobile, voir `apps/mobile`.)

Tickets liés : epic **EP-08** (dashboard) et **EP-12** (landing SEO). Règles communes : `docs/jira/PLAYBOOK.md`.

## Démarrer en local
```bash
cd apps/web
npm ci                       # installe les dépendances (verrouillées par package-lock.json)
cp .env.example .env.local   # noms de variables ; aucune valeur secrète
npm run dev                  # http://localhost:3000
```
Commandes : `npm run lint` · `npm run typecheck` · `npm test` (Vitest) · `npm run e2e` (Playwright) · `npm run gen:api` (types depuis `docs/openapi.yaml`).

> Le `package-lock.json` n'existe pas encore : il sera créé au premier `npm install` (à committer).
> Les versions de `package.json` sont épinglées ; vérifier avec `npm audit` avant de les monter.

## Carte des dossiers
| Dossier | Rôle |
|---|---|
| `src/app/(public)` | Landing, `robots.ts`, `sitemap.ts` (indexables) |
| `src/app/(app)` | Zones privées : `login`, `coordinator/`, `manager/`, `admin/` (toujours `noindex`) |
| `src/app/globals.css` | **Tokens de design** (couleurs, espacement, mode sombre) : source unique |
| `src/components/ui` | Briques génériques (shadcn/ui) |
| `src/components/layout` | Cadres de page, navigation |
| `src/components/hive` | Composants métier ruche |
| `src/components/charts` | Graphiques (Recharts) |
| `src/lib/api-client.ts` | Client HTTP typé, erreurs RFC 9457 |
| `src/lib/auth.ts` | Lecture de session (cookie httpOnly) |
| `src/lib/rbac.ts` | Rôles et matrice d'accès d'interface |
| `src/middleware.ts` | Redirections par rôle + `X-Robots-Tag: noindex` sur les zones privées |
| `tests/unit` | Vitest |
| `tests/e2e` | Playwright (un fichier par rôle + landing + auth) |

## Comment remplir une page squelette
1. Lire le commentaire en tête du fichier `page.tsx` : il liste l'endpoint, les états à dessiner et les points d'accessibilité.
2. Écrire d'abord le test E2E dans `tests/e2e/` (retirer `test.fixme`).
3. Server Component par défaut ; `"use client"` seulement pour l'interactivité (carte, formulaire).
4. Types depuis `src/lib/api-types.gen.ts` (généré) ; appels via `api-client.ts`.
5. Dessiner **loading / erreur / vide / hors-ligne** (composant `StateBlock`).
6. Couleurs = tokens uniquement. Pas de `#hex` dans les composants.

## Normes
- TypeScript `strict` + `noUncheckedIndexedAccess` ; ESLint (`next/core-web-vitals`, `jsx-a11y`) ; Prettier.
- Fichiers en `kebab-case.tsx`. Identifiants en anglais, textes d'interface en français simple.
- Accessibilité WCAG 2.2 AA / RGAA 4.1 : labels, focus visible, clavier complet, cibles >= 48 px, `prefers-reduced-motion`, axe-core sans violation critique. Voir `docs/accessibility/checklist.md`.
- Budget : <= 200 Ko de JS sur la landing ; LCP <= 2,5 s. Voir `docs/eco-conception/checklist.md`.
- Sécurité : aucun jeton dans `localStorage` ; le middleware n'est PAS une frontière de sécurité (l'API autorise). Voir `docs/security/asvs-checklist.md`.

## Docker
```bash
docker build -t queenbee-web --build-arg NEXT_PUBLIC_API_URL=http://localhost:8000/api/v1 .
```
Image multi-étapes, mode `standalone`, utilisateur non-root.

## Points à connaître
- `src/app/(public)/robots.ts` : si `/robots.txt` n'est pas servi depuis le groupe de routes, déplacer le fichier dans `src/app/` (le test `landing.spec.ts` le détecte).
- `thresholds` et `cyber` utilisent des endpoints **non encore définis** dans `docs/openapi.yaml` : à définir avec le ticket API avant de coder ces écrans.
