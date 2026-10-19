"""Ligne de commande ``queenbee-sim``.

Exemples :
    queenbee-sim run --sites SN-CASA --speed 60            # flotte normale accélérée
    queenbee-sim scenario essaimage --speed 1440           # un scénario YAML
    queenbee-sim serve                                     # API de pilotage (port SIM_CONTROL_PORT)
"""

import argparse
from collections.abc import Sequence


def build_parser() -> argparse.ArgumentParser:
    """Construit le parseur d'arguments (fonctionnel, la logique des commandes ne l'est pas)."""
    parser = argparse.ArgumentParser(prog="queenbee-sim", description="Simulateur QueenBee")
    sub = parser.add_subparsers(dest="command", required=True)

    run = sub.add_parser("run", help="publie la flotte en continu")
    run.add_argument("--sites", nargs="*", default=[], help="codes de sites (défaut : tous)")
    run.add_argument("--speed", type=float, default=1.0, help="facteur d'accélération temporelle")

    scn = sub.add_parser("scenario", help="joue un scénario YAML de scenarios/")
    scn.add_argument("name")
    scn.add_argument("--speed", type=float, default=1.0)

    sub.add_parser("serve", help="démarre l'API de pilotage")
    return parser


def main(argv: Sequence[str] | None = None) -> int:
    """Point d'entrée console.

    TODO(EP-01, [SIM]): brancher run / scenario / serve (asyncio) sur config, hive_model, mqtt_client.
    """
    args = build_parser().parse_args(argv)
    raise NotImplementedError(f"TODO(EP-01, [SIM]): commande {args.command!r}")


if __name__ == "__main__":
    raise SystemExit(main())
