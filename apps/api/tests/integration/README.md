# Tests d'intégration

Ici : tests avec une vraie base (Testcontainers `timescale/timescaledb-ha:pg16`, avec PostGIS) :
migrations up/down, RLS (un utilisateur du site A ne lit pas le site B), repositories, sync.

Marqueur : `@pytest.mark.integration`. Lancer : `pytest -m integration` (Docker requis).

Tickets : EP-02 [DB] (migrations, RLS), EP-03 [AUTH] (matrice IDOR par rôle), EP-06 [API].
