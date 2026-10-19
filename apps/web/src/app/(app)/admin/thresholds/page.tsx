import type { Metadata } from "next";
import { StateBlock } from "@/components/ui/state-block";

/**
 * Admin - seuils d'alerte par site (EP-08, règles EP-04).
 *
 * Données : table `alert_threshold` (site_id, alert_type, params jsonb), ex. {"drop_kg":0.5,"window_h":2}.
 * Contrat API à définir avec le ticket API (endpoint de lecture/écriture des seuils, absent de
 * docs/openapi.yaml à ce stade) : TODO(KAN-xxx, EP-06).
 * Validation : plages physiques côté serveur ET formulaire ; valeur par défaut visible ;
 * toute modification tracée dans l'audit.
 * États à dessiner : loading, erreur, vide (seuils par défaut utilisés), hors-ligne.
 * Accessibilité : unités dans les libellés ("Chute de poids, en kg"), erreurs liées au champ.
 */
export const metadata: Metadata = { title: "Seuils d'alerte" };

export default function AdminThresholdsPage() {
  return (
    <>
      <h1 className="text-3xl font-semibold">Seuils d&apos;alerte</h1>
      <p className="mt-2 text-base text-muted">Réglez à partir de quand une alerte se déclenche, site par site.</p>
      <StateBlock
        className="mt-6"
        kind="empty"
        title="Seuils par défaut utilisés"
        hint="TODO(KAN-xxx, EP-08) : formulaire par site et type d'alerte."
      />
    </>
  );
}
