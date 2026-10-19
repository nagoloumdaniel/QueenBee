import type { Metadata } from "next";
import { StateBlock } from "@/components/ui/state-block";

/**
 * Coordinateur - accueil : ruches triées par risque + carte (UC-C01, EP-08).
 *
 * Données : GET /hives?risk=...&site=...&bbox=... et GET /alerts (docs/openapi.yaml).
 * Composants à utiliser : components/hive (table, carte, pastille de risque).
 * États à dessiner :
 *  - loading : squelette de tableau ;  - erreur : StateBlock error + bouton Réessayer ;
 *  - vide : "Aucune ruche à risque" (bonne nouvelle, texte rassurant) ;  - hors-ligne : dernières données + date.
 * Accessibilité : tableau avec <caption>, tri annoncé (aria-sort), carte doublée d'une liste.
 *
 * TODO(KAN-xxx, EP-08) : Server Component qui charge la liste ; carte en composant client.
 */
export const metadata: Metadata = { title: "Ruches à risque" };

export default function CoordinatorHomePage() {
  return (
    <>
      <h1 className="text-3xl font-semibold">Ruches à risque</h1>
      <p className="mt-2 text-base text-muted">
        Les ruches qui demandent une visite en priorité, des plus urgentes aux moins urgentes.
      </p>
      <StateBlock
        className="mt-6"
        kind="empty"
        hint="TODO(KAN-xxx, EP-08) : brancher la liste des ruches triée par risque."
      />
    </>
  );
}
