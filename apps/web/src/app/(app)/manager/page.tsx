import type { Metadata } from "next";
import { StateBlock } from "@/components/ui/state-block";

/**
 * Gestionnaire - indicateurs consolidés + export du rapport bailleur (UC-G01, UC-G02, EP-08).
 *
 * Données : GET /analytics/kpis ; POST /reports puis GET /reports/{id} (PDF généré côté Data/API).
 * Composants : components/charts (kpi-card, graphiques) avec alternative tableau.
 * États à dessiner : loading (squelette de cartes), erreur, vide ("Pas encore de données sur
 * la période"), hors-ligne ; génération de PDF : état "en cours" annoncé (role="status").
 * Accessibilité : chaque KPI a un libellé + unité + évolution en texte (pas seulement une flèche colorée).
 *
 * TODO(KAN-xxx, EP-08) : cartes KPI, sélecteur de période, bouton "Exporter le rapport PDF".
 */
export const metadata: Metadata = { title: "Indicateurs" };

export default function ManagerHomePage() {
  return (
    <>
      <h1 className="text-3xl font-semibold">Indicateurs</h1>
      <p className="mt-2 text-base text-muted">
        Vue d&apos;ensemble de l&apos;activité des coopératives et des sites.
      </p>
      <StateBlock
        className="mt-6"
        kind="empty"
        hint="TODO(KAN-xxx, EP-08) : brancher /analytics/kpis et l'export PDF (/reports)."
      />
    </>
  );
}
