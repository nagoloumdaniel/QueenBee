"""Configuration 12-factor : tout vient de variables d'environnement préfixées ``QB_``.

Aucun secret n'est committé : voir ``.env.example`` pour les noms des variables.
"""

from functools import lru_cache

from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Paramètres de l'application (lus depuis l'environnement ou ``.env``)."""

    model_config = SettingsConfigDict(env_prefix="QB_", env_file=".env", extra="ignore")

    env: str = Field(default="dev", description="dev | test | staging | production")
    app_name: str = "queenbee-api"
    api_prefix: str = "/api/v1"
    log_level: str = "INFO"

    # Base de données. Vide => /ready signale la base comme indisponible (503).
    database_url: str = ""

    # JWT (EP-03). Le secret DOIT venir de l'environnement en staging/production.
    jwt_secret: str = ""
    jwt_algorithm: str = "HS256"
    jwt_access_ttl_min: int = 15
    jwt_refresh_ttl_days: int = 30

    cors_origins: list[str] = Field(default_factory=list)


@lru_cache
def get_settings() -> Settings:
    """Retourne les paramètres (mis en cache ; vider le cache dans les tests)."""
    return Settings()
