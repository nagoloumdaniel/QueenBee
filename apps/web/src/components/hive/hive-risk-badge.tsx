import { cn } from "@/lib/utils";

/** Niveau de risque affiché d'une ruche (aligné sur l'enum SQL `severity`). */
export type RiskLevel = "info" | "warning" | "critical";

const LABEL: Record<RiskLevel, string> = {
  info: "Normal",
  warning: "À surveiller",
  critical: "Urgent",
};

const STYLE: Record<RiskLevel, string> = {
  info: "bg-leaf text-white",
  warning: "bg-honey text-earth",
  critical: "bg-alert text-white",
};

/**
 * Pastille de risque : couleur ET texte (jamais la couleur seule, WCAG 1.4.1).
 * TODO(KAN-xxx, EP-08) : ajouter une icône, le score santé (0-100) et un test Vitest.
 */
export function HiveRiskBadge({ level, className }: { level: RiskLevel; className?: string }) {
  return (
    <span
      className={cn(
        "inline-flex items-center rounded-sm px-2 py-1 text-sm font-medium",
        STYLE[level],
        className,
      )}
    >
      {LABEL[level]}
    </span>
  );
}
