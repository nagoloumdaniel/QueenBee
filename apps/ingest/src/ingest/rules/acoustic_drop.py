"""Règle « acoustic_drop » : Chute durable de l'activité acoustique (colonie affaiblie).

Type(s) d'alerte produit(s) : ``weak_colony``.
Paramètres attendus dans ``alert_threshold.params`` (exemple) : ``{"drop_pct": 40, "window_h": 24}``.
"""

from ingest.rules import AlertCandidate, Window


def evaluate(window: Window) -> list[AlertCandidate]:
    """Évalue la fenêtre et retourne les alertes candidates (liste vide si RAS).

    TODO(EP-04, [INGEST]): implémenter avec tests unitaires à 100 % de couverture
    (cas nominal, juste sous/au-dessus du seuil, données manquantes, déduplication).
    """
    raise NotImplementedError("TODO(EP-04, [INGEST]): règle acoustic_drop")
