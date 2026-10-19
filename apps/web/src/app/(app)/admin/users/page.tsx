import type { Metadata } from "next";
import { StateBlock } from "@/components/ui/state-block";

/**
 * Admin - utilisateurs, rôles et journal d'audit (UC-AD01, EP-08).
 *
 * Données : GET/POST /users, PATCH /users/{id}, POST /users/{id}/roles, GET /audit.
 * Règles : MFA obligatoire pour les rôles privilégiés ; toute action d'admin est tracée
 * dans `audit_log` (vérifiée par le test E2E "admin -> créer utilisateur, audit tracé").
 * Données personnelles : afficher le minimum (RGPD) ; jamais de PII dans les logs.
 * États à dessiner : loading, erreur, vide, hors-ligne (écriture désactivée).
 * Accessibilité : tableau + dialogue de création (focus piégé, Échap ferme, focus restitué).
 *
 * TODO(KAN-xxx, EP-08) : liste paginée (curseur), création, changement de rôle, désactivation.
 */
export const metadata: Metadata = { title: "Utilisateurs" };

export default function AdminUsersPage() {
  return (
    <>
      <h1 className="text-3xl font-semibold">Utilisateurs</h1>
      <p className="mt-2 text-base text-muted">Créez les comptes et gérez les rôles.</p>
      <StateBlock
        className="mt-6"
        kind="empty"
        hint="TODO(KAN-xxx, EP-08) : brancher /users et /audit."
      />
    </>
  );
}
