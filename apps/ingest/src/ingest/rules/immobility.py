"""Règle « immobility » : Absence de variation du poids/activité (colonie morte) ou capteur muet (offline_sensor).

Type(s) d'alerte produit(s) : ``dead_colony/offline_sensor``.
Paramètres attendus dans ``alert_threshold.params`` (exemple) : ``{"flat_h": 48}``.
"""

from ingest.rules import AlertCandidate, Window


def evaluate(window: Window) -> list[AlertCandidate]:
    """Évalue la fenêtre et retourne les alertes candidates (liste vide si RAS).

    TODO(EP-04, [INGEST]): implémenter avec tests unitaires à 100 % de couverture
    (cas nominal, juste sous/au-dessus du seuil, données manquantes, déduplication).
    """
    raise NotImplementedError("TODO(EP-04, [INGEST]): règle immobility")
