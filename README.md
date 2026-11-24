# MYWORLD – PRODUCT VISION & DESIGN SPECIFICATION

## 1. Project Overview

Build a premium application called **MyWorld – Your Personal World Atlas**.

Tagline: **Every place tells a story.**

MyWorld is a personal digital archive that allows users to document their lives geographically.

It combines an interactive world map, travel journal, photo archive, personal timeline, travel statistics and bucket list into one coherent experience.

The central idea:

Users should be able to look at a map of the world and see where they have been, where they have lived, what they have experienced and which memories they have collected throughout their lives.

MyWorld is not just another travel planning application.

It is a visual history of someone's life.

The application should feel personal, beautiful, intuitive and meaningful. It should encourage users to document their experiences without making the process complicated.

The experience should combine the best aspects of:
- A premium digital travel journal.
- An interactive personal world atlas.
- A photo and memory archive.
- A personal life timeline.
- A travel statistics dashboard.
- A digital bucket list.

The result must feel like one unified product rather than several unrelated features.

---

# 2. Product Philosophy

The most important principle is that every location can represent a memory.

A country can represent an entire journey.
A city can represent a period of someone's life.
A restaurant can represent a special evening.
A mountain can represent an unforgettable experience.
A photograph can represent a specific moment.

Every saved location should be connected to personal experiences whenever possible.

The application should prioritize:
1. Personal memories.
2. Geographic visualization.
3. Simplicity of documentation.
4. Beautiful presentation.
5. Long-term preservation of personal history.

Do not turn the application into a competitive social network.

The user's world atlas should remain personal and private by default.

---

# 3. Visual Identity & Design Language

Create a highly polished, premium design.

The design direction should combine:
- Modern editorial design.
- Premium travel magazine aesthetics.
- Minimalist dashboard layouts.
- Beautiful photography.
- Subtle animations.
- Clean typography.
- Immersive cartography.

Avoid generic SaaS dashboards and generic AI-generated application layouts.

The interface should feel intentionally designed.

## Color palette

Primary dark theme:
- Main background: #0D1117
- Secondary background: #131923
- Cards: #19212D
- Elevated elements: #222D3B
- Primary accent: #77B9A7
- Secondary accent: #E7BB82
- Primary text: #F5F5F2
- Secondary text: #9AA5B1
- Borders: subtle and low contrast

Create a complete light theme:
- Warm off-white backgrounds.
- White surfaces.
- Dark navy typography.
- Subtle green accents.
- Soft neutral borders.

Support both themes and allow the user to select their preference.

## Typography

Use a professional modern typeface such as Inter or Geist.

Use strong typographic hierarchy:
- Large editorial headings.
- Clear section titles.
- Comfortable body text.
- Small and subtle metadata.
- Consistent numerical formatting.

## Visual elements

Use:
- Beautiful location photography.
- Country flags.
- Geographic shapes.
- Minimal map markers.
- Subtle gradients.
- Carefully designed cards.
- Rounded corners.
- Smooth hover states.
- Subtle transitions.

Do not overuse gradients, shadows, borders or animations.

The map and the user's own photos should remain the visual focus.

---

# 4. Overall Application Layout

Build a responsive application for desktop, tablet and mobile.

## Desktop navigation

Use a persistent sidebar on the left.

Navigation:

1. Overview
2. World Map
3. My Trips
4. Memories
5. Places
6. Bucket List
7. Statistics

At the bottom:
- Profile
- Settings
- Theme selector

The main content area should use the available screen space efficiently.

The navigation should remain consistent across all authenticated pages.

## Mobile navigation

Use a compact mobile layout.

Implement a bottom navigation bar with the most important areas:
- Home
- Map
- Memories
- Trips
- Profile

Secondary sections should be accessible through a menu.

Make the world map comfortable to use on touchscreens.

---

# 5. Dashboard – MyWorld Overview

The dashboard should immediately communicate the user's personal travel history.

At the top:

A personalized greeting, for example:

"Your world, one memory at a time."

Include a visually appealing summary of the user's world.

## Dashboard sections

### Personal statistics

Display:
- Countries visited.
- Cities visited.
- Places saved.
- Trips documented.
- Photos collected.
- Continents explored.

These values must be calculated dynamically from actual database records.

### World map preview

Show a compact interactive world map with:
- Visited countries.
- Saved places.
- Wishlist destinations.

Clicking the map should open the full world map.

### Recent memories

Show recently added memories as attractive image cards.

Each card should display:
- Photograph.
- Memory title.
- Location.
- Date.

### Recent trips

Show recent and ongoing trips with:
- Cover image.
- Destination.
- Date range.
- Number of documented places.

### Bucket list preview

Show a selection of future destinations.

### Personal timeline

Show selected events and memories in chronological order.

Create a balanced dashboard. Do not display too many statistics or cards at once.

---

# 6. World Map – The Heart of MyWorld

The interactive world map is the most important feature of the entire application.

Make it visually impressive and central to the product experience.

Use a large map that fills most of the available screen.

## Geographic visualization

Display:
- Countries.
- Country boundaries.
- Cities.
- Individual saved locations.
- Visited destinations.
- Wishlist destinations.
- Important personal locations.

## Country status

Allow the user to assign statuses to countries:

- Visited.
- Partially explored.
- Want to visit.
- Current home.
- Previous home.

Use an understandable and accessible color system.

Include a compact legend.

Make sure that different statuses remain visually distinguishable in both themes.

## Map interactions

Users should be able to:

- Zoom and pan.
- Search for countries, cities and places.
- Click a country.
- Open country details.
- Add a new place.
- Add a visit.
- Open saved memories.
- Filter by year.
- Filter by country.
- Filter by category.
- Show or hide wishlist destinations.
- Show or hide visited locations.

When clicking a country, open a beautiful information panel.

The country panel should show:
- Country name.
- Flag.
- Continent.
- Visit history.
- Cities visited.
- Saved places.
- Photos.
- Memories.
- Personal notes.

Allow multiple visits to the same country.

For example, Japan can have separate visits in 2024 and 2026.

Never overwrite previous visit history when a country is visited again.

## Country exploration visualization

Show a clear indication of which countries have been visited.

The user should be able to visually recognize their geographic history.

Avoid inaccurate calculations of partial exploration.

Country boundaries must be geographically accurate.

---

# 7. Places – Personal Location Archive

Create a complete location management system.

Users can save:
- Cities.
- Towns.
- Villages.
- Restaurants.
- Hotels.
- Natural landmarks.
- Mountains.
- Beaches.
- Museums.
- Historical locations.
- Personal places.

Each place should support:

- Name.
- Country.
- City.
- Geographic coordinates.
- Description.
- Category.
- Photos.
- Personal memories.
- Visit dates.
- Rating.
- Notes.

Categories:
- City.
- Nature.
- Architecture.
- Historical.
- Restaurant.
- Accommodation.
- Mountain.
- Beach.
- Museum.
- Adventure.
- Personal.
- Other.

Users can create custom categories in a future version.

Allow repeated visits to the same place.

Provide an easy way to add a place directly from the map.

---

# 8. Trips – Travel History

Create a dedicated area for documenting individual trips.

A trip should feel like a digital travel journal.

Each trip has:
- Title.
- Cover image.
- Start date.
- End date.
- Countries.
- Cities.
- Description.
- Visited places.
- Photos.
- Memories.
- Daily entries.

Example:

"Japan – Spring 2026"

Inside the trip detail page:

- Large cover image.
- Trip description.
- Travel dates.
- Countries visited.
- Interactive trip map.
- Timeline of places.
- Photo gallery.
- Journal entries.

Allow users to document past trips retrospectively.

Allow users to create future trips in planning status.

A trip can contain multiple countries and destinations.

Do not require every saved place to belong to a trip.

Some places are part of everyday life and should exist independently.

---

# 9. Memories – Digital Life Archive

Create an immersive personal memories section.

The goal is to make it feel like browsing a beautiful personal archive.

## Photo gallery

Display photographs in an attractive responsive masonry or grid layout.

Features:
- Multiple photo uploads.
- Full-screen photo viewer.
- Captions.
- Dates.
- Locations.
- Country filters.
- Year filters.
- Trip filters.
- Search.
- Chronological sorting.

## Photo metadata

When available, allow the user to extract:
- Photo capture date.
- GPS coordinates.
- Camera information.

Location extraction from image metadata must be optional.

Never silently reveal or share photo location information.

Ask for permission before using embedded GPS information to create or update a location.

## Memory entries

Each memory can contain:
- Title.
- Description.
- Date.
- Location.
- Photos.
- Related trip.
- Mood.
- Tags.

Make writing and editing memories simple and enjoyable.

## Memories timeline

Create a chronological timeline of the user's life and travel history.

Allow navigation by:
- Year.
- Month.
- Country.
- Trip.
- Category.

The timeline should combine photos, trips, important locations and written memories.

---

# 10. Bucket List – Future Destinations

Create a dedicated personal wishlist.

Users should be able to save places they dream of visiting.

Each wishlist item includes:
- Destination.
- Country.
- City.
- Optional coordinates.
- Priority.
- Category.
- Personal notes.
- Optional photo.

Priority levels:
- Low.
- Medium.
- High.
- Dream destination.

Wishlist destinations should also appear on the world map.

Allow users to mark a destination as completed.

Completing an item should not delete the wishlist history.

Instead, preserve the original intention and record when it was visited.

---

# 11. Statistics – Your World in Numbers

Create a beautiful and useful statistics dashboard.

All statistics must be generated from actual stored user data.

## Main statistics

- Number of unique countries visited.
- Number of countries per continent.
- Number of cities visited.
- Number of individual places saved.
- Number of trips.
- Number of photos.
- Number of memories.
- Number of years with travel activity.

## Charts and visualizations

Create:
- Countries visited by continent.
- Trips per year.
- Memories per year.
- Places added over time.
- Photos per year.
- Timeline of travel activity.

Include a personal country coverage percentage.

Clearly define the denominator used for percentages and avoid suggesting that visiting a country means fully exploring it.

Never invent distance travelled, expenses or other statistics that the user has not provided enough information to calculate.

---

# 12. Personal Profile & Life Map

Create a profile section.

Users can configure:
- Display name.
- Username.
- Profile photo.
- Biography.
- Home location.
- Preferred theme.
- Language.
- Privacy settings.

The Life Map should support more than holidays.

Allow users to document:
- Birthplace.
- Previous homes.
- Current home.
- Schools and universities.
- Important cities.
- Places where they worked.
- Important personal locations.

All locations must remain private unless the user explicitly chooses otherwise.

---

# 13. Add Location & Add Memory Experience

Adding new information must be extremely easy.

Create a global "Add" action accessible from the main navigation.

The user can choose:
- Add a country visit.
- Add a city.
- Add a place.
- Add a memory.
- Upload photos.
- Create a trip.

Forms should be simple and progressive.

Do not overwhelm the user with unnecessary required fields.

Use location search with suggestions.

Allow manual coordinate entry only when useful.

When adding photos, allow users to assign an existing location or create a new one.

---

# 14. Empty States, Loading and Error Experiences

Every page must have thoughtfully designed states.

Examples:

No trips:

"Your next journey is waiting to be documented."

No memories:

"Your memories will find their place here."

Empty bucket list:

"Where would you like to go someday?"

Include:
- Helpful call-to-action buttons.
- Loading skeletons.
- Clear error messages.
- Retry actions where appropriate.
- Success feedback.
- Confirmation before destructive actions.

Never show an empty blank page when a user has no data.

---

# 15. Privacy & User Experience

All user content must be private by default.

Do not implement public user profiles or public location sharing in the initial version.

The application should not use continuous location tracking.

Only save location information when the user explicitly adds or approves it.

Provide:
- Clear privacy settings.
- Data export.
- Account deletion.
- Photo deletion.
- Memory editing.
- Location editing.

Do not expose personal travel history through public URLs.

---

# 16. Accessibility & Responsiveness

The application must:
- Work on desktop, tablet and mobile.
- Support keyboard navigation.
- Have visible focus indicators.
- Use accessible color contrast.
- Have meaningful labels.
- Support screen readers where practical.
- Respect reduced-motion preferences.
- Use sufficiently large touch targets.

Do not rely on color alone to communicate map status.

---

# 17. Product Development Priorities

Build the application in the following order.

### MVP – Essential Features

1. Authentication.
2. User onboarding.
3. Dashboard.
4. Interactive world map.
5. Country visit management.
6. Place management.
7. Photo uploads.
8. Memories.
9. Trip management.
10. Basic statistics.
11. Bucket list.
12. User settings and privacy.

### Version 2

- Advanced life timeline.
- Advanced country statistics.
- Photo map.
- Personal annual recap.
- PDF or image export of personal maps.
- Improved offline experience.
- Custom categories.
- More advanced search and filters.

### Future Ideas

- MyWorld Wrapped.
- Shared private trips.
- Collaborative travel journals.
- Optional sharing of selected memories.
- AI-assisted memory organization.
- Automatic photo date and location suggestions.
- Advanced travel timeline visualization.

These future features must not delay the core MVP.

---

# 18. Final Design Requirements

The result must feel like a premium, production-quality application.

Do not create:
- A generic admin dashboard.
- A static landing page pretending to be an app.
- Non-functional buttons.
- Fake statistics.
- Fake saved locations.
- Placeholder map interactions.
- Hardcoded user data.

Use realistic loading, error and empty states.

All important interactions should work.

The world map must be the defining visual element.

The memories section must make personal history feel meaningful.

The overall product must be coherent, polished, responsive and enjoyable to use.

**MyWorld – Every place tells a story.**
