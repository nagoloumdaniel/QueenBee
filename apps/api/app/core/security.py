"""Primitives de sécurité : hachage argon2id, JWT, TOTP, verrouillage.

Squelette : à remplir par les tickets EP-03 (Auth/RBAC). Contraintes ROADMAP §5.7 :
argon2id, JWT 15 min, refresh rotatif avec détection de réutilisation, TOTP, verrou 5 essais.
"""

from datetime import timedelta
from typing import Any


def hash_password(password: str) -> str:
    """Hache un mot de passe avec argon2id (``argon2.PasswordHasher``)."""
    raise NotImplementedError("TODO(EP-03, [AUTH]): hash_password argon2id")


def verify_password(password: str, password_hash: str) -> bool:
    """Vérifie un mot de passe ; doit aussi signaler si un re-hash est nécessaire."""
    raise NotImplementedError("TODO(EP-03, [AUTH]): verify_password")


def create_access_token(subject: str, role: str, ttl: timedelta | None = None) -> str:
    """Émet un JWT d'accès court (15 min par défaut) signé via ``pyjwt``."""
    raise NotImplementedError("TODO(EP-03, [AUTH]): create_access_token")


def decode_access_token(token: str) -> dict[str, Any]:
    """Valide signature, expiration et claims ; lève une erreur 401 sinon."""
    raise NotImplementedError("TODO(EP-03, [AUTH]): decode_access_token")


def generate_totp_secret() -> str:
    """Génère un secret TOTP (``pyotp.random_base32``) à chiffrer avant stockage."""
    raise NotImplementedError("TODO(EP-03, [AUTH]): generate_totp_secret")


def verify_totp(secret: str, code: str) -> bool:
    """Vérifie un code TOTP à 6 chiffres avec une fenêtre de tolérance d'un pas."""
    raise NotImplementedError("TODO(EP-03, [AUTH]): verify_totp")
