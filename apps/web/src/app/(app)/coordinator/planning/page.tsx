import type { Metadata } from "next";
import { StateBlock } from "@/components/ui/state-block";

/**
 * Coordinateur - planning des visites (UC-C01, EP-08).
 *
 * Données : GET/POST /visit-plans (docs/openapi.yaml). POST avec en-tête Idempotency-Key.
 * Parcours : choisir une ruche à risque -> assigner un apiculteur -> date -> enregistrer.
 * États à dessiner : loading, erreur (échec d'enregistrement : garder le formulaire rempli),
 * vide ("Aucune visite planifiée"), hors-ligne (planification désactivée avec explication).
 * Accessibilité : formulaire avec labels, erreurs reliées par aria-describedby, calendrier utilisable au clavier.
 *
 * TODO(KAN-xxx, EP-08) : liste des visites + formulaire de planification.
 */
export const metadata: Metadata = { title: "Planning des visites" };

export default function CoordinatorPlanningPage() {
  return (
    <>
      <h1 className="text-3xl font-semibold">Planning des visites</h1>
      <p className="mt-2 text-base text-muted">Planifiez et suivez les visites chez les apiculteurs.</p>
      <StateBlock
        className="mt-6"
        kind="empty"
        title="Aucune visite planifiée"
        hint="TODO(KAN-xxx, EP-08) : brancher /visit-plans."
      />
    </>
  );
}
