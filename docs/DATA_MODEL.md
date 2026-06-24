# Data Model

## weekly_reviews
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | gen_random_uuid() |
| user_id | uuid nullable | owner-scoping at lock-down sprint |
| created_at | timestamptz | default now() |
| week_ending | date | Sunday of the reviewed week |
| salon_name | text | free text, v1 single salon |
| content_status | text | what was posted / not posted |
| inquiries_count | integer | DMs / calls received |
| follow_ups_pending | integer | open follow-ups not yet actioned |
| booking_trend | text | up/flat/down + notes |
| team_blockers | text | blockers or "none" |
| reflection_notes | text | owner's free-form reflection |
| confirm_status | text | pending / confirmed / done |

## action_summaries
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| created_at | timestamptz | |
| weekly_review_id | uuid FK → weekly_reviews | cascade delete |
| bottleneck_summary | text | **AI field** |
| bottleneck_summary_source | text | e.g. `openai-gpt4o` |
| bottleneck_summary_confidence | numeric | 0–1 |
| bottleneck_summary_review_status | text | unreviewed / confirmed / rejected |
| priority_score | integer | **AI field** 0–100 |
| priority_score_source | text | `rule+openai` |
| priority_score_confidence | numeric | |
| priority_score_review_status | text | |
| next_action | text | **AI field**, user-editable |
| next_action_source | text | |
| next_action_confidence | numeric | |
| next_action_review_status | text | |
| is_user_edited | boolean | true if user changed next_action |

## RLS
- v1: open read + write policies on both tables (demo mode).
- Lock-down sprint: replace with `auth.uid() = user_id`.
