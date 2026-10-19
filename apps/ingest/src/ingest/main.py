"""Boucle principale du worker d'ingestion.

Flux cible (ROADMAP §5.4 EP-04) :
    MQTT (queenbee/+/+/telemetry, QoS 1)
      -> ``validators.validate_frame``      (schéma, plages physiques, HMAC, anti-rejeu ``seq``)
      -> insertion ``measurement``          (idempotente : PK (hive_id, ts, seq))
         ou ``integrity_event``             (trame rejetée, avec ``kind``)
      -> ``rules.*``                        (seuils -> candidats d'alerte)
      -> upsert ``alert``                   (clé ``dedup_key``)

Topics (ROADMAP §4.10) : ``queenbee/{site}/{hive}/telemetry`` (QoS1), ``.../status``,
``queenbee/{site}/gw/heartbeat``.
"""

import asyncio


async def main() -> None:
    """Se connecte au broker, consomme les trames et alimente la base.

    TODO(EP-04, [INGEST]): connexion aiomqtt avec reconnexion, pool asyncpg, boucle de
    consommation, arrêt propre sur SIGTERM, métriques Prometheus (trames reçues/rejetées).
    """
    raise NotImplementedError("TODO(EP-04, [INGEST]): boucle d'ingestion MQTT")


def run() -> None:
    """Point d'entrée console (``queenbee-ingest``)."""
    asyncio.run(main())


if __name__ == "__main__":
    run()
