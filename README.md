# ⚽ PlaySpace – Turf & Sports Venue Booking & Management Mobile App

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![State Management](https://img.shields.io/badge/State_Management-Provider-7B1FA2)](https://pub.dev/packages/provider)
[![Local Storage](https://img.shields.io/badge/Local_Storage-SharedPreferences-42A5F5)](https://pub.dev/packages/shared_preferences)
[![License](https://img.shields.io/badge/Academic-Project-FFB300)](#academic-compliance)

---

### 🎓 **ACADEMIC PROJECT PRESENTATION**
* **Project Title:** PlaySpace – Turf & Sports Venue Booking & Management App
* **Student Name:** Anney Begum
* **Student ID:** 232-134-011
* **Course:** Mobile Application Development
* **Department & Batch:** Software Engineering (SWE) — 5th Batch

---

## 📌 **TABLE OF CONTENTS**
- [🌟 Key Highlights & Features](#-key-highlights--features)
- [🛠️ Architecture & Technology Stack](#️-architecture--technology-stack)
- [📂 Codebase Directory Structure](#-codebase-directory-structure)
- [🚀 Getting Started & Run Instructions](#-getting-started--run-instructions)
- [📊 Academic Compliance Matrix](#-academic-compliance-matrix)
- [👤 Author & License](#-author--license)

---

## 🌟 **KEY HIGHLIGHTS & FEATURES**

### 1. ⚽ **Home & Discovery Dashboard**
* **Featured Banner Carousel:** Glassmorphic banner highlighting top-rated venues with special discounts.
* **Sport Category Selector:** Quick-filter chips for Football, Cricket, Badminton, Tennis, and Basketball.
* **Nearby Venues Catalog:** Dynamic cards with star ratings, location badges, price per hour, and 1-tap favorite toggle.

### 2. 🔍 **Advanced Search & Multi-Criteria Filtering**
* **Real-time Query Filter:** Search venues by turf name, landmark, or city.
* **Filter Modal:** Hourly rate price slider (৳800/hr - ৳3,500/hr), star rating selector, and surface type filters (AstroTurf, Natural Grass, Hardcourt).

### 3. 🏟️ **Responsive Side-by-Side Venue Details & Slot Picker**
* **Desktop Split-Hero Card:** Dual-column layout on desktop displays featuring a compact rounded photo card on the left and venue specifications, ratings, and location on the right.
* **Mobile Stacked Hero Banner:** Sleek full-width banner view on mobile screens.
* **Specifications:** Pitch dimensions, capacity, and amenity badges (Floodlights, Locker Rooms, Parking, Refreshments, Equipment Rental).
* **Interactive Slot Selector:** Morning, Afternoon, and Night floodlight hourly slot chips.

### 4. 📝 **Booking System & Strict Regex Validation**
* **Date & Match Duration:** Choose match date and slot duration (60m, 90m, 120m).
* **Form Validation:** Strict regex checking for Bangladeshi mobile numbers (`01XXXXXXXXX`), team name, and player count.
* **Instant Confirmation:** Visual success dialog with digital PDF receipt simulation.

### 5. ❤️ **Saved Favorites Catalog**
* Dedicated responsive grid view (2-column/3-column on desktop, 1-column on mobile) for bookmarked venues.

### 6. 📜 **Booking History & Active Reservations**
* **Full-Width Glass Tab Bar:** Active Reservations vs. Past History.
* **Record Controls:** Display status badges (Confirmed, Completed, Cancelled) with single and batch deletion options.

### 7. ⚙️ **Production App Settings**
* **Preferences:** Member discount toggle (15% Off), default duration, default payment option (bKash Instant, Nagad, Card, Pay at Venue).
* **Notifications & Alerts:** Toggle email PDF invoices and SMS match reminders.
* **Localization & Storage:** Language selector (English / বাংলা), currency selector (BDT ৳ / USD $), and local image cache cleaner.

### 8. 💬 **Centered Modal Dialogs & Customer Support**
* **Help & Support Popup:** Centered interactive dialog box featuring 24/7 Helpline details (`+880 1700-PLAYSPACE`, `support@playspace.app`, `Sylhet Sports Hub HQ`).
* **Update Profile Picture Modal:** Camera capture option, photo gallery picker, and AI sports avatar presets.

---

## 🛠️ **ARCHITECTURE & TECHNOLOGY STACK**

```
+-------------------------------------------------------------+
|               PlaySpace Flutter Presentation UI              |
+-------------------------------------------------------------+
                              |
                              v
+-------------------------------------------------------------+
|              Provider State Management Layer                |
|  - TurfProvider (Venues, Search & Favorites)                |
|  - BookingProvider (Active & Past History State)            |
|  - ThemeProvider (Light / Dark SharedPreferences)           |
|  - StudentProvider (Roster & Profile State)                 |
+-------------------------------------------------------------+
                              |
                              v
+-------------------------------------------------------------+
|            Local Data Storage (SharedPreferences)            |
|  - Persisted Favorite Turf IDs                              |
|  - Persisted Light/Dark Theme Preference                    |
|  - Persisted Confirmed Booking Records                      |
+-------------------------------------------------------------+
```

| Technology Layer | Package / Tool | Purpose |
| :--- | :--- | :--- |
| **Framework** | Flutter 3.x / Dart 3.x | Cross-platform mobile & desktop app |
| **State Management** | `provider` | Centralized reactive application state |
| **Local Persistence** | `shared_preferences` | Persistence of theme preferences, favorite IDs, and bookings |
| **Typography** | `google_fonts` | Modern Inter & Outfit typography |
| **Date & Invoices** | `intl` | Date formatting and timestamp calculations |

---

## 📂 **CODEBASE DIRECTORY STRUCTURE**

```
lib/
├── main.dart                      # App entry point, MultiProvider & Named Routes
├── models/
│   ├── booking_model.dart         # Booking record schema
│   ├── student_model.dart         # Student roster profile model
│   └── turf_model.dart            # Venue model & amenity definitions
├── providers/
│   ├── booking_provider.dart      # Active & past reservation state
│   ├── student_provider.dart      # Roster profile state
│   ├── theme_provider.dart        # SharedPreferences light/dark theme
│   └── turf_provider.dart         # Venues search & favorites state
├── screens/
│   ├── booking_history_screen.dart # Active & past booking cards
│   ├── favorites_screen.dart       # Responsive favorites grid/list
│   ├── home_screen.dart            # Main dashboard & categories
│   ├── profile_screen.dart         # Profile & avatar modal
│   ├── search_screen.dart          # Real-time search & filters
│   ├── settings_screen.dart        # Preferences, language & storage
│   └── turf_detail_screen.dart     # Responsive side-by-side venue view & slot selector
├── services/
│   └── shared_pref_service.dart   # SharedPreferences persistence layer
├── utils/
│   └── constants.dart             # Colors, theme tokens & mock venue data
└── widgets/
    ├── amenity_badge.dart         # Amenity visual indicators
    ├── app_drawer.dart            # Custom side navigation drawer
    ├── custom_app_bar.dart        # Reusable app bar
    ├── featured_banner_card.dart  # Glassmorphic banner carousel
    ├── glassmorphic_card.dart     # Glassmorphic UI container
    ├── slot_chip.dart             # Time slot selector chip
    ├── sport_category_chip.dart   # Category pill chip
    └── turf_card.dart             # Responsive venue card
```

---

## 🚀 **GETTING STARTED & RUN INSTRUCTIONS**

### Prerequisites
* Flutter SDK (3.x or higher)
* Dart SDK (3.x or higher)
* Google Chrome, Edge, or Android Emulator

### Steps to Run
```bash
# 1. Navigate to the project directory
cd d:/Desktop/Web-App

# 2. Get dependencies
flutter pub get

# 3. Analyze codebase for clean compilation
flutter analyze

# 4. Launch the application
flutter run -d chrome   # Web
flutter run -d windows  # Windows Desktop
```

---

## 📊 **ACADEMIC COMPLIANCE MATRIX**

| Requirement | Description | Implementation Status |
| :--- | :--- | :---: |
| **State Management** | Centralized reactive state management using Provider | **✅ 100% Fulfilled** |
| **Local Persistence** | Retain light/dark theme, favorite IDs, and bookings locally | **✅ 100% Fulfilled** |
| **Navigation & Routing** | Stack navigation with Named Routes map | **✅ 100% Fulfilled** |
| **Forms & Validation** | Regex validation for mobile numbers, team name, and player bounds | **✅ 100% Fulfilled** |
| **Custom UI Design** | Glassmorphic UI containers and custom modular widgets | **✅ 100% Fulfilled** |
| **Responsive Web/Desktop** | Side-by-side desktop hero cards & multi-column grids | **✅ 100% Fulfilled** |

---

## 👤 **AUTHOR & LICENSE**

**Anney Begum** (Student ID: 232-134-011)  
Department of Software Engineering (SWE — 5th Batch)  
*PlaySpace Academic Mobile Application Project*

© 2026 PlaySpace App. All Rights Reserved.
