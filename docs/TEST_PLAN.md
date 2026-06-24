# Test Plan

## Core Success Scenario (manual)
1. Open `/reviews` — confirm 3 seed rows render with priority badges and action snippets.
2. Click **New Week** — confirm form loads with all seven fields and a date picker.
3. Leave `salon_name` blank, click Submit — confirm inline validation error appears, no DB write.
4. Fill all fields: salon "Luxe Hair Studio", week ending last Sunday, 8 inquiries, 6 follow-ups, booking trend "Down 15%", team blockers "none", reflection "Slow week, need to post more". Submit.
5. Confirm loading spinner appears during AI call.
6. Confirm redirect to `/reviews/[id]` — bottleneck summary is 1–2 sentences, priority score renders as a coloured badge, next action is a single imperative sentence.
7. Click next action text → edit to add "— by Friday EOD" → click Save → confirm text updates without page reload.
8. Click **Confirm Action** → confirm `confirm_status` badge changes to "Confirmed".
9. Navigate to `/reviews` — confirm new row appears at top of list with correct badge colour.
10. Open Supabase table editor → confirm one row in `weekly_reviews` and one in `action_summaries` with `is_user_edited = true`.

## Empty State
- Delete all rows via Supabase table editor. Load `/reviews` — confirm empty-state message (not a blank page).

## AI Failure
- Temporarily set `OPENAI_API_KEY` to an invalid value. Submit a new review — confirm error banner appears with raw answers visible, no crash.

## Delete Flow
- Click delete on a review card → confirm modal appears → confirm deletion → row removed from list; `action_summaries` row also gone (cascade).

## Edge Cases
- `inquiries_count = 0`, `follow_ups_pending = 0` — confirm form accepts zero values and AI still generates a summary.
- Very long reflection notes (500+ chars) — confirm layout does not break on review screen.
