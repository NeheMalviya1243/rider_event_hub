# Rider Event Hub

> A full-stack campus event discovery platform built for Rider University students — featuring real-time RSVP tracking, QR code sharing, admin moderation, and a Supabase backend. Deployed on Netlify.

---

## Problem Statement

Rider University students have no centralized place to discover campus events. Information is scattered across emails, flyers, and social media. Students miss events they’d want to attend, and organizers struggle to reach their audience effectively.

Rider Event Hub solves this by providing a single verified platform where students can browse, RSVP, bookmark, and share all campus events — and organizers can submit and track their listings.

---

## Solution Overview

A single-page web application deployed on Netlify with a Supabase PostgreSQL backend. Students browse events via list or calendar view, RSVP with one click, and share via QR code. Organizers submit events through a form (requiring a `@rider.edu` email), and admins approve or reject submissions through a dedicated dashboard.

---

## Key Features

| Feature | Description |
|---|---|
| Event Discovery | Browse all campus events in list view or monthly calendar view |
| Smart Filtering | Filter by category, location, date, or search keyword |
| RSVP Tracking | One-click RSVP with real-time count, capacity bar, and sold-out detection |
| QR Code Sharing | Built-in QR code generator for each event to share via scan |
| Bookmarks & Reminders | Save events and set browser notifications for reminders |
| Event Submission | Organizers submit events via form (restricted to `@rider.edu` emails) |
| Admin Dashboard | Approve/reject submissions, feature events, export data to CSV |
| Comments Section | Students can ask questions or leave comments on each event |
| View Count Tracking | Atomic view counter per event (safe for concurrent updates) |
| 8 Event Categories | Academic, Networking, Club, Campus Life, Food & Social, Workshop, Orientation, Other |

---

## Tech Stack

| Layer | Tools |
|---|---|
| Frontend | HTML5, CSS3 (custom properties), Vanilla JavaScript, React (CDN) |
| Backend / Database | Supabase (PostgreSQL) |
| Authentication | `@rider.edu` email validation, localStorage for session state |
| QR Code | `qrcode.min.js` (jsDelivr CDN) |
| Deployment | Netlify (with `netlify.toml` config) |
| Fonts | Google Fonts (Nunito) |

---

## Database Schema

### `events` table
| Column | Type | Description |
|---|---|---|
| `id` | BIGSERIAL PK | Auto-increment event ID |
| `title` | TEXT | Event name |
| `description` | TEXT | Event details |
| `category` | TEXT | One of 8 categories |
| `date` | DATE | Event date |
| `start_time` / `end_time` | TEXT | Event time range |
| `location` | TEXT | Campus location |
| `organizer` / `organizer_email` | TEXT | Submitter info |
| `status` | TEXT | `pending`, `approved`, `rejected` |
| `featured` | BOOLEAN | Admin-featured flag |
| `rsvp_count` / `capacity` | INT | RSVP tracking with capacity limit |
| `view_count` | INT | Page view counter |

### `comments` table
Linked to `events` via foreign key with cascade delete.

### SQL Functions
- `increment_view_count(event_id)` — atomic view counter
- `increment_rsvp_count(event_id)` — atomic RSVP counter (safe for concurrent updates)

---

## Architecture & Workflow

```
Student / Organizer / Admin
        |
        v
  index.html  <-- Single Page App (React via CDN)
  * Event feed (list + calendar views)
  * Filters: category, location, search, date
  * Event detail modal with RSVP + QR code
  * Bookmark & reminder system (localStorage)
  * Event submission form (@rider.edu only)
  * Admin dashboard (approve/reject/feature/export)
        |
        v
  Supabase (PostgreSQL)
  * events table (status: pending/approved/rejected)
  * comments table
  * Atomic SQL functions for view/RSVP counts
        |
        v
  Netlify (Deployment)
  * Static site hosting
  * netlify.toml routing config
```

---

## Project Files

| File | Purpose |
|---|---|
| `index.html` | Complete single-page app — UI, logic, styles, React components |
| `supabase-setup.sql` | Database schema setup script — run once in Supabase SQL Editor |
| `netlify.toml` | Netlify deployment configuration |

---

## Setup Instructions

```bash
# 1. Clone the repository
git clone https://github.com/NeheMalviya1243/rider_event_hub.git

# 2. Set up Supabase
# - Create a project at supabase.com
# - Run supabase-setup.sql in the SQL Editor
# - Copy your project URL and anon key

# 3. Update credentials in index.html
# SUPABASE_URL = 'your-project-url'
# SUPABASE_KEY = 'your-anon-key'

# 4. Deploy to Netlify
# - Connect your GitHub repo to Netlify
# - Deploy automatically on push to main

# OR open locally
# Just open index.html in a browser
```

---

## Example Use Cases

**Student:** Searches for "networking" events this week, RSVPs to a Career Fair, sets a reminder, and shares the event via QR code to a friend.

**Organizer:** Submits a Club Meeting using their `@rider.edu` email. Event goes to `pending` status and awaits admin approval.

**Admin:** Logs into the admin dashboard, approves the submission, features it on the homepage, and exports the month’s event data to CSV.

---

## Recruiter Highlights

- **Full-Stack Web App:** Frontend (HTML/CSS/JS/React) + Backend (Supabase PostgreSQL) + Deployment (Netlify)
- **Real University Use Case:** Built specifically for Rider University students with `@rider.edu` email validation
- **Database Design:** Relational schema with foreign keys, cascade deletes, and atomic SQL functions for concurrency safety
- **Production Features:** Admin moderation workflow, RSVP capacity tracking, QR code generation, browser notifications
- **Deployed & Live:** Configured for Netlify deployment with proper routing via `netlify.toml`

---

Built by [Nehe Malviya](https://github.com/NeheMalviya1243) | Rider University — Business Data Analytics
