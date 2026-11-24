-- MyWorld Initial Database Schema
-- Migration: 00001_initial_schema
-- Description: Creates all core tables, indexes, and RLS policies

-- ============================================================
-- Enable required extensions
-- ============================================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- PROFILES
-- ============================================================
CREATE TABLE public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username TEXT UNIQUE,
  display_name TEXT,
  avatar_path TEXT,
  bio TEXT,
  home_location_lat DOUBLE PRECISION,
  home_location_lng DOUBLE PRECISION,
  home_country_code CHAR(2),
  home_city TEXT,
  birthplace_lat DOUBLE PRECISION,
  birthplace_lng DOUBLE PRECISION,
  birthplace_country_code CHAR(2),
  birthplace_city TEXT,
  onboarding_completed BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_profiles_username ON public.profiles(username);

-- ============================================================
-- COUNTRIES (reference data)
-- ============================================================
CREATE TABLE public.countries (
  code CHAR(2) PRIMARY KEY,
  name TEXT NOT NULL,
  continent TEXT NOT NULL,
  flag_emoji TEXT NOT NULL
);

-- ============================================================
-- CITIES
-- ============================================================
CREATE TABLE public.cities (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  country_code CHAR(2) NOT NULL REFERENCES public.countries(code),
  name TEXT NOT NULL,
  latitude DOUBLE PRECISION NOT NULL,
  longitude DOUBLE PRECISION NOT NULL,
  external_place_id TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(name, country_code, latitude, longitude)
);

CREATE INDEX idx_cities_country ON public.cities(country_code);
CREATE INDEX idx_cities_name ON public.cities(name);

-- ============================================================
-- TRIPS
-- ============================================================
CREATE TABLE public.trips (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  start_date DATE,
  end_date DATE,
  status TEXT NOT NULL DEFAULT 'planning' CHECK (status IN ('planning', 'ongoing', 'completed')),
  cover_image_path TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT valid_date_range CHECK (end_date IS NULL OR start_date IS NULL OR end_date >= start_date)
);

CREATE INDEX idx_trips_user ON public.trips(user_id);
CREATE INDEX idx_trips_status ON public.trips(user_id, status);
CREATE INDEX idx_trips_dates ON public.trips(user_id, start_date DESC);

-- ============================================================
-- COUNTRY VISITS
-- ============================================================
CREATE TABLE public.country_visits (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  country_code CHAR(2) NOT NULL REFERENCES public.countries(code),
  trip_id UUID REFERENCES public.trips(id) ON DELETE SET NULL,
  visited_from DATE,
  visited_to DATE,
  notes TEXT,
  rating SMALLINT CHECK (rating IS NULL OR (rating >= 1 AND rating <= 5)),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT valid_visit_range CHECK (visited_to IS NULL OR visited_from IS NULL OR visited_to >= visited_from)
);

CREATE INDEX idx_country_visits_user ON public.country_visits(user_id);
CREATE INDEX idx_country_visits_country ON public.country_visits(user_id, country_code);
CREATE INDEX idx_country_visits_trip ON public.country_visits(trip_id);

-- ============================================================
-- COUNTRY STATUS (user's relationship with a country)
-- ============================================================
CREATE TABLE public.country_status (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  country_code CHAR(2) NOT NULL REFERENCES public.countries(code),
  status TEXT NOT NULL CHECK (status IN ('visited', 'partially_explored', 'want_to_visit', 'current_home', 'previous_home')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(user_id, country_code)
);

CREATE INDEX idx_country_status_user ON public.country_status(user_id);

-- ============================================================
-- PLACES
-- ============================================================
CREATE TABLE public.places (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT,
  country_code CHAR(2) REFERENCES public.countries(code),
  city_id UUID REFERENCES public.cities(id) ON DELETE SET NULL,
  city_name TEXT,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  category TEXT NOT NULL DEFAULT 'other' CHECK (category IN (
    'city', 'nature', 'architecture', 'historical', 'restaurant',
    'accommodation', 'mountain', 'beach', 'museum', 'adventure',
    'personal', 'other'
  )),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_places_user ON public.places(user_id);
CREATE INDEX idx_places_country ON public.places(user_id, country_code);
CREATE INDEX idx_places_category ON public.places(user_id, category);
CREATE INDEX idx_places_coords ON public.places(latitude, longitude);

-- ============================================================
-- PLACE VISITS
-- ============================================================
CREATE TABLE public.place_visits (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  place_id UUID NOT NULL REFERENCES public.places(id) ON DELETE CASCADE,
  trip_id UUID REFERENCES public.trips(id) ON DELETE SET NULL,
  visited_at DATE,
  notes TEXT,
  rating SMALLINT CHECK (rating IS NULL OR (rating >= 1 AND rating <= 5)),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_place_visits_user ON public.place_visits(user_id);
CREATE INDEX idx_place_visits_place ON public.place_visits(place_id);
CREATE INDEX idx_place_visits_trip ON public.place_visits(trip_id);

-- ============================================================
-- MEMORIES
-- ============================================================
CREATE TABLE public.memories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  trip_id UUID REFERENCES public.trips(id) ON DELETE SET NULL,
  place_id UUID REFERENCES public.places(id) ON DELETE SET NULL,
  title TEXT NOT NULL,
  content TEXT,
  mood TEXT CHECK (mood IS NULL OR mood IN (
    'happy', 'excited', 'peaceful', 'grateful', 'nostalgic',
    'adventurous', 'romantic', 'reflective', 'inspired', 'bittersweet'
  )),
  memory_date DATE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_memories_user ON public.memories(user_id);
CREATE INDEX idx_memories_trip ON public.memories(trip_id);
CREATE INDEX idx_memories_place ON public.memories(place_id);
CREATE INDEX idx_memories_date ON public.memories(user_id, memory_date DESC);

-- ============================================================
-- PHOTOS
-- ============================================================
CREATE TABLE public.photos (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  memory_id UUID REFERENCES public.memories(id) ON DELETE SET NULL,
  trip_id UUID REFERENCES public.trips(id) ON DELETE SET NULL,
  place_id UUID REFERENCES public.places(id) ON DELETE SET NULL,
  storage_path TEXT NOT NULL,
  caption TEXT,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  taken_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_photos_user ON public.photos(user_id);
CREATE INDEX idx_photos_memory ON public.photos(memory_id);
CREATE INDEX idx_photos_trip ON public.photos(trip_id);
CREATE INDEX idx_photos_place ON public.photos(place_id);
CREATE INDEX idx_photos_taken ON public.photos(user_id, taken_at DESC);

-- ============================================================
-- WISHLIST ITEMS
-- ============================================================
CREATE TABLE public.wishlist_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  country_code CHAR(2) REFERENCES public.countries(code),
  city_id UUID REFERENCES public.cities(id) ON DELETE SET NULL,
  city_name TEXT,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  category TEXT DEFAULT 'other' CHECK (category IS NULL OR category IN (
    'city', 'nature', 'architecture', 'historical', 'restaurant',
    'accommodation', 'mountain', 'beach', 'museum', 'adventure',
    'personal', 'other'
  )),
  priority TEXT NOT NULL DEFAULT 'medium' CHECK (priority IN ('low', 'medium', 'high', 'dream')),
  notes TEXT,
  photo_path TEXT,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'completed')),
  completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_wishlist_user ON public.wishlist_items(user_id);
CREATE INDEX idx_wishlist_status ON public.wishlist_items(user_id, status);
CREATE INDEX idx_wishlist_priority ON public.wishlist_items(user_id, priority);

-- ============================================================
-- TRIP COUNTRIES (many-to-many)
-- ============================================================
CREATE TABLE public.trip_countries (
  trip_id UUID NOT NULL REFERENCES public.trips(id) ON DELETE CASCADE,
  country_code CHAR(2) NOT NULL REFERENCES public.countries(code),
  PRIMARY KEY (trip_id, country_code)
);

-- ============================================================
-- MEMORY TAGS
-- ============================================================
CREATE TABLE public.tags (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(user_id, name)
);

CREATE TABLE public.memory_tags (
  memory_id UUID NOT NULL REFERENCES public.memories(id) ON DELETE CASCADE,
  tag_id UUID NOT NULL REFERENCES public.tags(id) ON DELETE CASCADE,
  PRIMARY KEY (memory_id, tag_id)
);

-- ============================================================
-- USER SETTINGS
-- ============================================================
CREATE TABLE public.user_settings (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  theme TEXT NOT NULL DEFAULT 'system' CHECK (theme IN ('light', 'dark', 'system')),
  language TEXT NOT NULL DEFAULT 'en',
  privacy_profile_public BOOLEAN NOT NULL DEFAULT FALSE,
  privacy_show_countries BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- UPDATED_AT TRIGGER FUNCTION
-- ============================================================
CREATE OR REPLACE FUNCTION public.update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply to tables with updated_at
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.trips
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.places
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.memories
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.country_status
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.user_settings
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- ============================================================
-- AUTO-CREATE PROFILE ON SIGNUP
-- ============================================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id)
  VALUES (NEW.id);
  
  INSERT INTO public.user_settings (user_id)
  VALUES (NEW.id);
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================

-- Profiles: users can read/update their own profile
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own profile"
  ON public.profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON public.profiles FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Countries: public read-only reference data
ALTER TABLE public.countries ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Countries are publicly readable"
  ON public.countries FOR SELECT
  USING (true);

-- Cities: public read, authenticated insert
ALTER TABLE public.cities ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Cities are publicly readable"
  ON public.cities FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can insert cities"
  ON public.cities FOR INSERT
  WITH CHECK (auth.uid() IS NOT NULL);

-- Trips: users own their trips
ALTER TABLE public.trips ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can CRUD own trips"
  ON public.trips FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Country visits: users own their visits
ALTER TABLE public.country_visits ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can CRUD own country visits"
  ON public.country_visits FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Country status: users own their statuses
ALTER TABLE public.country_status ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can CRUD own country status"
  ON public.country_status FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Places: users own their places
ALTER TABLE public.places ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can CRUD own places"
  ON public.places FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Place visits: users own their place visits
ALTER TABLE public.place_visits ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can CRUD own place visits"
  ON public.place_visits FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Memories: users own their memories
ALTER TABLE public.memories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can CRUD own memories"
  ON public.memories FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Photos: users own their photos
ALTER TABLE public.photos ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can CRUD own photos"
  ON public.photos FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Wishlist items: users own their wishlist
ALTER TABLE public.wishlist_items ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can CRUD own wishlist items"
  ON public.wishlist_items FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Trip countries: access through trip ownership
ALTER TABLE public.trip_countries ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage trip countries via trip ownership"
  ON public.trip_countries FOR ALL
  USING (EXISTS (
    SELECT 1 FROM public.trips WHERE trips.id = trip_countries.trip_id AND trips.user_id = auth.uid()
  ))
  WITH CHECK (EXISTS (
    SELECT 1 FROM public.trips WHERE trips.id = trip_countries.trip_id AND trips.user_id = auth.uid()
  ));

-- Tags: users own their tags
ALTER TABLE public.tags ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can CRUD own tags"
  ON public.tags FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Memory tags: access through memory ownership
ALTER TABLE public.memory_tags ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can manage memory tags via memory ownership"
  ON public.memory_tags FOR ALL
  USING (EXISTS (
    SELECT 1 FROM public.memories WHERE memories.id = memory_tags.memory_id AND memories.user_id = auth.uid()
  ))
  WITH CHECK (EXISTS (
    SELECT 1 FROM public.memories WHERE memories.id = memory_tags.memory_id AND memories.user_id = auth.uid()
  ));

-- User settings: users own their settings
ALTER TABLE public.user_settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can CRUD own settings"
  ON public.user_settings FOR ALL
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- ============================================================
-- STORAGE BUCKETS (run in Supabase Dashboard or via API)
-- Note: These are documented here but must be created via
-- the Supabase Dashboard or Management API
-- ============================================================
-- Bucket: memory-photos (private)
-- Bucket: trip-covers (private)
-- Bucket: profile-images (private)
-- 
-- Storage policies should restrict access to:
--   auth.uid()::text = (storage.foldername(name))[1]
-- So each user can only access their own folder.
