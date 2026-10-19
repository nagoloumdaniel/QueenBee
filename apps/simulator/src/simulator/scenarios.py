"""Moteur de scénarios déclaratifs (timeline YAML, CDC §6.6).

Un scénario = liste d'étapes ``{at, action, params}`` appliquées à une ruche ou un site.
Vocabulaire d'actions à supporter (voir ``scenarios/*.yaml``) :
    normal, acoustic_drift, weight_step, thermal_spike, battery_fade, sensor_silence,
    gateway_offline, radio_jam, inject_replay, inject_out_of_range, gps_drift.

Chaque scénario déclare aussi une ``ground_truth`` (instant exact de l'anomalie) écrite par
``truth.py`` pour évaluer objectivement les détecteurs (Data) et les automatisations (Cyber).
"""

from dataclasses import dataclass, field
from pathlib import Path
from typing import Any


@dataclass(frozen=True)
class Step:
    """Une étape de timeline, ``at`` en durée relative au début (ex. ``15d``, ``15d+1h``)."""

    at: str
    action: str
    params: dict[str, Any] = field(default_factory=dict)


@dataclass(frozen=True)
class Scenario:
    """Scénario chargé depuis un fichier YAML."""

    name: str
    description: str
    target: dict[str, str]  # {"hive": "SN-CASA-014"} ou {"site": "SN-CASA"}
    steps: list[Step]
    ground_truth: dict[str, Any]


def load_scenario(path: Path) -> Scenario:
    """Charge et valide un scénario YAML.

    TODO(EP-01, [SIM]): parser les durées (``parse_offset``), valider le vocabulaire d'actions.
    """
    raise NotImplementedError("TODO(EP-01, [SIM]): load_scenario")


def parse_offset(text: str) -> float:
    """Convertit ``15d+1h`` en secondes simulées. TODO(EP-01, [SIM]) avec tests paramétrés."""
    raise NotImplementedError("TODO(EP-01, [SIM]): parse_offset")


async def run_scenario(scenario: Scenario, speed: float) -> None:
    """Joue le scénario (rejouable à la demande) et enregistre la vérité terrain.

    TODO(EP-01, [SIM]): planifier les étapes sur l'horloge simulée, appliquer les effets au
    ``HiveModel`` ou au ``MqttClient`` (coupure, brouillage, rejeu), appeler ``truth.record``.
    """
    raise NotImplementedError("TODO(EP-01, [SIM]): run_scenario")
