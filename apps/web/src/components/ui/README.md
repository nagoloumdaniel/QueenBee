# components/ui

Briques d'interface génériques, au format **shadcn/ui** (composants copiés dans le dépôt, basés sur Radix = accessibles).

## Contenu actuel
- `button.tsx` : bouton (cible >= 48 px, variantes via `cva`).
- `state-block.tsx` : affichage standard des états `loading | error | empty | offline`.

## Ajouter un composant shadcn
```bash
npx shadcn@latest add dialog   # écrit dans src/components/ui (voir components.json)
```
Ensuite : remplacer toute couleur codée en dur par un token (`bg-primary`, `text-muted`...), vérifier le focus visible et le nom accessible.

## Règles
- Aucune logique métier ici (pas d'appel API) : composants purs, réutilisables.
- Server Component par défaut ; `"use client"` seulement si état/événement nécessaire.
- Pas de couleur hexadécimale : uniquement les tokens de `src/app/globals.css`.
- Chaque composant interactif : nom accessible, utilisable au clavier, test Vitest (`*.test.tsx`).

TODO(KAN-xxx, EP-08) : ajouter input, label, select, dialog, table, toast (Sonner) selon les écrans.
