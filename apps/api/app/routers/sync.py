"""Routeur « sync » : Synchronisation offline-first mobile (outbox push / pull incrémental).

Endpoints à implémenter (ROADMAP §4.10, préfixe /api/v1) :
    POST /sync/push | GET /sync/pull?since= (règles de conflit : ROADMAP §4.9)

Règles : pas de SQL ici (déléguer à ``services/`` puis ``repositories/``), schémas Pydantic
dans ``schemas/``, erreurs RFC 9457, pagination curseur, rate limit (slowapi) sur les routes sensibles.

TODO(EP-05/EP-07, [API]): implémenter les endpoints ci-dessus (un ticket Jira par groupe d'endpoints).
"""

from fastapi import APIRouter

router = APIRouter(tags=["sync"])
