-- Enable extensions for geospatial calculations and text search
CREATE EXTENSION IF NOT EXISTS cube;
CREATE EXTENSION IF NOT EXISTS earthdistance;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE TABLE IF NOT EXISTS electricians (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    license_number TEXT,
    phone TEXT NOT NULL,
    email TEXT,
    city TEXT NOT NULL,
    state CHAR(2) NOT NULL,
    zip TEXT NOT NULL,
    services TEXT[] NOT NULL DEFAULT '{}',
    rating REAL NOT NULL DEFAULT 0.0,
    review_count INTEGER NOT NULL DEFAULT 0,
    emergency BOOLEAN NOT NULL DEFAULT FALSE,
    website TEXT,
    lat DOUBLE PRECISION,
    lon DOUBLE PRECISION,
    last_verified TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Index for geospatial search
CREATE INDEX IF NOT EXISTS idx_electricians_location ON electricians USING gist (ll_to_earth(lat, lon));

-- Index for common filters
CREATE INDEX IF NOT EXISTS idx_electricians_city_state ON electricians (city, state);
CREATE INDEX IF NOT EXISTS idx_electricians_emergency ON electricians (emergency) WHERE emergency = TRUE;

-- Trigram indexes for fast ILIKE search
CREATE INDEX IF NOT EXISTS idx_electricians_name_trgm ON electricians USING gin (name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_electricians_city_trgm ON electricians USING gin (city gin_trgm_ops);
