# Architecture

## Stack
- **Frontend:** Next.js 14 (App Router) on Vercel
- **Database + Auth:** Supabase (Postgres, RLS, Auth)
- **AI:** OpenAI GPT-4o via server-side API route — secret never reaches the client
- **Styling:** Tailwind CSS

## Now vs Later
| Now (v1) | Later |
|---|---|
| Weekly check-in form + AI summary | Login + per-owner data isolation |
| Review screen with editable action | Carry-forward unresolved actions |
| History list (anonymous-viewable) | Booking trend sparklines |
| Seed data demo mode | GHL / WhatsApp send |

## Key User Action — Step by Step
1. User lands on `/reviews` — sees history list (seed data visible, no login needed).
2. Clicks **New Week** → `/reviews/new` form with seven fields.
3. Submits form → Next.js server action writes `weekly_reviews` row to Supabase.
4. Server action calls OpenAI with a structured prompt containing the seven answers.
5. Response is parsed; `action_summaries` row written with value + source + confidence.
6. User redirected to `/reviews/[id]` — sees bottleneck summary, priority badge, next action.
7. User edits next action text, clicks **Confirm** → `confirm_status` updated to `confirmed`.

## Layer Plan
1. **Data first** — tables and seed rows; app renders before AI is wired.
2. **App logic** — form, CRUD routes, review screen; core works with AI off (fields show placeholder).
3. **Smart layer** — OpenAI call added on top; if it fails, user sees raw answers and retries.
