# Security

## Secret Handling
- `OPENAI_API_KEY` and `SUPABASE_SERVICE_ROLE_KEY` live in Vercel environment variables only.
- All AI calls run in Next.js server actions or API routes — keys never reach the browser.
- Client uses only the Supabase anon key for reads/writes within RLS policy bounds.

## Permission Model
- **v1 (demo):** Open RLS policies — any visitor can read and write. Safe for internal demo only; no real client data.
- **Lock-down sprint:** Email/password auth added; all new rows stamped with `auth.uid()`; RLS policies changed to `auth.uid() = user_id`; seed demo rows remain readable for anonymous visitors via a separate public flag or a dedicated demo account.

## Approved Tools Rule
- Only the three named tools in `AGENTIC_LAYER.md` may be invoked by server code.
- No `eval`, `run_any`, or dynamic tool dispatch.
- Every tool call writes an audit entry before returning.

## Audit Principle
- Every meaningful state change (new review, AI generation, action edit, confirm) is logged with actor + timestamp + changed fields.
- Logs are append-only; no tool or user action deletes them.
