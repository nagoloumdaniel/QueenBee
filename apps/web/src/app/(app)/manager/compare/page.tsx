import type { Metadata } from "next";
import { StateBlock } from "@/components/ui/state-block";

/**
 * Gestionnaire - comparaison de sites (UC-G01, EP-08).
 *
 * Données : GET /sites, GET /sites/{id}/summary, GET /analytics/kpis?site=...
 * Parcours : cocher 2 à 8 sites -> tableau + graphique comparatif sur une période.
 * États à dessiner : loading, erreur partielle (un site en échec n'efface pas les autres),
 * vide ("Choisissez au moins deux sites"), hors-ligne.
 * Accessibilité : sélection par cases à cocher libellées, résultats annoncés (aria-live polite).
 *
 * TODO(KAN-xxx, EP-08) : sélecteur de sites + comparatif.
 */
export const metadata: Metadata = { title: "Comparer les sites" };

export default function ManagerComparePage() {
  return (
    <>
      <h1 className="text-3xl font-semibold">Comparer les sites</h1>
      <p className="mt-2 text-base text-muted">Comparez la production et la santé des ruches entre sites.</p>
      <StateBlock
        className="mt-6"
        kind="empty"
        title="Choisissez au moins deux sites"
        hint="TODO(KAN-xxx, EP-08) : brancher /sites et /analytics/kpis."
      />
    </>
  );
}
