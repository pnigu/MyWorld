// Application constants

export const APP_NAME = "MyWorld";
export const APP_TAGLINE = "Every place tells a story.";
export const APP_DESCRIPTION = "Your Personal World Atlas";

export const CONTINENTS = [
  "Africa",
  "Asia",
  "Europe",
  "North America",
  "South America",
  "Oceania",
] as const;

export type Continent = (typeof CONTINENTS)[number];

export const PLACE_CATEGORIES = [
  { value: "city", label: "City", icon: "Building2" },
  { value: "nature", label: "Nature", icon: "Trees" },
  { value: "architecture", label: "Architecture", icon: "Landmark" },
  { value: "historical", label: "Historical", icon: "Castle" },
  { value: "restaurant", label: "Restaurant", icon: "UtensilsCrossed" },
  { value: "accommodation", label: "Accommodation", icon: "Hotel" },
  { value: "mountain", label: "Mountain", icon: "Mountain" },
  { value: "beach", label: "Beach", icon: "Waves" },
  { value: "museum", label: "Museum", icon: "GalleryVerticalEnd" },
  { value: "adventure", label: "Adventure", icon: "Compass" },
  { value: "personal", label: "Personal", icon: "Heart" },
  { value: "other", label: "Other", icon: "MapPin" },
] as const;

export const MOOD_OPTIONS = [
  { value: "happy", label: "Happy", emoji: "😊" },
  { value: "excited", label: "Excited", emoji: "🤩" },
  { value: "peaceful", label: "Peaceful", emoji: "😌" },
  { value: "grateful", label: "Grateful", emoji: "🙏" },
  { value: "nostalgic", label: "Nostalgic", emoji: "🥹" },
  { value: "adventurous", label: "Adventurous", emoji: "🏔️" },
  { value: "romantic", label: "Romantic", emoji: "💕" },
  { value: "reflective", label: "Reflective", emoji: "🤔" },
  { value: "inspired", label: "Inspired", emoji: "✨" },
  { value: "bittersweet", label: "Bittersweet", emoji: "🌅" },
] as const;

export const WISHLIST_PRIORITIES = [
  { value: "low", label: "Low", color: "text-muted-foreground" },
  { value: "medium", label: "Medium", color: "text-chart-3" },
  { value: "high", label: "High", color: "text-secondary" },
  { value: "dream", label: "Dream Destination", color: "text-primary" },
] as const;

export const COUNTRY_STATUS_OPTIONS = [
  { value: "visited", label: "Visited", color: "#77B9A7" },
  { value: "partially_explored", label: "Partially Explored", color: "#5A9A87" },
  { value: "want_to_visit", label: "Want to Visit", color: "#E7BB82" },
  { value: "current_home", label: "Current Home", color: "#6BA3D6" },
  { value: "previous_home", label: "Previous Home", color: "#8B7EC8" },
] as const;

export const TRIP_STATUS_OPTIONS = [
  { value: "planning", label: "Planning" },
  { value: "ongoing", label: "Ongoing" },
  { value: "completed", label: "Completed" },
] as const;

// Total number of UN-recognized sovereign states
// Used as denominator for country coverage percentage
export const TOTAL_SOVEREIGN_COUNTRIES = 195;
