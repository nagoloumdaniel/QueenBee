"""Logs JSON structurés avec ``trace_id`` (ROADMAP §5.5).

Règle : aucune donnée personnelle en clair dans les logs (ROADMAP §5.7).
"""

import json
import logging
import sys
from datetime import UTC, datetime
from typing import Any

_RESERVED = set(logging.LogRecord("", 0, "", 0, "", (), None).__dict__) | {"message", "asctime"}


class JsonFormatter(logging.Formatter):
    """Formate chaque enregistrement en une ligne JSON (compatible Loki)."""

    def format(self, record: logging.LogRecord) -> str:
        payload: dict[str, Any] = {
            "ts": datetime.fromtimestamp(record.created, tz=UTC).isoformat(),
            "level": record.levelname,
            "logger": record.name,
            "msg": record.getMessage(),
        }
        # Champs additionnels passés via ``extra={...}`` (ex. trace_id).
        payload.update({k: v for k, v in record.__dict__.items() if k not in _RESERVED})
        if record.exc_info:
            payload["exc"] = self.formatException(record.exc_info)
        return json.dumps(payload, default=str, ensure_ascii=False)


def configure_logging(level: str = "INFO") -> None:
    """Installe le handler JSON sur le logger racine (idempotent)."""
    handler = logging.StreamHandler(sys.stdout)
    handler.setFormatter(JsonFormatter())
    root = logging.getLogger()
    root.handlers = [handler]
    root.setLevel(level.upper())
    # TODO(EP-10, [OBS]): middleware qui injecte/propage ``trace_id`` (en-tête X-Request-ID).
