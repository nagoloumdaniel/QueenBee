"""Routeur « auth » : Authentification : login, MFA TOTP, refresh rotatif, logout, profil (/me).

Endpoints à implémenter (ROADMAP §4.10, préfixe /api/v1) :
    POST /auth/login | POST /auth/mfa/verify | POST /auth/refresh | POST /auth/logout | GET /me

Règles : pas de SQL ici (déléguer à ``services/`` puis ``repositories/``), schémas Pydantic
dans ``schemas/``, erreurs RFC 9457, pagination curseur, rate limit (slowapi) sur les routes sensibles.

TODO(EP-03, [AUTH]): implémenter les endpoints ci-dessus (un ticket Jira par groupe d'endpoints).
"""

from fastapi import APIRouter

router = APIRouter(tags=["auth"])
