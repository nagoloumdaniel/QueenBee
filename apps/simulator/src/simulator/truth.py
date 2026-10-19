"""Vérité terrain : horodatage exact de chaque anomalie injectée.

Sert à mesurer précision et délai de détection des modèles Data et des automatisations Cyber.
Format cible : lignes JSON (JSONL) ``{scenario, hive, event, injected_at, simulated_at}`` et/ou
table dédiée. Le fichier de sortie est configurable (volume Docker monté).
"""

from datetime import datetime
from pathlib import Path


def record(path: Path, scenario: str, target: str, event: str, injected_at: datetime) -> None:
    """Ajoute un enregistrement de vérité terrain (append-only).

    TODO(EP-01, [SIM]): écriture JSONL atomique + exposition via l'API (GET /sim/truth).
    """
    raise NotImplementedError("TODO(EP-01, [SIM]): truth.record")
