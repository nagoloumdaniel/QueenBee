# syntax=docker/dockerfile:1.7
# Image API QueenBee : multi-stage, utilisateur non-root, sans outils de build à l'exécution.

# ---- Étape 1 : construction des dépendances dans un venv ----
FROM python:3.12-slim-bookworm AS builder
ENV PIP_NO_CACHE_DIR=1 PIP_DISABLE_PIP_VERSION_CHECK=1
WORKDIR /build
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY pyproject.toml README.md ./
COPY app ./app
RUN pip install .

# ---- Étape 2 : image d'exécution minimale ----
FROM python:3.12-slim-bookworm AS runtime
ENV PYTHONUNBUFFERED=1 PYTHONDONTWRITEBYTECODE=1 PATH="/opt/venv/bin:$PATH"
RUN groupadd --system --gid 10001 queenbee \
 && useradd --system --uid 10001 --gid queenbee --no-create-home --shell /usr/sbin/nologin queenbee
COPY --from=builder /opt/venv /opt/venv
WORKDIR /srv
COPY --chown=queenbee:queenbee app ./app
COPY --chown=queenbee:queenbee alembic ./alembic
COPY --chown=queenbee:queenbee alembic.ini ./alembic.ini
USER 10001:10001
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://127.0.0.1:8000/health', timeout=2).status == 200 else 1)"
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
