"""API de pilotage du simulateur (consommée par ``apps/api`` via ``routers/sim.py``).

Contrat (ROADMAP §4.10) :
    POST /sim/scenarios/{name}/run   lance un scénario (rejouable)
    GET  /sim/status                 état (horloge simulée, vitesse, scénarios actifs)
    PUT  /sim/speed                  change le facteur d'accélération

Désactivée en production. TODO(EP-01, [SIM]): implémenter avec FastAPI, authentification par jeton.
"""

from fastapi import APIRouter

router = APIRouter(prefix="/sim", tags=["sim"])

# TODO(EP-01, [SIM]): endpoints run / status / speed.
