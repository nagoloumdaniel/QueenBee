"""Point d'entrée FastAPI : création de l'application, /health et /ready.

Lancer en local : ``uvicorn app.main:app --reload`` (depuis ``apps/api``).
"""

from typing import Annotated

from fastapi import Depends, FastAPI, Response, status
from pydantic import BaseModel

from app import __version__
from app.core.config import Settings, get_settings
from app.core.deps import check_database
from app.core.logging import configure_logging
from app.routers import (
    alerts,
    analytics,
    auth,
    harvests,
    hives,
    inspections,
    ops,
    sim,
    sites,
    sync,
    users,
    visit_plans,
)


class HealthResponse(BaseModel):
    """Réponse de /health (liveness : le processus répond)."""

    status: str
    version: str


class ReadyResponse(BaseModel):
    """Réponse de /ready (readiness : les dépendances répondent)."""

    status: str
    checks: dict[str, str]


def create_app() -> FastAPI:
    """Construit l'application (fabrique, pratique pour les tests)."""
    settings = get_settings()
    configure_logging(settings.log_level)
    app = FastAPI(
        title="QueenBee API",
        version=__version__,
        openapi_url=f"{settings.api_prefix}/openapi.json",
    )

    # Sondes hors préfixe versionné : utilisées par Docker, Caddy et Prometheus.
    @app.get("/health", tags=["ops"], summary="Liveness")
    async def health() -> HealthResponse:
        """Retourne 200 tant que le processus tourne (aucune dépendance vérifiée)."""
        return HealthResponse(status="ok", version=__version__)

    @app.get(
        "/ready",
        tags=["ops"],
        summary="Readiness",
        responses={503: {"model": ReadyResponse}},
    )
    async def ready(
        response: Response,
        settings: Annotated[Settings, Depends(get_settings)],
    ) -> ReadyResponse:
        """Retourne 200 si les dépendances (base) répondent, sinon 503."""
        db_ok = await check_database(settings)
        if not db_ok:
            response.status_code = status.HTTP_503_SERVICE_UNAVAILABLE
        return ReadyResponse(
            status="ready" if db_ok else "not_ready",
            checks={"database": "ok" if db_ok else "unavailable"},
        )

    # Routeurs métier versionnés (vides pour l'instant, voir chaque module).
    for module in (
        auth,
        users,
        sites,
        hives,
        inspections,
        harvests,
        alerts,
        visit_plans,
        sync,
        analytics,
        ops,
        sim,
    ):
        app.include_router(module.router, prefix=settings.api_prefix)

    return app


app = create_app()
