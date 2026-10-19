# components/charts

Graphiques du dashboard (bibliothèque : **Recharts**, déjà dans `package.json`).

À créer (tickets WEB, EP-08) :
- `weight-trend-chart.tsx` : poids d'une ruche sur 7 jours (agrégat `measurement_hourly`) ;
- `site-comparison-chart.tsx` : comparaison de sites (UC-G01) ;
- `kpi-card.tsx` : indicateur chiffré + évolution.

Règles d'accessibilité et de lisibilité :
- Un graphique n'est jamais la seule source d'information : fournir un **tableau de données** équivalent (`<table>`) ou un résumé texte (`aria-describedby`).
- Ne pas coder l'information par la couleur seule (motifs, étiquettes).
- Couleurs = tokens (`var(--qb-*)`), contrastes >= 3:1 pour les éléments graphiques.
- Respecter `prefers-reduced-motion` (désactiver les animations Recharts : `isAnimationActive={false}`).
- Composants client (`"use client"`) chargés à la demande pour tenir le budget **<= 200 Ko de JS** (ROADMAP §4.6).
