"""Extraction de features d'un échantillon audio court (10 s) par FFT.

Contrainte radio (CDC §6.4) : seul un vecteur compact (~8 octets) est transmis ; le signal brut
n'est JAMAIS envoyé ni stocké (ROADMAP §1, réduction de surface d'attaque).
"""

from dataclasses import dataclass

import numpy as np
from numpy.typing import NDArray


@dataclass(frozen=True)
class AcousticFeatures:
    """Vecteur de features compact associé à un échantillon."""

    dominant_freq_hz: float
    band_energy_ratio: float  # énergie 200-600 Hz (bourdonnement) / énergie totale
    activity_score: float  # 0..1, alimente ``acoustic_activity_score`` de la trame


def extract_features(samples: NDArray[np.float32], sample_rate_hz: int) -> AcousticFeatures:
    """Calcule la FFT (fenêtre de Hann) et en déduit les features.

    TODO(EP-05, [EDGE]): implémenter avec numpy.fft.rfft, test sur sinusoïde synthétique
    (fréquence dominante connue) et sur silence (score ~0).
    """
    raise NotImplementedError("TODO(EP-05, [EDGE]): extract_features")


def encode_features(features: AcousticFeatures) -> bytes:
    """Encode les features sur ~8 octets (quantification) pour la trame LoRaWAN.

    TODO(EP-05, [EDGE]): format binaire documenté + décodeur côté ingestion.
    """
    raise NotImplementedError("TODO(EP-05, [EDGE]): encode_features")
