# Agentic Layer

## Risk Levels & Actions

### Low Risk — Auto-executed
- Generate `bottleneck_summary` from weekly answers *(summarise)*
- Generate `priority_score` from rule baseline + AI *(score)*
- Draft `next_action` text *(draft)*

### Medium Risk — User confirms before saving
- Overwrite `next_action` with AI-revised version after user edits *(update field)*
- Set `confirm_status` to `confirmed` *(status change)*

### High Risk — Always requires explicit approval *(not v1)*
- Send next action as a WhatsApp or GHL message to the salon owner

### Critical — Human-only *(not v1)*
- Delete historical weekly review records
- Export or transmit real client data

## Named Tools (v1)
| Tool | Input | Output |
|---|---|---|
| `generate_action_summary` | weekly_review row | action_summaries row |
| `update_next_action` | review id + new text | updated next_action + is_user_edited=true |
| `confirm_review_action` | review id | confirm_status = confirmed |

## Audit Log Fields
- `table_name`, `row_id`, `action` (insert/update), `changed_fields` (jsonb), `actor` (user_id or 'system'), `created_at`

## v1 vs Later
- **v1:** Only `generate_action_summary` runs automatically; other tools are triggered by user button clicks.
- **Later:** Carry-forward tool flags unresolved actions; WhatsApp send tool added at high-risk tier.
