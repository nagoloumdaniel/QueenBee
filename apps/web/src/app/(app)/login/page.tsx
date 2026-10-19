import type { Metadata } from "next";
import { StateBlock } from "@/components/ui/state-block";

/**
 * Connexion (UC-T01) : e-mail + mot de passe, puis code TOTP (MFA) pour les rôles privilégiés.
 *
 * États à prévoir (PLAYBOOK §6) :
 *  - loading  : bouton désactivé + message "Connexion en cours" (role="status") ;
 *  - erreur   : message GÉNÉRIQUE "Identifiants incorrects" (jamais dire si l'e-mail existe) ;
 *  - verrouillé : après 5 essais, message neutre + délai ;
 *  - hors-ligne : bannière "Pas de réseau" ;
 *  - vide     : sans objet.
 *
 * TODO(KAN-xxx, EP-03/EP-08) : brancher POST /auth/login puis /auth/mfa/verify,
 * poser le cookie de session httpOnly, rediriger vers ROLE_HOME[role] ou `?next=`.
 */
export const metadata: Metadata = { title: "Connexion" };

export default function LoginPage() {
  return (
    <div className="mx-auto max-w-md">
      <h1 className="text-3xl font-semibold">Connexion</h1>
      <p className="mt-2 text-base text-muted">Entrez vos identifiants pour accéder à votre espace.</p>

      {/* TODO(KAN-xxx) : transformer en composant client avec gestion d'erreur et de chargement */}
      <form className="mt-6 space-y-4" method="post" aria-describedby="login-aide" noValidate>
        <div>
          <label htmlFor="email" className="block text-base font-medium">
            Adresse e-mail
          </label>
          <input
            id="email"
            name="email"
            type="email"
            autoComplete="username"
            required
            className="mt-1 min-h-12 w-full rounded-sm border border-border bg-surface px-3 text-base"
          />
        </div>
        <div>
          <label htmlFor="password" className="block text-base font-medium">
            Mot de passe
          </label>
          <input
            id="password"
            name="password"
            type="password"
            autoComplete="current-password"
            required
            className="mt-1 min-h-12 w-full rounded-sm border border-border bg-surface px-3 text-base"
          />
        </div>
        <p id="login-aide" className="text-sm text-muted">
          Les coordinateurs, gestionnaires et administrateurs devront ensuite saisir un code à
          usage unique.
        </p>
        <button
          type="submit"
          disabled
          className="min-h-12 w-full rounded-sm bg-primary px-6 font-medium text-primary-foreground disabled:opacity-50"
        >
          Se connecter
        </button>
      </form>

      <StateBlock
        className="mt-6"
        kind="empty"
        title="Formulaire non branché"
        hint="TODO(KAN-xxx) : supprimer ce bloc quand l'authentification est reliée à l'API."
      />
    </div>
  );
}
