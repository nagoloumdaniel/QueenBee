"""Routeur « sim » : Pilotage du simulateur (désactivé en production).

Endpoints à implémenter (ROADMAP §4.10, préfixe /api/v1) :
    POST /sim/scenarios/{name}/run | GET /sim/status | PUT /sim/speed

Règles : pas de SQL ici (déléguer à ``services/`` puis ``repositories/``), schémas Pydantic
dans ``schemas/``, erreurs RFC 9457, pagination curseur, rate limit (slowapi) sur les routes sensibles.

TODO(EP-01, [SIM]): implémenter les endpoints ci-dessus (un ticket Jira par groupe d'endpoints).
"""

from fastapi import APIRouter

router = APIRouter(tags=["sim"])
