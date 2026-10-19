# syntax=docker/dockerfile:1.7
# Image destinée aux passerelles amd64 ET arm64 (build multi-arch en CI, ROADMAP §5.3).
FROM python:3.12-slim-bookworm AS builder
ENV PIP_NO_CACHE_DIR=1 PIP_DISABLE_PIP_VERSION_CHECK=1
WORKDIR /build
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY pyproject.toml README.md ./
COPY src ./src
RUN pip install .

FROM python:3.12-slim-bookworm AS runtime
ENV PYTHONUNBUFFERED=1 PYTHONDONTWRITEBYTECODE=1 PATH="/opt/venv/bin:$PATH"
RUN groupadd --system --gid 10001 queenbee \
 && useradd --system --uid 10001 --gid queenbee --no-create-home --shell /usr/sbin/nologin queenbee
COPY --from=builder /opt/venv /opt/venv
USER 10001:10001
CMD ["queenbee-edge-acoustic"]
