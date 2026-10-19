import type { Metadata } from "next";
import { cookies } from "next/headers";
import type { ReactNode } from "react";
import { AppShell } from "@/components/layout/app-shell";
import { readSession, SESSION_COOKIE } from "@/lib/auth";

// Zones privées : jamais indexées (double sécurité avec src/middleware.ts).
export const metadata: Metadata = {
  robots: { index: false, follow: false, nocache: true },
};

export default async function PrivateLayout({ children }: { children: ReactNode }) {
  const token = (await cookies()).get(SESSION_COOKIE)?.value;
  const session = readSession(token);
  return <AppShell role={session?.role ?? null}>{children}</AppShell>;
}
