import type { Config } from "tailwindcss";
import animate from "tailwindcss-animate";

/**
 * Tailwind lit les tokens QueenBee depuis les variables CSS de
 * src/app/globals.css (source unique, ROADMAP §4.7).
 * Ne JAMAIS écrire de couleur hexadécimale en dur dans un composant.
 */
const config: Config = {
  darkMode: ["selector", '[data-theme="dark"]'],
  content: ["./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        honey: "var(--qb-honey)",
        amber: "var(--qb-amber)",
        earth: "var(--qb-earth)",
        leaf: "var(--qb-leaf)",
        cream: "var(--qb-cream)",
        alert: "var(--qb-alert)",
        background: "var(--background)",
        foreground: "var(--foreground)",
        surface: "var(--surface)",
        muted: "var(--muted)",
        border: "var(--border)",
        primary: {
          DEFAULT: "var(--primary)",
          foreground: "var(--primary-foreground)",
        },
        destructive: {
          DEFAULT: "var(--destructive)",
          foreground: "var(--destructive-foreground)",
        },
        ring: "var(--ring)",
      },
      fontFamily: {
        sans: ["var(--font-inter)", "system-ui", "sans-serif"],
        display: ["var(--font-fraunces)", "Georgia", "serif"],
      },
      fontSize: {
        // Échelle 12 / 14 / 16 / 20 / 28 / 40 (ROADMAP §4.7)
        xs: ["0.75rem", "1rem"],
        sm: ["0.875rem", "1.25rem"],
        base: ["1rem", "1.5rem"],
        xl: ["1.25rem", "1.75rem"],
        "3xl": ["1.75rem", "2.25rem"],
        "5xl": ["2.5rem", "3rem"],
      },
      borderRadius: {
        // Rayons 8 / 16
        sm: "8px",
        lg: "16px",
      },
      boxShadow: {
        card: "var(--shadow-card)",
      },
      transitionDuration: {
        // Durées motion 150 / 250 ms
        fast: "150ms",
        base: "250ms",
      },
    },
  },
  plugins: [animate],
};

export default config;
