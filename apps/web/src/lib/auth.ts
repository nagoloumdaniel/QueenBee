import { decodeJwt } from "jose";
import { isRole, type Role } from "./rbac";

/**
 * Session web.
 *
 * Principe : le jeton d'accès (JWT 15 min) et le refresh rotatif sont posés par
 * l'API/BFF en cookies httpOnly + Secure + SameSite=Lax. Le JavaScript du navigateur
 * ne les lit jamais (anti-XSS). Ce module ne fait que LIRE le rôle pour l'UX.
 *
 * TODO(KAN-xxx, EP-03/EP-08) :
 *  - brancher le flux login -> /auth/login -> /auth/mfa/verify (TOTP) ;
 *  - rafraîchir le jeton via /auth/refresh (rotation, détection de réutilisation) ;
 *  - /logout : révoquer côté API puis effacer les cookies.
 */
export const SESSION_COOKIE = process.env.SESSION_COOKIE_NAME ?? "qb_session";

export type Session = {
  userId: string;
  role: Role;
  expiresAt: number; // secondes epoch
};

/**
 * Décode le JWT SANS vérifier la signature (fonctionne en Edge Runtime, pour le
 * middleware). Suffisant pour choisir une redirection ; JAMAIS pour autoriser une
 * donnée. L'API revérifie la signature à chaque appel.
 */
export function readSession(token: string | undefined): Session | null {
  if (!token) return null;
  try {
    const claims = decodeJwt(token);
    const role = claims["role"];
    if (!claims.sub || !isRole(role) || !claims.exp) return null;
    if (claims.exp * 1000 < Date.now()) return null;
    return { userId: claims.sub, role, expiresAt: claims.exp };
  } catch {
    return null;
  }
}
