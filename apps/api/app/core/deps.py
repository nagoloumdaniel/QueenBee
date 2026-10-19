"""Dépendances FastAPI partagées (injection de dépendances, ROADMAP §5.5).

Seule la partie « santé » est fonctionnelle ; le reste est à remplir par EP-02/EP-03.
"""

from collections.abc import AsyncIterator
from functools import lru_cache
from typing import Annotated

from fastapi import Depends
from sqlalchemy import text
from sqlalchemy.ext.asyncio import (
    AsyncEngine,
    AsyncSession,
    async_sessionmaker,
    create_async_engine,
)

from app.core.config import Settings, get_settings

SettingsDep = Annotated[Settings, Depends(get_settings)]


@lru_cache
def _engine(database_url: str) -> AsyncEngine:
    """Crée (une fois) le moteur SQLAlchemy asynchrone pour l'URL donnée."""
    return create_async_engine(database_url, pool_pre_ping=True)


async def get_session(settings: SettingsDep) -> AsyncIterator[AsyncSession]:
    """Fournit une session SQLAlchemy par requête.

    TODO(EP-02, [DB]): positionner ``app.user_id`` / ``app.role`` (SET LOCAL) pour la RLS.
    """
    if not settings.database_url:
        raise RuntimeError("QB_DATABASE_URL non configurée")
    async with async_sessionmaker(_engine(settings.database_url))() as session:
        yield session


async def check_database(settings: Settings) -> bool:
    """Retourne True si la base répond à ``SELECT 1`` (utilisé par /ready)."""
    if not settings.database_url:
        return False
    try:
        async with _engine(settings.database_url).connect() as conn:
            await conn.execute(text("SELECT 1"))
    except Exception:  # noqa: BLE001 - /ready ne doit jamais lever, seulement signaler
        return False
    return True


async def get_current_user() -> None:
    """Résout l'utilisateur authentifié depuis le JWT (Bearer).

    TODO(EP-03, [AUTH]): décoder le JWT, charger l'utilisateur, appliquer le RBAC (4 rôles).
    """
    raise NotImplementedError("TODO(EP-03, [AUTH]): get_current_user")
