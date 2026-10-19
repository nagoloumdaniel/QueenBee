"""Règle « gps_drift » : Position GPS éloignée de ``hive.ref_position`` de plus de ``tolerance_m`` : déplacement/vol.

Type(s) d'alerte produit(s) : ``hive_moved``.
Paramètres attendus dans ``alert_threshold.params`` (exemple) : ``{"tolerance_m": 30}``.
"""

from ingest.rules import AlertCandidate, Window


def evaluate(window: Window) -> list[AlertCandidate]:
    """Évalue la fenêtre et retourne les alertes candidates (liste vide si RAS).

    TODO(EP-04, [INGEST]): implémenter avec tests unitaires à 100 % de couverture
    (cas nominal, juste sous/au-dessus du seuil, données manquantes, déduplication).
    """
    raise NotImplementedError("TODO(EP-04, [INGEST]): règle gps_drift")
