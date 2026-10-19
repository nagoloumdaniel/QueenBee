-- =====================================================================================
-- QueenBee : DDL de RÉFÉRENCE (PostgreSQL 16 + PostGIS + TimescaleDB)
-- Source : ROADMAP.md §4.9, copié fidèlement. Ce fichier est la référence de lecture :
-- la vérité exécutable est la suite de migrations Alembic (apps/api/alembic/versions/).
-- Toute évolution passe par une migration réversible PUIS la mise à jour de ce fichier.
-- Ticket de mise en oeuvre : EP-02 [DB].
-- =====================================================================================

CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS timescaledb;
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS citext;

CREATE TYPE user_role AS ENUM ('beekeeper','coordinator','manager','admin');
CREATE TYPE alert_type AS ENUM ('swarming','weak_colony','thermal_stress','dead_colony','heatwave','offline_sensor','gateway_offline','hive_moved','integrity','radio_jamming');
CREATE TYPE alert_status AS ENUM ('open','acknowledged','in_progress','resolved','escalated','false_positive');
CREATE TYPE severity AS ENUM ('info','warning','critical');
CREATE TYPE harvest_status AS ENUM ('declared','validated','flagged');
CREATE TYPE visit_status AS ENUM ('planned','done','cancelled');
CREATE TYPE integrity_kind AS ENUM ('out_of_range','replay','bad_signature','duplicate','unknown_sensor');

CREATE TABLE country (
  code char(2) PRIMARY KEY, name text NOT NULL, data_residency text
);

CREATE TABLE site (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text UNIQUE NOT NULL,                -- ex SN-CASA
  name text NOT NULL,
  country_code char(2) NOT NULL REFERENCES country(code),
  location geography(Point,4326) NOT NULL,
  climate_profile text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX site_loc_gix ON site USING gist(location);

CREATE TABLE cooperative (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL, site_id uuid NOT NULL REFERENCES site(id),
  active boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE app_user (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email citext UNIQUE NOT NULL,
  password_hash text NOT NULL,              -- argon2id
  full_name_enc bytea NOT NULL,             -- pgcrypto
  phone_enc bytea,
  role user_role NOT NULL,
  mfa_secret_enc bytea, mfa_enabled boolean NOT NULL DEFAULT false,
  failed_attempts int NOT NULL DEFAULT 0, locked_until timestamptz,
  consent_at timestamptz,                   -- RGPD
  locale text NOT NULL DEFAULT 'fr',
  active boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CHECK (role = 'beekeeper' OR mfa_enabled)    -- MFA obligatoire rôles privilégiés (activée avant usage)
);

CREATE TABLE user_site (
  user_id uuid REFERENCES app_user(id) ON DELETE CASCADE,
  site_id uuid REFERENCES site(id) ON DELETE CASCADE,
  PRIMARY KEY (user_id, site_id)
);
CREATE TABLE user_cooperative (
  user_id uuid REFERENCES app_user(id) ON DELETE CASCADE,
  cooperative_id uuid REFERENCES cooperative(id) ON DELETE CASCADE,
  PRIMARY KEY (user_id, cooperative_id)
);

CREATE TABLE refresh_token (
  id uuid PRIMARY KEY, user_id uuid NOT NULL REFERENCES app_user(id) ON DELETE CASCADE,
  family_id uuid NOT NULL, token_hash text NOT NULL,
  device_id text, expires_at timestamptz NOT NULL, revoked_at timestamptz
);

CREATE TABLE gateway (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  site_id uuid NOT NULL REFERENCES site(id), serial text UNIQUE NOT NULL,
  cert_fingerprint text, last_seen timestamptz, mode text DEFAULT 'online'
);
CREATE TABLE gateway_heartbeat (
  gateway_id uuid NOT NULL REFERENCES gateway(id), ts timestamptz NOT NULL,
  cpu_pct real, mem_pct real, battery_pct real, queue_depth int, lora_loss_pct real,
  PRIMARY KEY (gateway_id, ts)
);
SELECT create_hypertable('gateway_heartbeat','ts', chunk_time_interval => interval '7 days');

CREATE TABLE hive (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text UNIQUE NOT NULL,                -- ex SN-CASA-014
  site_id uuid NOT NULL REFERENCES site(id),
  cooperative_id uuid NOT NULL REFERENCES cooperative(id),
  owner_id uuid REFERENCES app_user(id),
  ref_position geography(Point,4326) NOT NULL,
  tolerance_m int NOT NULL DEFAULT 30,
  sensor_key_hash text,                     -- authentification capteur
  qr_token text UNIQUE NOT NULL,
  status text NOT NULL DEFAULT 'active',
  installed_at date, deleted_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(), updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX hive_site_idx ON hive(site_id);
CREATE INDEX hive_pos_gix ON hive USING gist(ref_position);

CREATE TABLE measurement (
  hive_id uuid NOT NULL REFERENCES hive(id),
  ts timestamptz NOT NULL,
  seq int NOT NULL,                         -- compteur anti-rejeu
  position geography(Point,4326),
  weight_kg real, temp_internal_c real, temp_external_c real,
  humidity_pct real, acoustic_activity real, battery_pct real,
  received_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (hive_id, ts, seq)
);
SELECT create_hypertable('measurement','ts', chunk_time_interval => interval '7 days');
ALTER TABLE measurement SET (timescaledb.compress, timescaledb.compress_segmentby='hive_id');
SELECT add_compression_policy('measurement', interval '30 days');
SELECT add_retention_policy('measurement', interval '3 years');
CREATE MATERIALIZED VIEW measurement_hourly WITH (timescaledb.continuous) AS
  SELECT hive_id, time_bucket('1 hour', ts) AS bucket,
         avg(weight_kg) w_avg, min(weight_kg) w_min, max(weight_kg) w_max,
         avg(temp_internal_c) t_int, avg(humidity_pct) hum, avg(acoustic_activity) ac
  FROM measurement GROUP BY hive_id, bucket;

CREATE TABLE integrity_event (
  id bigserial PRIMARY KEY, hive_id uuid, gateway_id uuid, kind integrity_kind NOT NULL,
  payload jsonb, detected_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE alert_threshold (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  site_id uuid REFERENCES site(id), alert_type alert_type NOT NULL,
  params jsonb NOT NULL,                    -- ex {"drop_kg":0.5,"window_h":2}
  UNIQUE (site_id, alert_type)
);

CREATE TABLE alert (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  hive_id uuid REFERENCES hive(id), gateway_id uuid REFERENCES gateway(id),
  type alert_type NOT NULL, severity severity NOT NULL,
  confidence real CHECK (confidence BETWEEN 0 AND 1),
  health_score smallint CHECK (health_score BETWEEN 0 AND 100),
  recommendation text, status alert_status NOT NULL DEFAULT 'open',
  detected_at timestamptz NOT NULL DEFAULT now(),
  acknowledged_by uuid REFERENCES app_user(id), acknowledged_at timestamptz,
  resolved_at timestamptz, source text NOT NULL DEFAULT 'rules',   -- rules|ml|infra
  dedup_key text UNIQUE
);
CREATE INDEX alert_status_idx ON alert(status, severity, detected_at DESC);

CREATE TABLE visit_plan (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  hive_id uuid NOT NULL REFERENCES hive(id), assignee_id uuid NOT NULL REFERENCES app_user(id),
  created_by uuid NOT NULL REFERENCES app_user(id), alert_id uuid REFERENCES alert(id),
  planned_for date NOT NULL, status visit_status NOT NULL DEFAULT 'planned'
);

CREATE TABLE inspection (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  client_uuid uuid UNIQUE NOT NULL,         -- idempotence sync
  hive_id uuid NOT NULL REFERENCES hive(id), author_id uuid NOT NULL REFERENCES app_user(id),
  inspected_at timestamptz NOT NULL, visual_state text, queen_present boolean,
  behavior text, notes text, anomaly boolean NOT NULL DEFAULT false,
  visit_plan_id uuid REFERENCES visit_plan(id),
  version int NOT NULL DEFAULT 1, synced_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(), updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX inspection_hive_idx ON inspection(hive_id, inspected_at DESC);
CREATE TABLE inspection_photo (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  inspection_id uuid NOT NULL REFERENCES inspection(id) ON DELETE CASCADE,
  storage_key text NOT NULL, bytes int, sha256 text
);

CREATE TABLE harvest (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  client_uuid uuid UNIQUE NOT NULL, hive_id uuid NOT NULL REFERENCES hive(id),
  declared_by uuid NOT NULL REFERENCES app_user(id),
  harvested_on date NOT NULL, volume_kg numeric(8,2) NOT NULL CHECK (volume_kg >= 0),
  predicted_kg numeric(8,2), gap_pct numeric(6,2),
  status harvest_status NOT NULL DEFAULT 'declared',
  validated_by uuid REFERENCES app_user(id), validated_at timestamptz,
  version int NOT NULL DEFAULT 1
);

CREATE TABLE hive_move (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  hive_id uuid NOT NULL REFERENCES hive(id), declared boolean NOT NULL,
  declared_by uuid REFERENCES app_user(id), from_pos geography(Point,4326),
  to_pos geography(Point,4326), valid_from timestamptz, valid_to timestamptz
);

CREATE TABLE sync_cursor (
  user_id uuid, device_id text, last_pulled_at timestamptz, PRIMARY KEY(user_id, device_id)
);

CREATE TABLE deployment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(), site_id uuid REFERENCES site(id),
  version text NOT NULL, git_sha text, started_at timestamptz, finished_at timestamptz,
  status text NOT NULL, rollback_of uuid REFERENCES deployment(id), log_url text
);   -- alimente le dashboard DevOps et le KPI > 95 %

CREATE TABLE audit_log (
  id bigserial PRIMARY KEY, ts timestamptz NOT NULL DEFAULT now(),
  actor_id uuid, action text NOT NULL, entity text, entity_id text,
  ip inet, details jsonb
);   -- append-only (REVOKE UPDATE, DELETE)

-- Row Level Security par site
ALTER TABLE hive ENABLE ROW LEVEL SECURITY;
CREATE POLICY hive_site_policy ON hive USING (
  site_id IN (SELECT site_id FROM user_site WHERE user_id = current_setting('app.user_id')::uuid)
  OR current_setting('app.role') IN ('manager','admin')
);
