"""Règle « brood_temp » : Température interne hors de la plage du couvain (~34-35 C) : stress thermique.

Type(s) d'alerte produit(s) : ``thermal_stress``.
Paramètres attendus dans ``alert_threshold.params`` (exemple) : ``{"min_c": 32, "max_c": 36, "duration_h": 3}``.
"""

from ingest.rules import AlertCandidate, Window


def evaluate(window: Window) -> list[AlertCandidate]:
    """Évalue la fenêtre et retourne les alertes candidates (liste vide si RAS).

    TODO(EP-04, [INGEST]): implémenter avec tests unitaires à 100 % de couverture
    (cas nominal, juste sous/au-dessus du seuil, données manquantes, déduplication).
    """
    raise NotImplementedError("TODO(EP-04, [INGEST]): règle brood_temp")
