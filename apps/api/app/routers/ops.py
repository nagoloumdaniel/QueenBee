"""Routeur « ops » : Exploitation : métriques, déploiements, files de sync (/health et /ready sont dans main.py).

Endpoints à implémenter (ROADMAP §4.10, préfixe /api/v1) :
    GET /metrics | GET /ops/deployments | GET /ops/sync-queues

Règles : pas de SQL ici (déléguer à ``services/`` puis ``repositories/``), schémas Pydantic
dans ``schemas/``, erreurs RFC 9457, pagination curseur, rate limit (slowapi) sur les routes sensibles.

TODO(EP-10, [OBS]): implémenter les endpoints ci-dessus (un ticket Jira par groupe d'endpoints).
"""

from fastapi import APIRouter

router = APIRouter(tags=["ops"])
