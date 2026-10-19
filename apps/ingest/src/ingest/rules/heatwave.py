"""Règle « heatwave » : Température externe élevée prolongée : alerte de canicule pour le site.

Type(s) d'alerte produit(s) : ``heatwave``.
Paramètres attendus dans ``alert_threshold.params`` (exemple) : ``{"temp_c": 40, "duration_h": 4}``.
"""

from ingest.rules import AlertCandidate, Window


def evaluate(window: Window) -> list[AlertCandidate]:
    """Évalue la fenêtre et retourne les alertes candidates (liste vide si RAS).

    TODO(EP-04, [INGEST]): implémenter avec tests unitaires à 100 % de couverture
    (cas nominal, juste sous/au-dessus du seuil, données manquantes, déduplication).
    """
    raise NotImplementedError("TODO(EP-04, [INGEST]): règle heatwave")
