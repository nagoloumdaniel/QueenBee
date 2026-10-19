"""Publication MQTT : même point d'entrée que le matériel réel (le reste de la chaîne ne voit pas la différence).

Topics (ROADMAP §4.10) :
    queenbee/{site}/{hive}/telemetry   QoS 1
    queenbee/{site}/{hive}/status
    queenbee/{site}/gw/heartbeat
    queenbee/sim/cmd                   (commandes de pilotage)
"""

from typing import Any


class MqttClient:
    """Enveloppe fine autour d'``aiomqtt`` avec reconnexion et file locale."""

    def __init__(self, host: str, port: int, username: str = "", password: str = "") -> None:
        self.host = host
        self.port = port
        self.username = username
        self.password = password

    async def publish_telemetry(self, site: str, hive: str, frame: dict[str, Any]) -> None:
        """Publie une trame sur ``queenbee/{site}/{hive}/telemetry`` en QoS 1.

        TODO(EP-01, [SIM]): connexion, sérialisation JSON, reconnexion, option « coupure » (scénarios).
        """
        raise NotImplementedError("TODO(EP-01, [SIM]): publish_telemetry")

    async def publish_heartbeat(self, site: str, payload: dict[str, Any]) -> None:
        """Publie le heartbeat de passerelle (cpu, mem, batterie, file, perte LoRa)."""
        raise NotImplementedError("TODO(EP-01, [SIM]): publish_heartbeat")
