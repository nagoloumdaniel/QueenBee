"""Modèle de génération d'une ruche (CDC §6.6 « Modèle de génération par ruche »).

Composants : tendance saisonnière du poids, cycle journalier (température/humidité/acoustique
circadienne), bruit gaussien type capteur bas coût, dérive de batterie, position GPS stable
(avec dérive injectable pour le scénario de vol, UC-CY04).
"""

from dataclasses import dataclass
from datetime import datetime
from typing import Any


@dataclass
class HiveState:
    """État courant d'une ruche simulée."""

    hive_id: str  # ex. SN-CASA-014
    site_id: str  # ex. SN-CASA
    lat: float
    lon: float
    weight_kg: float
    battery_pct: float
    seq: int = 0  # compteur anti-rejeu, +1 à chaque trame
    alive: bool = True


class HiveModel:
    """Fait avancer l'état d'une ruche et produit les trames de télémétrie."""

    def __init__(self, state: HiveState, seed: int) -> None:
        self.state = state
        self.seed = seed

    def step(self, when: datetime, dt_seconds: float) -> None:
        """Avance l'état de ``dt_seconds`` simulées (poids, batterie, activité).

        TODO(EP-01, [SIM]): appliquer la miellée (climate), le bruit, la dérive batterie et les
        effets de scénario actifs (voir ``scenarios.py``).
        """
        raise NotImplementedError("TODO(EP-01, [SIM]): HiveModel.step")

    def frame(self, when: datetime) -> dict[str, Any]:
        """Retourne la trame JSON (format CDC §6.5 + ``seq`` + ``signature`` HMAC).

        Champs : hive_id, site_id, timestamp, position_lat, position_lon, weight_kg,
        temp_internal_c, temp_external_c, humidity_pct, acoustic_activity_score, battery_pct.
        """
        raise NotImplementedError("TODO(EP-01, [SIM]): HiveModel.frame")
