"""Environnement Alembic (async, asyncpg).

L'URL vient de ``QB_DATABASE_URL`` (12-factor). ``target_metadata`` sera branché sur la base
déclarative des modèles quand ils existeront.

TODO(EP-02, [DB]): importer ``Base.metadata`` depuis ``app.models`` ; écrire la migration 0001
(extensions postgis/timescaledb/pgcrypto/citext, types ENUM, tables, hypertables, RLS) à partir de
``db/schema/reference.sql``. Les appels Timescale (create_hypertable, policies) passent par
``op.execute`` car Alembic ne les connaît pas. Chaque migration a un downgrade testé.
"""

import asyncio
import os
from logging.config import fileConfig

from alembic import context
from sqlalchemy.engine import Connection
from sqlalchemy.ext.asyncio import create_async_engine

config = context.config
if config.config_file_name is not None:
    fileConfig(config.config_file_name)

target_metadata = None  # TODO(EP-02, [DB]): Base.metadata


def _database_url() -> str:
    url = os.environ.get("QB_DATABASE_URL", "")
    if not url:
        raise RuntimeError("QB_DATABASE_URL doit être défini pour exécuter Alembic")
    return url


def run_migrations_offline() -> None:
    """Génère le SQL sans connexion (``alembic upgrade head --sql``)."""
    context.configure(
        url=_database_url(),
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
    )
    with context.begin_transaction():
        context.run_migrations()


def _do_run_migrations(connection: Connection) -> None:
    context.configure(connection=connection, target_metadata=target_metadata)
    with context.begin_transaction():
        context.run_migrations()


async def run_migrations_online() -> None:
    """Applique les migrations via un moteur asynchrone."""
    engine = create_async_engine(_database_url())
    async with engine.connect() as connection:
        await connection.run_sync(_do_run_migrations)
    await engine.dispose()


if context.is_offline_mode():
    run_migrations_offline()
else:
    asyncio.run(run_migrations_online())
