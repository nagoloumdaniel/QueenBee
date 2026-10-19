"""Règles de détection par seuil -> candidats d'alerte (ROADMAP §5.4 EP-04).

Chaque module de règle expose ``evaluate(window) -> list[AlertCandidate]``. Les seuils viennent
de la table ``alert_threshold`` (par site) ; ne jamais coder de seuil en dur dans la règle.
Couverture de tests exigée : 100 % (ROADMAP §5.6). Un score ML pourra s'y ajouter (contrat Data).
"""

from dataclasses import dataclass, field
from datetime import datetime
from typing import Any, Protocol


@dataclass(frozen=True)
class AlertCandidate:
    """Alerte détectée, avant écriture en base (miroir de la table ``alert``)."""

    hive_id: str
    type: str  # valeur de l'ENUM ``alert_type``
    severity: str  # info | warning | critical
    confidence: float
    detected_at: datetime
    dedup_key: str
    details: dict[str, Any] = field(default_factory=dict)


@dataclass(frozen=True)
class Window:
    """Fenêtre glissante de mesures d'une ruche (séries triées par ``ts``)."""

    hive_id: str
    ts: list[datetime]
    series: dict[str, list[float | None]]  # ex. {"weight_kg": [...], "temp_internal_c": [...]}
    params: dict[str, Any]  # seuils de ``alert_threshold.params``


class Rule(Protocol):
    """Contrat commun des règles."""

    def evaluate(self, window: Window) -> list[AlertCandidate]: ...
