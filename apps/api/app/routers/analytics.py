"""Routeur « analytics » : KPI et rapports (PDF côté Data).

Endpoints à implémenter (ROADMAP §4.10, préfixe /api/v1) :
    GET /analytics/kpis | POST /reports | GET /reports/{id}

Règles : pas de SQL ici (déléguer à ``services/`` puis ``repositories/``), schémas Pydantic
dans ``schemas/``, erreurs RFC 9457, pagination curseur, rate limit (slowapi) sur les routes sensibles.

TODO(EP-06, [API]): implémenter les endpoints ci-dessus (un ticket Jira par groupe d'endpoints).
"""

from fastapi import APIRouter

router = APIRouter(tags=["analytics"])
