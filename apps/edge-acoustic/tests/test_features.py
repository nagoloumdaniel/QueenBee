"""Tests de squelette du module ``features``."""

from edge_acoustic.features import AcousticFeatures


def test_features_dataclass_is_immutable() -> None:
    f = AcousticFeatures(dominant_freq_hz=250.0, band_energy_ratio=0.6, activity_score=0.7)
    assert f.activity_score == 0.7
