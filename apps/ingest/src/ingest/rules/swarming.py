"""Règle « swarming » : essaimage.

Chute brutale de poids (ex. > 0,5 kg en 2 h), précédée d'une dérive d'activité acoustique.

Type(s) d'alerte produit(s) : ``swarming``.
Paramètres attendus dans ``alert_threshold.params`` (exemple) : ``{"drop_kg": 0.5, "window_h": 2}``.
"""

from ingest.rules import AlertCandidate, Window


def evaluate(window: Window) -> list[AlertCandidate]:
    """Évalue la fenêtre et retourne les alertes candidates (liste vide si RAS).

    TODO(EP-04, [INGEST]): implémenter avec tests unitaires à 100 % de couverture
    (cas nominal, juste sous/au-dessus du seuil, données manquantes, déduplication).
    """
    raise NotImplementedError("TODO(EP-04, [INGEST]): règle swarming")
