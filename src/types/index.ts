// Database types for MyWorld
// These should eventually be generated from the Supabase schema

export type CountryCode = string; // ISO 3166-1 alpha-2

export type TripStatus = "planning" | "ongoing" | "completed";

export type CountryStatusType =
  | "visited"
  | "partially_explored"
  | "want_to_visit"
  | "current_home"
  | "previous_home";

export type PlaceCategory =
  | "city"
  | "nature"
  | "architecture"
  | "historical"
  | "restaurant"
  | "accommodation"
  | "mountain"
  | "beach"
  | "museum"
  | "adventure"
  | "personal"
  | "other";

export type WishlistPriority = "low" | "medium" | "high" | "dream";
export type WishlistStatus = "pending" | "completed";

export type Mood =
  | "happy"
  | "excited"
  | "peaceful"
  | "grateful"
  | "nostalgic"
  | "adventurous"
  | "romantic"
  | "reflective"
  | "inspired"
  | "bittersweet";

// ============================================================
// Database row types
// ============================================================

export interface Profile {
  id: string;
  username: string | null;
  display_name: string | null;
  avatar_path: string | null;
  bio: string | null;
  home_location_lat: number | null;
  home_location_lng: number | null;
  home_country_code: CountryCode | null;
  home_city: string | null;
  birthplace_lat: number | null;
  birthplace_lng: number | null;
  birthplace_country_code: CountryCode | null;
  birthplace_city: string | null;
  onboarding_completed: boolean;
  created_at: string;
  updated_at: string;
}

export interface Country {
  code: CountryCode;
  name: string;
  continent: string;
  flag_emoji: string;
}

export interface City {
  id: string;
  country_code: CountryCode;
  name: string;
  latitude: number;
  longitude: number;
  external_place_id: string | null;
  created_at: string;
}

export interface Trip {
  id: string;
  user_id: string;
  title: string;
  description: string | null;
  start_date: string | null;
  end_date: string | null;
  status: TripStatus;
  cover_image_path: string | null;
  created_at: string;
  updated_at: string;
}

export interface CountryVisit {
  id: string;
  user_id: string;
  country_code: CountryCode;
  trip_id: string | null;
  visited_from: string | null;
  visited_to: string | null;
  notes: string | null;
  rating: number | null;
  created_at: string;
}

export interface CountryStatus {
  id: string;
  user_id: string;
  country_code: CountryCode;
  status: CountryStatusType;
  created_at: string;
  updated_at: string;
}

export interface Place {
  id: string;
  user_id: string;
  name: string;
  description: string | null;
  country_code: CountryCode | null;
  city_id: string | null;
  city_name: string | null;
  latitude: number | null;
  longitude: number | null;
  category: PlaceCategory;
  created_at: string;
  updated_at: string;
}

export interface PlaceVisit {
  id: string;
  user_id: string;
  place_id: string;
  trip_id: string | null;
  visited_at: string | null;
  notes: string | null;
  rating: number | null;
  created_at: string;
}

export interface Memory {
  id: string;
  user_id: string;
  trip_id: string | null;
  place_id: string | null;
  title: string;
  content: string | null;
  mood: Mood | null;
  memory_date: string | null;
  created_at: string;
  updated_at: string;
}

export interface Photo {
  id: string;
  user_id: string;
  memory_id: string | null;
  trip_id: string | null;
  place_id: string | null;
  storage_path: string;
  caption: string | null;
  latitude: number | null;
  longitude: number | null;
  taken_at: string | null;
  created_at: string;
}

export interface WishlistItem {
  id: string;
  user_id: string;
  name: string;
  country_code: CountryCode | null;
  city_id: string | null;
  city_name: string | null;
  latitude: number | null;
  longitude: number | null;
  category: PlaceCategory | null;
  priority: WishlistPriority;
  notes: string | null;
  photo_path: string | null;
  status: WishlistStatus;
  completed_at: string | null;
  created_at: string;
}

export interface Tag {
  id: string;
  user_id: string;
  name: string;
  created_at: string;
}

export interface UserSettings {
  user_id: string;
  theme: "light" | "dark" | "system";
  language: string;
  privacy_profile_public: boolean;
  privacy_show_countries: boolean;
  created_at: string;
  updated_at: string;
}

// ============================================================
// Extended types with relations
// ============================================================

export interface CountryWithStatus extends Country {
  status?: CountryStatusType;
  visit_count?: number;
}

export interface TripWithDetails extends Trip {
  countries?: Country[];
  place_count?: number;
  photo_count?: number;
  memory_count?: number;
}

export interface PlaceWithDetails extends Place {
  country?: Country;
  visit_count?: number;
  photos?: Photo[];
}

export interface MemoryWithDetails extends Memory {
  place?: Place;
  trip?: Trip;
  photos?: Photo[];
  tags?: Tag[];
}

// ============================================================
// Dashboard statistics
// ============================================================

export interface DashboardStats {
  countries_visited: number;
  cities_visited: number;
  places_saved: number;
  trips_documented: number;
  photos_collected: number;
  continents_explored: number;
}
