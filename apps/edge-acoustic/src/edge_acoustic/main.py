"""Point d'entrée du service : acquisition -> features -> publication MQTT locale.

TODO(EP-05, [EDGE]): lire l'échantillon (micro ou fichier simulé fourni par le simulateur),
appeler ``features.extract_features``, publier sur le broker de site (Mosquitto). Échantillonnage
adaptatif : 1 échantillon / 30 min, 1 / 10 min en surveillance renforcée.
"""


def run() -> None:
    """Point d'entrée console (``queenbee-edge-acoustic``)."""
    raise NotImplementedError("TODO(EP-05, [EDGE]): boucle d'acquisition")


if __name__ == "__main__":
    run()
