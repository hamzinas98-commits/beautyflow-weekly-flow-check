create table if not exists weekly_reviews (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  week_ending date not null,
  salon_name text not null,
  content_status text not null,
  inquiries_count integer not null,
  follow_ups_pending integer not null,
  booking_trend text not null,
  team_blockers text not null,
  reflection_notes text not null,
  confirm_status text not null default 'pending'
);

alter table weekly_reviews enable row level security;
drop policy if exists "weekly_reviews_v1_read" on weekly_reviews;
create policy "weekly_reviews_v1_read" on weekly_reviews for select using (true);
drop policy if exists "weekly_reviews_v1_write" on weekly_reviews;
create policy "weekly_reviews_v1_write" on weekly_reviews for all using (true) with check (true);

create table if not exists action_summaries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  weekly_review_id uuid not null references weekly_reviews(id) on delete cascade,
  bottleneck_summary text not null,
  bottleneck_summary_source text not null default 'openai-gpt4o',
  bottleneck_summary_confidence numeric,
  bottleneck_summary_review_status text not null default 'unreviewed',
  priority_score integer not null,
  priority_score_source text not null default 'rule+openai',
  priority_score_confidence numeric,
  priority_score_review_status text not null default 'unreviewed',
  next_action text not null,
  next_action_source text not null default 'openai-gpt4o',
  next_action_confidence numeric,
  next_action_review_status text not null default 'unreviewed',
  is_user_edited boolean not null default false
);

alter table action_summaries enable row level security;
drop policy if exists "action_summaries_v1_read" on action_summaries;
create policy "action_summaries_v1_read" on action_summaries for select using (true);
drop policy if exists "action_summaries_v1_write" on action_summaries;
create policy "action_summaries_v1_write" on action_summaries for all using (true) with check (true);

insert into weekly_reviews (id, week_ending, salon_name, content_status, inquiries_count, follow_ups_pending, booking_trend, team_blockers, reflection_notes, confirm_status) values
  ('a1000000-0000-0000-0000-000000000001', '2025-07-06', 'Luxe Hair Studio', 'Posted 2 reels, 1 story — engagement down vs last week', 14, 5, 'Down 10% vs prior week, mostly Tuesday slots empty', 'Stylist Sarah out sick two days, no coverage for colour appointments', 'Week felt reactive. Spent too much time chasing no-shows instead of content.', 'confirmed'),
  ('a1000000-0000-0000-0000-000000000002', '2025-07-13', 'Luxe Hair Studio', 'No posts — owner on leave, content queue empty', 3, 9, 'Flat week, weekend fully booked but weekdays slow', 'No blockers but team morale low — need team check-in', 'Content gap is hurting inquiries. Need to batch-create for next two weeks.', 'pending'),
  ('a1000000-0000-0000-0000-000000000003', '2025-07-20', 'Luxe Hair Studio', '3 reels, 2 stories — strong reach on balayage reel', 22, 2, 'Up 18% vs two weeks ago, Wednesday and Friday strong', 'None this week', 'Best week in a month. Balayage content drove most DMs. Double down on this.', 'done');

insert into action_summaries (weekly_review_id, bottleneck_summary, bottleneck_summary_confidence, priority_score, priority_score_confidence, next_action, next_action_confidence) values
  ('a1000000-0000-0000-0000-000000000001', 'Follow-up backlog (5 open) combined with a 10% booking dip signals leads are falling through the cracks. Tuesday availability is the immediate capacity gap.', 0.87, 72, 0.82, 'Send a same-day re-engagement message to all 5 open follow-ups and offer a discounted Tuesday slot to fill the gap.', 0.84),
  ('a1000000-0000-0000-0000-000000000002', 'Zero content output created a 10-day inquiry drought. Nine unresolved follow-ups represent significant revenue at risk this week.', 0.91, 88, 0.89, 'Batch-record 4 short-form videos today, schedule them across the next two weeks, and clear the follow-up list before end of day Friday.', 0.90),
  ('a1000000-0000-0000-0000-000000000003', 'No meaningful blockers this week. Balayage content is the clear growth lever — inquiry volume rose 18% off a single reel.', 0.93, 35, 0.91, 'Plan a balayage content series (3 reels) for the next two weeks and capture before/after shots at every balayage appointment this week.', 0.92);