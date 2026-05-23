-- ============================================================
-- RIDER EVENT HUB — Supabase Setup Script
-- Run this ONCE in Supabase → SQL Editor → New query
-- ============================================================

-- 1. Events table
CREATE TABLE IF NOT EXISTS events (
  id           BIGSERIAL PRIMARY KEY,
  title        TEXT NOT NULL,
  description  TEXT DEFAULT '',
  category     TEXT DEFAULT 'Other',
  date         DATE,
  start_time   TEXT DEFAULT '',
  end_time     TEXT DEFAULT '',
  location     TEXT DEFAULT '',
  organizer    TEXT DEFAULT '',
  organizer_email TEXT DEFAULT '',
  rsvp_link    TEXT DEFAULT '',
  status       TEXT DEFAULT 'pending',
  featured     BOOLEAN DEFAULT false,
  food_info    TEXT DEFAULT '',
  rsvp_count   INT DEFAULT 0,
  capacity     INT DEFAULT 0,
  view_count   INT DEFAULT 0,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Comments table
CREATE TABLE IF NOT EXISTS comments (
  id         BIGSERIAL PRIMARY KEY,
  event_id   BIGINT NOT NULL REFERENCES events(id) ON DELETE CASCADE,
  author     TEXT NOT NULL,
  text       TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Atomic increment functions (safe for concurrent updates)
CREATE OR REPLACE FUNCTION increment_view_count(event_id BIGINT)
RETURNS void LANGUAGE SQL AS $$
  UPDATE events SET view_count = COALESCE(view_count, 0) + 1 WHERE id = event_id;
$$;

CREATE OR REPLACE FUNCTION increment_rsvp_count(event_id BIGINT)
RETURNS void LANGUAGE SQL AS $$
  UPDATE events SET rsvp_count = COALESCE(rsvp_count, 0) + 1 WHERE id = event_id;
$$;

-- 4. Disable RLS so the anon key can read/write freely
--    (Admin actions are protected by the password hash in the app)
ALTER TABLE events  DISABLE ROW LEVEL SECURITY;
ALTER TABLE comments DISABLE ROW LEVEL SECURITY;

-- Done! You can now copy your Supabase URL and anon key into index.html
