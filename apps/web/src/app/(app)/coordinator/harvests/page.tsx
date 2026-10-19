import type { Metadata } from "next";
import { StateBlock } from "@/components/ui/state-block";

/**
 * Coordinateur - validation des récoltes (UC-C02, EP-08).
 *
 * Données : GET /harvests?status=declared puis POST /harvests/{id}/validate.
 * Affichage clé : volume déclaré vs prévu (`predicted_kg`), écart en % (`gap_pct`),
 * statut (declared | validated | flagged). Un écart important => statut "flagged" + motif.
 * États à dessiner : loading, erreur, vide ("Aucune récolte en attente"), hors-ligne.
 * Accessibilité : actions Valider / Signaler = vrais boutons avec nom explicite
 * ("Valider la récolte de la ruche SN-CASA-014"), confirmation annoncée (aria-live).
 *
 * TODO(KAN-xxx, EP-08) : tableau des récoltes + actions de validation.
 */
export const metadata: Metadata = { title: "Récoltes à valider" };

export default function CoordinatorHarvestsPage() {
  return (
    <>
      <h1 className="text-3xl font-semibold">Récoltes à valider</h1>
      <p className="mt-2 text-base text-muted">
        Vérifiez les récoltes déclarées par les apiculteurs et validez-les.
      </p>
      <StateBlock
        className="mt-6"
        kind="empty"
        title="Aucune récolte en attente"
        hint="TODO(KAN-xxx, EP-08) : brancher /harvests."
      />
    </>
  );
}
