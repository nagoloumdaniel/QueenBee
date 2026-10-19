"""Tests de squelette : valident que les contrats d'import et de types sont en place."""

from ingest.validators import FrameRejected, IntegrityKind


def test_integrity_kind_matches_sql_enum() -> None:
    """Les valeurs doivent rester identiques à l'ENUM SQL ``integrity_kind``."""
    assert {k.value for k in IntegrityKind} == {
        "out_of_range",
        "replay",
        "bad_signature",
        "duplicate",
        "unknown_sensor",
    }


def test_frame_rejected_carries_kind() -> None:
    err = FrameRejected(IntegrityKind.REPLAY, "seq déjà vu")
    assert err.kind is IntegrityKind.REPLAY
