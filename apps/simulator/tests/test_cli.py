"""Tests de squelette : le parseur CLI et les fichiers de configuration sont cohérents."""

from pathlib import Path

import yaml

from simulator.cli import build_parser

ROOT = Path(__file__).resolve().parents[1]


def test_cli_parser_accepts_run() -> None:
    args = build_parser().parse_args(["run", "--sites", "SN-CASA", "--speed", "60"])
    assert args.command == "run"
    assert args.speed == 60.0


def test_sites_yaml_has_8_sites_in_3_countries_and_400_hives() -> None:
    data = yaml.safe_load((ROOT / "config" / "sites.yaml").read_text(encoding="utf-8"))
    sites = data["sites"]
    assert len(sites) == 8
    assert {s["country"] for s in sites} == {"SN", "CI", "CM"}
    assert sum(s["hives"] for s in sites) == 400


def test_humans_shares_sum_to_one() -> None:
    data = yaml.safe_load((ROOT / "config" / "humans.yaml").read_text(encoding="utf-8"))
    assert abs(sum(p["share"] for p in data["profiles"]) - 1.0) < 1e-9


def test_seven_minimum_scenarios_present() -> None:
    files = sorted((ROOT / "scenarios").glob("*.yaml"))
    assert len(files) >= 7
    for f in files:
        scenario = yaml.safe_load(f.read_text(encoding="utf-8"))
        assert {"scenario", "target", "timeline", "ground_truth"} <= scenario.keys()
