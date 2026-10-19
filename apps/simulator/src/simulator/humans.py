"""Comportement des apiculteurs simulés (profils assidu / régulier / occasionnel, CDC §6.6).

Génère des inspections et des déclarations de récolte via l'API (``api.py``), avec des
connexions sporadiques pour les profils occasionnels (données réalistes, pas un flux « propre »).
"""

from dataclasses import dataclass
from datetime import datetime


@dataclass(frozen=True)
class HumanProfile:
    """Profil d'apiculteur (voir ``config/humans.yaml``)."""

    name: str
    share: float  # part de la population (somme = 1)
    inspection_every_days: tuple[int, int]  # intervalle min/max entre inspections
    connectivity_probability: float  # probabilité d'être en ligne un jour donné


def next_inspection(profile: HumanProfile, last: datetime, rng_seed: int) -> datetime:
    """Date de la prochaine inspection selon le profil.

    TODO(EP-01, [SIM]): tirage dans l'intervalle du profil, graine déterministe.
    """
    raise NotImplementedError("TODO(EP-01, [SIM]): next_inspection")


def harvest_declaration(site_code: str, peak_date: datetime, predicted_kg: float) -> dict[str, float | str]:
    """Déclaration de récolte autour du pic de miellée, avec écart aléatoire vs prédiction (UC-C02).

    TODO(EP-01, [SIM]): écart gaussien configurable dans ``humans.yaml``.
    """
    raise NotImplementedError("TODO(EP-01, [SIM]): harvest_declaration")
