"""Routeur « inspections » : Inspections terrain et photos.

Endpoints à implémenter (ROADMAP §4.10, préfixe /api/v1) :
    POST /inspections | GET /inspections?hive_id | POST /inspections/{id}/photos

Règles : pas de SQL ici (déléguer à ``services/`` puis ``repositories/``), schémas Pydantic
dans ``schemas/``, erreurs RFC 9457, pagination curseur, rate limit (slowapi) sur les routes sensibles.

TODO(EP-06, [API]): implémenter les endpoints ci-dessus (un ticket Jira par groupe d'endpoints).
"""

from fastapi import APIRouter

router = APIRouter(tags=["inspections"])
