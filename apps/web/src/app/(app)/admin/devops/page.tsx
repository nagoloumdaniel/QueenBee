import type { Metadata } from "next";
import { StateBlock } from "@/components/ui/state-block";

/**
 * Admin - vue DevOps : déploiements, files de synchronisation (EP-08 + EP-10).
 *
 * Données : GET /ops/deployments (table `deployment`, KPI "déploiements réussis > 95 %"),
 * GET /ops/sync-queues (taille/âge des files par site), GET /health et /ready.
 * Liens : tableaux Grafana (monitoring/) et runbooks (docs/runbooks/).
 * États à dessiner : loading, erreur, vide ("Aucun déploiement enregistré"), hors-ligne.
 * Accessibilité : statuts = texte + icône (jamais la couleur seule) ; tableau avec <caption>.
 *
 * TODO(KAN-xxx, EP-08) : tableau des déploiements (version, sha, statut, durée, rollback).
 */
export const metadata: Metadata = { title: "Déploiements" };

export default function AdminDevopsPage() {
  return (
    <>
      <h1 className="text-3xl font-semibold">Déploiements</h1>
      <p className="mt-2 text-base text-muted">Suivez les mises en ligne et l&apos;état des files de synchronisation.</p>
      <StateBlock
        className="mt-6"
        kind="empty"
        title="Aucun déploiement enregistré"
        hint="TODO(KAN-xxx, EP-08) : brancher /ops/deployments et /ops/sync-queues."
      />
    </>
  );
}
