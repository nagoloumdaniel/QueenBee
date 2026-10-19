"""Fixtures communes. Les tests ne dépendent d'aucun service externe par défaut."""

from collections.abc import Iterator

import pytest
from fastapi.testclient import TestClient

from app.core.config import get_settings
from app.main import create_app


@pytest.fixture(autouse=True)
def _isolated_settings(monkeypatch: pytest.MonkeyPatch) -> Iterator[None]:
    """Neutralise la config d'environnement et vide le cache des paramètres."""
    monkeypatch.delenv("QB_DATABASE_URL", raising=False)
    get_settings.cache_clear()
    yield
    get_settings.cache_clear()


@pytest.fixture
def client() -> Iterator[TestClient]:
    """Client HTTP synchrone sur une application fraîche."""
    with TestClient(create_app()) as test_client:
        yield test_client
