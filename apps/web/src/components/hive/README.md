# components/hive

Composants **métier ruche** réutilisés par les écrans coordinateur / gestionnaire.

- `hive-risk-badge.tsx` : pastille de risque (couleur + texte).

À créer (tickets WEB, EP-08) :
- `hive-table.tsx` : liste triée par risque, filtres site / risque (UC-C01) ;
- `hive-map.tsx` : carte Leaflet + OpenStreetMap, marqueurs par risque (client component, import dynamique `ssr: false`) ;
- `visit-plan-form.tsx` : planifier une visite (assignation d'un apiculteur).

Règles : les types viennent de `src/lib/api-types.gen.ts` (généré depuis `docs/openapi.yaml`) ; pas d'appel `fetch` direct (utiliser `src/lib/api-client.ts`) ; aucune donnée personnelle dans les logs.
