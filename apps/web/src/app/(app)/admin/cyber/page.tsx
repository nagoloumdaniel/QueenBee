import type { Metadata } from "next";
import { StateBlock } from "@/components/ui/state-block";

/**
 * Admin - vue Cyber : journaux de sécurité et événements d'intégrité (EP-08, UC-CY01..CY04).
 *
 * Données : GET /audit (audit_log append-only) et événements `integrity_event`
 * (out_of_range, replay, bad_signature, duplicate, unknown_sensor) + alertes
 * gateway_offline / hive_moved / radio_jamming. Contrat API à préciser avec l'équipe Cyber :
 * TODO(KAN-xxx, EP-06).
 * Règles : lecture seule ; aucune PII en clair ; filtres par période, site, type.
 * États à dessiner : loading, erreur, vide ("Aucun incident sur la période"), hors-ligne.
 * Accessibilité : sévérité = texte + icône ; tableau triable au clavier.
 */
export const metadata: Metadata = { title: "Sécurité" };

export default function AdminCyberPage() {
  return (
    <>
      <h1 className="text-3xl font-semibold">Sécurité</h1>
      <p className="mt-2 text-base text-muted">Journaux d&apos;audit et événements d&apos;intégrité des capteurs.</p>
      <StateBlock
        className="mt-6"
        kind="empty"
        title="Aucun incident sur la période"
        hint="TODO(KAN-xxx, EP-08) : brancher les journaux et événements d'intégrité."
      />
    </>
  );
}
