import type { ReactNode } from "react";
import { cn } from "@/lib/utils";

/**
 * Bloc d'état standard : chaque écran doit DESSINER ses états
 * loading / erreur / vide / hors-ligne (PLAYBOOK §6, ROADMAP §4.7).
 * Les pages squelettes l'utilisent comme marqueur de ce qui reste à brancher.
 */
export type StateKind = "loading" | "error" | "empty" | "offline";

const DEFAULT_TEXT: Record<StateKind, { title: string; hint: string }> = {
  loading: { title: "Chargement en cours…", hint: "Merci de patienter quelques secondes." },
  error: {
    title: "Impossible de charger les données",
    hint: "Vérifiez votre connexion puis réessayez.",
  },
  empty: { title: "Rien à afficher pour le moment", hint: "Les données apparaîtront ici." },
  offline: {
    title: "Vous êtes hors ligne",
    hint: "Les dernières données connues restent affichées.",
  },
};

type Props = {
  kind: StateKind;
  title?: string;
  hint?: string;
  action?: ReactNode;
  className?: string;
};

export function StateBlock({ kind, title, hint, action, className }: Props) {
  const text = DEFAULT_TEXT[kind];
  // `alert` interrompt le lecteur d'écran (erreur) ; `status` est poli (autres états).
  const role = kind === "error" ? "alert" : "status";
  return (
    <section
      role={role}
      aria-live={kind === "error" ? "assertive" : "polite"}
      data-state={kind}
      className={cn(
        "rounded-lg border border-dashed border-border bg-surface p-6 text-center",
        kind === "error" && "border-destructive",
        className,
      )}
    >
      <p className="text-xl font-medium">{title ?? text.title}</p>
      <p className="mt-2 text-sm text-muted">{hint ?? text.hint}</p>
      {action ? <div className="mt-4">{action}</div> : null}
    </section>
  );
}
