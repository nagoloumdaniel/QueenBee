"""Chargement et validation de la configuration (sites, profils humains) et des variables SIM_*.

Fichiers : ``config/sites.yaml`` (8 sites, 3 pays, profils climatiques) et ``config/humans.yaml``.
"""

from pathlib import Path

from pydantic import BaseModel, Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Honeyflow(BaseModel):
    """Période de miellée : gain de poids quotidien moyen entre deux dates (MM-JJ)."""

    start: str
    end: str
    gain_kg_per_day: float = Field(ge=0)


class ClimateProfile(BaseModel):
    """Paramètres climatiques propres à un site (jamais un profil dupliqué entre sites)."""

    label: str
    base_temp_c: float
    seasonal_amplitude_c: float
    diurnal_amplitude_c: float
    base_humidity_pct: float
    dry_season: list[str] = Field(description="Mois secs, ex. ['11','12','01']")
    thermal_stress_prone: bool = False
    honeyflows: list[Honeyflow]


class SiteConfig(BaseModel):
    """Un site (rucher) simulé, avec sa flotte de ruches."""

    code: str  # ex. SN-CASA
    name: str
    country: str  # code ISO 3166-1 alpha-2
    lat: float
    lon: float
    hives: int = Field(gt=0)
    climate: ClimateProfile


class SimSettings(BaseSettings):
    """Variables d'environnement ``SIM_*``."""

    model_config = SettingsConfigDict(env_prefix="SIM_", env_file=".env", extra="ignore")

    mqtt_host: str = "localhost"
    mqtt_port: int = 1883
    mqtt_username: str = ""
    mqtt_password: str = ""
    api_url: str = "http://localhost:8000/api/v1"
    control_port: int = 8081
    speed: float = 1.0
    seed: int = 42


def load_sites(path: Path) -> list[SiteConfig]:
    """Lit ``sites.yaml`` et retourne les sites validés.

    TODO(EP-01, [SIM]): yaml.safe_load + validation Pydantic, erreur claire si un site est invalide.
    """
    raise NotImplementedError("TODO(EP-01, [SIM]): load_sites")
