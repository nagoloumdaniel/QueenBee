# Makefile QueenBee - commandes du quotidien. `make help` pour la liste.
# Sous Windows : Git Bash ou WSL. Les chemins des fichiers Compose font foi (infra/compose/).

SHELL := /bin/bash
.DEFAULT_GOAL := help

COMPOSE_DEV := docker compose --env-file .env -f infra/compose/dev.yml
COMPOSE_E2E := docker compose -f infra/compose/e2e.yml
PY_APPS     := apps/api apps/ingest apps/simulator apps/edge-acoustic

# Commande de chargement des données de démo (EP-02 [DB] : script à écrire, voir db/seeds/README.md)
SEED_CMD    := python -m app.seeds

.PHONY: help up down logs ps seed sim test test-py test-web test-mobile lint lint-py lint-web lint-mobile fmt e2e

help: ## Affiche cette aide
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[33m%-14s\033[0m %s\n", $$1, $$2}'

# ------------------------------------------------------------------ Stack locale
up: ## Démarre la stack de dev (base, broker, API, ingestion, simulateur, monitoring, n8n)
	@test -f .env || { echo "Fichier .env manquant : cp .env.example .env (puis renseigner les valeurs vides)"; exit 1; }
	$(COMPOSE_DEV) up -d --build

down: ## Arrête la stack de dev (les volumes sont conservés)
	$(COMPOSE_DEV) down

logs: ## Suit les journaux (make logs S=api pour un service)
	$(COMPOSE_DEV) logs -f --tail=100 $(S)

ps: ## Liste les conteneurs de la stack
	$(COMPOSE_DEV) ps

seed: ## Charge les données de démo (sites, coopératives, 400 ruches, utilisateurs)
	$(COMPOSE_DEV) run --rm api $(SEED_CMD)

sim: ## Démarre le simulateur de capteurs (accélération réglée par SIM_SPEED dans dev.yml)
	$(COMPOSE_DEV) up -d --build simulator

# ------------------------------------------------------------------ Tests
test: test-py test-web test-mobile ## Tests unitaires de toutes les applications

test-py: ## Tests Python (api, ingest, simulator, edge-acoustic)
	@for d in $(PY_APPS); do echo "== $$d"; (cd $$d && pytest -q) || exit 1; done

test-web: ## Tests Vitest de apps/web
	cd apps/web && npm test

test-mobile: ## Tests Flutter de apps/mobile
	@if command -v flutter >/dev/null 2>&1; then cd apps/mobile && flutter test; else echo "AVERTISSEMENT : flutter absent, tests mobile non exécutés"; fi

e2e: ## Stack e2e (Compose) + Playwright web, puis nettoyage
	$(COMPOSE_E2E) up -d --build --wait
	cd apps/web && BASE_URL=$${BASE_URL:-http://localhost:3000} npm run e2e; status=$$?; cd ../..; $(COMPOSE_E2E) down -v; exit $$status

# ------------------------------------------------------------------ Qualité
lint: lint-py lint-web lint-mobile ## Lint + types de toutes les applications

lint-py: ## ruff + mypy (Python)
	@for d in $(PY_APPS); do echo "== $$d"; (cd $$d && ruff check . && mypy) || exit 1; done

lint-web: ## ESLint + tsc (web)
	cd apps/web && npm run lint && npm run typecheck

lint-mobile: ## flutter analyze (mobile)
	@if command -v flutter >/dev/null 2>&1; then cd apps/mobile && flutter analyze; else echo "AVERTISSEMENT : flutter absent, analyse mobile non exécutée"; fi

fmt: ## Formate le code (ruff --fix + black, prettier, dart format)
	@for d in $(PY_APPS); do (cd $$d && ruff check --fix . && black --line-length 120 .); done
	cd apps/web && npm run format
	@if command -v dart >/dev/null 2>&1; then cd apps/mobile && dart format .; else echo "AVERTISSEMENT : dart absent, formatage mobile ignoré"; fi
