# Tasks & Sprints

## Sprint 1 — Database + Core Check-In Engine
**Goal:** The one core workflow works end-to-end: submit seven answers → AI summary appears on screen. Anonymous-viewable.

- [ ] Apply migration SQL (weekly_reviews, action_summaries, RLS v1 open policies, 3 seed reviews)
- [ ] `/reviews` list page renders seed rows without login (priority badge, week date, salon name, action snippet)
- [ ] `/reviews/new` form with all seven signal fields + week-ending date picker, client-side validation
- [ ] Server action: write `weekly_reviews` row on submit
- [ ] Server action: call `generate_action_summary` tool → parse JSON → write `action_summaries` row
- [ ] `/reviews/[id]` review screen: bottleneck summary, priority score badge, next action text
- [ ] Loading spinner during AI call; error banner if AI fails (shows raw answers as fallback)
- [ ] Empty state on `/reviews` list when no rows

**Definition of Done:** Create a new review in the form, see the AI summary on the review screen, confirm both DB rows exist in Supabase table editor. ✅ **v1 functional milestone**

---

## Sprint 2 — Edit, Confirm, and History Polish
**Goal:** Full CRUD; no dead buttons; history reflects live DB.

- [ ] Editable `next_action` field on review screen (inline edit + save)
- [ ] **Confirm Action** button → sets `confirm_status = confirmed`
- [ ] **Mark Done** button → sets `confirm_status = done`
- [ ] Priority badge colours: red (≥70), amber (40–69), green (<40)
- [ ] Delete review with confirmation modal
- [ ] `/reviews` list sorted by `week_ending` desc; badge + action snippet per row
- [ ] Toast notifications on save/confirm/delete

**Definition of Done:** Edit, confirm, and delete all persist correctly; history list updates immediately.

---

## Sprint 3 — Lock It Down
**Goal:** Auth added; each owner sees only their own reviews.

- [ ] Supabase Auth: email/password sign-up and login pages
- [ ] Stamp `user_id = auth.uid()` on all writes
- [ ] Replace open RLS policies with `auth.uid() = user_id` on both tables
- [ ] `/reviews/new` and `/reviews/[id]` edit actions require authenticated session
- [ ] `/reviews` list still shows seed demo rows to anonymous visitors
- [ ] Sign-out button in nav

**Definition of Done:** Two separate test accounts each see only their own reviews; anonymous visitor sees demo rows only.

---

## Sprint 4 — Trends + Carry-Forward
**Goal:** Surface patterns across weeks; prevent dropped actions.

- [ ] Carry-forward banner on `/reviews/new`: if last week's action is not `done`, surface it with a link
- [ ] Trend panel on `/reviews`: `booking_trend` sentiment and `priority_score` plotted as sparklines across last 8 weeks
- [ ] `follow_ups_pending` rolling bar chart

**Definition of Done:** Carry-forward appears when last action is unresolved; charts render from real DB rows.

---

## Gantt (sprint → feature)
```
Week 1:  Sprint 1 — DB + form + AI summary engine       [v1 functional]
Week 2:  Sprint 2 — Edit / confirm / history polish
Week 3:  Sprint 3 — Auth + RLS lock-down
Week 4:  Sprint 4 — Trends + carry-forward
```
