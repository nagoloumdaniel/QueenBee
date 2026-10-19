import { NextResponse, type NextRequest } from "next/server";
import { readSession, SESSION_COOKIE } from "@/lib/auth";
import { canAccess, isPrivatePath, ROLE_HOME } from "@/lib/rbac";

/**
 * Middleware QueenBee (Edge Runtime). Deux responsabilités :
 *
 * 1. RBAC d'interface : sans session -> /login?next=... ; mauvais rôle -> page d'accueil
 *    de son rôle. (Confort UX. La sécurité réelle est faite par l'API, ROADMAP §5.7.)
 * 2. SEO / confidentialité : toute zone privée reçoit `X-Robots-Tag: noindex, nofollow`
 *    (ROADMAP §6.4). Seule la landing publique est indexable.
 *
 * TODO(KAN-xxx, EP-03/EP-08) : test E2E tests/e2e/auth.spec.ts (matrice rôle x URL).
 */
export function middleware(request: NextRequest) {
  const { pathname, search } = request.nextUrl;

  if (!isPrivatePath(pathname)) {
    return NextResponse.next();
  }

  const session = readSession(request.cookies.get(SESSION_COOKIE)?.value);
  const isLogin = pathname === "/login";

  // Pas de session sur une zone protégée -> login
  if (!isLogin && !session) {
    const loginUrl = new URL("/login", request.url);
    loginUrl.searchParams.set("next", `${pathname}${search}`);
    return withNoIndex(NextResponse.redirect(loginUrl));
  }

  // Session valide mais rôle insuffisant -> accueil de son rôle
  if (!isLogin && !canAccess(session?.role ?? null, pathname)) {
    const home = session ? ROLE_HOME[session.role] : "/login";
    return withNoIndex(NextResponse.redirect(new URL(home, request.url)));
  }

  return withNoIndex(NextResponse.next());
}

function withNoIndex(response: NextResponse): NextResponse {
  response.headers.set("X-Robots-Tag", "noindex, nofollow");
  response.headers.set("Cache-Control", "private, no-store");
  return response;
}

export const config = {
  // Exclut les fichiers statiques, l'optimiseur d'images et les icônes
  matcher: ["/((?!_next/static|_next/image|favicon.ico|icon.svg).*)"],
};
