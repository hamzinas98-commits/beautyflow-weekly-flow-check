# Product Requirements — BeautyFlow Weekly Flow Check

## Problem
Salon owners lose 30–60 minutes every Monday piecing together what went wrong last week and what to do next. There is no structured place to capture the seven key signals, and no tool that turns them into one clear action.

## Target User
Primary: BeautyFlow operator reviewing a salon owner's week. Secondary: Salon owner doing their own self-review.

## Core Objects
- **Weekly Review** — one submission per salon per week; holds all seven signal answers.
- **Action Summary** — AI-generated output attached to each review: bottleneck, priority score, next action.

## MVP Must-Haves
- [ ] Form capturing all seven signals: content status, inquiry count, follow-ups pending, booking trend, team blockers, reflection notes, week-ending date
- [ ] Submit triggers AI generation of bottleneck summary, priority score (0–100), and one next action
- [ ] Review screen shows the generated summary and lets the user edit/confirm the next action
- [ ] History list of past weekly reviews with priority badge
- [ ] App renders with demo data without login

## Non-Goals (v1)
- GHL / WhatsApp integration
- Real client data or automatic messages
- Multi-salon or multi-user teams
- Payments or subscriptions
- Full analytics dashboard
- Automatic weekly scheduling

## Success Criteria
> A BeautyFlow operator opens the app, fills in Luxe Hair Studio's seven signals for the current week, submits, reads a two-sentence bottleneck summary with a priority score of 74/100, edits the next action to add a deadline, confirms it — all within five minutes.
