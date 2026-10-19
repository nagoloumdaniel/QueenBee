"""Climat simulé par site : température et humidité (tendance saisonnière + cycle journalier + bruit).

Fonctions pures, déterministes à graine fixe (``numpy.random.Generator``).
"""

from datetime import datetime

from simulator.config import ClimateProfile


def external_temperature_c(profile: ClimateProfile, when: datetime, noise: float = 0.0) -> float:
    """Température extérieure à ``when`` (UTC) : base + saison + cycle jour/nuit + bruit.

    TODO(EP-01, [SIM]): sinusoïde saisonnière (pic en saison sèche pour le Sénégal), cycle
    journalier (min ~5h, max ~15h), amplitude plus forte au Cameroun (altitude).
    """
    raise NotImplementedError("TODO(EP-01, [SIM]): external_temperature_c")


def humidity_pct(profile: ClimateProfile, when: datetime, noise: float = 0.0) -> float:
    """Humidité relative (0-100) : base du site, plus haute la nuit et en saison des pluies."""
    raise NotImplementedError("TODO(EP-01, [SIM]): humidity_pct")


def honeyflow_gain_kg_per_day(profile: ClimateProfile, when: datetime) -> float:
    """Gain de poids attendu ce jour-là (0 hors miellée) : alimente la tendance saisonnière."""
    raise NotImplementedError("TODO(EP-01, [SIM]): honeyflow_gain_kg_per_day")
