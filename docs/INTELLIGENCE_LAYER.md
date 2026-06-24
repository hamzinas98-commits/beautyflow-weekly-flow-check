# Intelligence Layer

## Messy Inputs
- Free-text booking trend: "Down a bit Tuesday, weekend fine"
- Team blockers: "Sarah was sick, no cover"
- Reflection notes: unstructured owner thoughts

## Auto-Structure Schema (sent to AI as JSON context)
```json
{
  "week_ending": "2025-07-20",
  "salon_name": "Luxe Hair Studio",
  "content_status": "3 reels, 2 stories — strong reach on balayage reel",
  "inquiries_count": 22,
  "follow_ups_pending": 2,
  "booking_trend": "Up 18% vs two weeks ago, Wednesday and Friday strong",
  "team_blockers": "None this week",
  "reflection_notes": "Best week in a month. Balayage content drove most DMs."
}
```

## AI Output Schema
```json
{
  "bottleneck_summary": "string (2 sentences max)",
  "priority_score": 35,
  "next_action": "string (one clear imperative sentence)"
}
```

## Scoring Rules (rule-based baseline, AI refines)
| Signal | Rule |
|---|---|
| follow_ups_pending ≥ 5 | +25 pts |
| booking_trend contains 'down' | +20 pts |
| content_status contains 'no post' or empty | +20 pts |
| team_blockers not 'none' | +15 pts |
| inquiries_count < 5 | +10 pts |

Rule total = baseline score. AI adjusts ±15 based on full context. Score stored with confidence.

## v1 vs Later
- **v1:** Rule baseline + GPT-4o single call; structured JSON response parsed server-side.
- **Later:** Fine-tune on confirmed/rejected outcomes; multi-signal trend scoring across weeks.
