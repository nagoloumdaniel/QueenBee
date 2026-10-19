"""Validation des trames capteurs (ROADMAP §5.7 « Capteurs », CDC §6.5).

Une trame rejetée n'est jamais perdue silencieusement : elle produit un ``integrity_event``
de type ``out_of_range | replay | bad_signature | duplicate | unknown_sensor``.
"""

from datetime import datetime
from enum import StrEnum

from pydantic import BaseModel, Field


class IntegrityKind(StrEnum):
    """Miroir de l'ENUM SQL ``integrity_kind`` (db/schema/reference.sql)."""

    OUT_OF_RANGE = "out_of_range"
    REPLAY = "replay"
    BAD_SIGNATURE = "bad_signature"
    DUPLICATE = "duplicate"
    UNKNOWN_SENSOR = "unknown_sensor"


class TelemetryFrame(BaseModel):
    """Trame de télémétrie telle que reçue sur ``queenbee/{site}/{hive}/telemetry``."""

    hive_id: str
    site_id: str
    timestamp: datetime
    seq: int = Field(ge=0, description="Compteur anti-rejeu, strictement croissant par ruche")
    position_lat: float = Field(ge=-90, le=90)
    position_lon: float = Field(ge=-180, le=180)
    weight_kg: float | None = None
    temp_internal_c: float | None = None
    temp_external_c: float | None = None
    humidity_pct: float | None = None
    acoustic_activity_score: float | None = None
    battery_pct: float | None = None
    signature: str | None = Field(default=None, description="HMAC-SHA256 par ruche (hex)")


class FrameRejected(Exception):
    """Levée quand une trame est rejetée ; porte la nature de l'anomalie."""

    def __init__(self, kind: IntegrityKind, detail: str) -> None:
        super().__init__(detail)
        self.kind = kind
        self.detail = detail


def validate_frame(payload: bytes) -> TelemetryFrame:
    """Parse et valide une trame brute ; lève ``FrameRejected`` si invalide.

    TODO(EP-04, [INGEST]): schéma Pydantic strict, plages physiques (poids, températures,
    humidité 0-100, batterie 0-100), vérification HMAC avec ``hive.sensor_key_hash``.
    """
    raise NotImplementedError("TODO(EP-04, [INGEST]): validate_frame")


def check_replay(hive_id: str, seq: int, last_seq: int | None) -> None:
    """Rejette si ``seq`` <= dernier ``seq`` accepté pour la ruche (anti-rejeu).

    TODO(EP-04, [INGEST]): état du dernier seq (table ou cache), tolérance au redémarrage capteur.
    """
    raise NotImplementedError("TODO(EP-04, [INGEST]): check_replay")
