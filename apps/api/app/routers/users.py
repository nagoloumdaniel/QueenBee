"""Routeur « users » : Utilisateurs (admin) : CRUD, rôles, journal d'audit.

Endpoints à implémenter (ROADMAP §4.10, préfixe /api/v1) :
    GET/POST /users | PATCH /users/{id} | POST /users/{id}/roles | GET /audit

Règles : pas de SQL ici (déléguer à ``services/`` puis ``repositories/``), schémas Pydantic
dans ``schemas/``, erreurs RFC 9457, pagination curseur, rate limit (slowapi) sur les routes sensibles.

TODO(EP-03, [AUTH]): implémenter les endpoints ci-dessus (un ticket Jira par groupe d'endpoints).
"""

from fastapi import APIRouter

router = APIRouter(tags=["users"])
