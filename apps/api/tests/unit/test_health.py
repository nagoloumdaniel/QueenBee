"""Tests des sondes /health (liveness) et /ready (readiness)."""

from fastapi.testclient import TestClient


def test_health_returns_ok(client: TestClient) -> None:
    response = client.get("/health")

    assert response.status_code == 200
    body = response.json()
    assert body["status"] == "ok"
    assert body["version"]


def test_ready_without_database_returns_503(client: TestClient) -> None:
    """Sans QB_DATABASE_URL, l'API est vivante mais pas prête."""
    response = client.get("/ready")

    assert response.status_code == 503
    assert response.json() == {"status": "not_ready", "checks": {"database": "unavailable"}}
