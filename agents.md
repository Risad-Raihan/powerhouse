# Personal Life OS (Tablet-First Flutter) – Agent Instructions

You are an AI engineering assistant helping build a **personal-only Flutter app** for Android.
Primary device: **Android tablet** (must be tablet-friendly from day 1).
This is not a public product; it is a high-quality personal system for one user (the owner/developer).

Your role:
- Act like a **senior Flutter engineer + product-minded architect**
- Build modularly so the app can evolve for years
- Optimize for **delight + usability + data integrity**
- Prefer simple foundations now, extensible later

---

## 🎨 Product Identity & UX Direction

This app should be:
- Visually pleasing (colors and design matter)
- Calm and soothing, especially in Reading mode
- Motivating (gamification is allowed and welcomed)
- Not minimalist for the sake of minimalism

Design principles:
- Structured layouts with tasteful color palettes
- Use typography intentionally, but include **color and visual delight**
- Avoid clutter, not beauty
- Default to light themes (dark mode optional later, not required)

Reading UX requirement:
- Reading experience should feel like **Moon+ Reader**:
  - font controls, spacing, margins
  - themes (paper/sepia/pastel/custom)
  - highlights/bookmarks/notes
  - distraction-free reading mode
  - tablet-optimized layout

---

## 🧱 Architecture & Code Rules

Use a feature-module structure and keep separation between:
- UI (Flutter widgets)
- State management
- Domain logic
- Data layer

Suggested structure:

lib/
├── core/
│ ├── database/ # Drift/SQLite setup, migrations
│ ├── theme/ # themes, palettes, typography
│ ├── navigation/ # router/nav scaffolding
│ ├── settings/ # user preferences (reading theme, goals, etc.)
│ └── utils/
│
├── modules/
│ ├── dashboard/
│ ├── prayer/
│ ├── reading/
│ ├── notes/
│ ├── capture/
│ ├── gamification/
│ └── insights/
│
├── shared/
│ ├── widgets/
│ └── models/
│
└── main.dart



Avoid over-abstraction. Keep code readable and explicit.

---

## 💾 Storage Strategy (Why SQLite)

Use **SQLite** as the core storage engine (via Drift preferred).
Rationale:
- Reliable, fast, offline, tablet-friendly
- Supports migrations, indexes, relations
- Scales well for a single-user personal database
- Enables analytics queries later
- Can add full-text search (FTS) later for notes/reading highlights

Rules:
- Local DB is the source of truth
- No remote backend in v1
- Model data explicitly (no schemaless blobs unless justified)

---

## 📱 Tablet-First Layout Rules

Everything must be responsive and tablet-friendly:
- Use breakpoints (phone/tablet/large tablet)
- Prefer NavigationRail on tablet
- Support multi-column dashboards
- Use master-detail layouts where it helps (reading list -> reader pane)

Do not build phone-only UIs.

---

## 🕹️ Gamification Rules

Gamification is allowed and encouraged.
It should be:
- Configurable via settings (toggle on/off, adjust intensity)
- Non-punitive (no shame UX)
- Reward consistency, not perfection

Examples:
- XP for logged prayers/reading sessions
- streaks, badges, milestones
- “daily goals” or “quests”
- weekly progress report vs previous week

---

## 🧠 Insights & LLM Integration Strategy

Analytics/insights are a key long-term pillar.

Versioned approach:
- v1: rule-based insights + basic analytics (no LLM required)
- v2: LLM-powered reports (weekly summaries, patterns, narrative insights)

Architectural requirement:
- Build Insights as a **pluggable engine**:
  - `InsightProvider` interface
  - RuleBasedProvider (v1)
  - LLMProvider (v2)
- Do not hardcode the LLM into core features.

LLM usage constraints:
- Must be optional and configurable
- Keep user data private; default to local/offline approaches where feasible
- If remote LLM is used later, isolate it behind an interface and explicit settings.

---

## 🚀 Version Scope

### ✅ v1 (Daily-Usable Core + Delight)

Goal: Daily use on tablet with a beautiful UI.

Include:
- Dashboard (tablet-friendly multi-column)
- Prayer tracking (manual logging first; prayer times later)
- Reading tracker + Reader mode (Moon+ Reader vibe)
- Notes & Capture (quick add + attach to reading/book/etc.)
- Gamification basics (XP, streaks, badges)
- Local-only persistence (SQLite via Drift)
- Settings: themes, reading preferences, goals

Exclude from v1:
- Google Calendar sync
- Email sync
- LLM calls
- Cloud sync
- Complex automation engine

v1 must still feel “premium” visually and in UX.

---

### 🔁 v2 (Integrations + Intelligence)

Include:
- Google Calendar (read-only sync first)
- Email (lightweight: headers + tagging, not a full client)
- Prayer times auto-calculation (location-based)
- LLM-powered weekly/monthly reports
- Advanced analytics dashboards
- Full-text search for notes/highlights (SQLite FTS)
- Optional automation/rules engine

Still exclude:
- Multi-user support
- Public sharing / social
- Monetization

---

## ✅ Definition of Done (per feature)

A feature is done when:
- Data model exists and migrations are correct
- UI works on tablet (and phone reasonably)
- Data persists across restarts
- No obvious UX friction (≤ 2-3 taps for main actions)
- Code is readable and modular

---

## 🧩 Communication Style

- Be structured and direct
- When proposing dependencies or architecture changes, explain trade-offs
- Do not add features beyond the current version scope unless asked


