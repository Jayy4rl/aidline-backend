-- Retry campaign state lookups without losing event history when contract storage expires.
CREATE TABLE campaign_refresh_queue (
  campaign_id BIGINT PRIMARY KEY,
  last_error_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_attempt_at TIMESTAMPTZ,
  warned BOOLEAN NOT NULL DEFAULT false
);
CREATE TABLE pending_campaign_events (
  event_id TEXT PRIMARY KEY,
  campaign_id BIGINT NOT NULL REFERENCES campaign_refresh_queue(campaign_id),
  payload JSONB NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
