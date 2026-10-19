import { Slot } from "@radix-ui/react-slot";
import { cva, type VariantProps } from "class-variance-authority";
import * as React from "react";
import { cn } from "@/lib/utils";

/**
 * Bouton (convention shadcn/ui). Cible tactile >= 48 px (min-h-12), focus visible
 * hérité de globals.css. Couleurs = tokens, jamais d'hexadécimal.
 */
const buttonVariants = cva(
  "inline-flex min-h-12 items-center justify-center gap-2 rounded-sm px-6 text-base font-medium transition-colors duration-fast disabled:pointer-events-none disabled:opacity-50",
  {
    variants: {
      variant: {
        primary: "bg-primary text-primary-foreground hover:brightness-95",
        secondary: "border border-border bg-surface text-foreground hover:bg-background",
        destructive: "bg-destructive text-destructive-foreground hover:brightness-95",
        ghost: "text-foreground hover:bg-surface",
      },
    },
    defaultVariants: { variant: "primary" },
  },
);

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean;
}

export const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, asChild = false, type = "button", ...props }, ref) => {
    const Comp = asChild ? Slot : "button";
    return (
      <Comp
        ref={ref}
        {...(asChild ? {} : { type })}
        className={cn(buttonVariants({ variant }), className)}
        {...props}
      />
    );
  },
);
Button.displayName = "Button";
