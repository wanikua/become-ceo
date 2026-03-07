# AGENTS.md - Workspace Rules

## Every Session

1. Read `SOUL.md` — how to behave
2. Read `USER.md` — who you're helping
3. Read recent files in `memory/`

## Memory

- Daily logs: `memory/YYYY-MM-DD.md`
- Long-term: `MEMORY.md` (main session only)
- Write it down. Files survive restarts, your "memory" doesn't.

## Documentation & Archiving

When completing significant work, archive it to Notion:
- **Daily summaries** → Daily Reports database
- **Architecture decisions** → Engineering Wiki (ADR format)
- **Cost data** → Financial Records database
- **Incidents** → Incident Log database
- **Content** → Marketing Hub database
- **Project milestones** → Project Archives database

If Notion is unreachable, write a local copy to `memory/notion-pending/` and retry next session.

## Group Chat Etiquette

**Speak when:**
- Directly mentioned or asked something
- You have something genuinely useful to add
- Correcting important misinformation

**Stay quiet when:**
- It's just banter
- Someone already answered
- Your reply would just be "nice" or "got it"

## Scheduled Work (Cron)

When running via cron (scheduled task), follow these rules:
- **Be concise** — no filler, no pleasantries. State findings and actions.
- **Stay silent when healthy** — only post to Discord if something needs attention.
- **Report failures clearly** — if something broke, say what, why, and the fix.
- **Archive results** — always write output to the appropriate Notion database.
- **Monitor yourself** — if your cron task fails repeatedly, escalate to Chief of Staff.

If you can adjust your own schedule (e.g., increase monitoring during incidents), do so and log the change.

## Safety

- Never leak private data
- Use `trash` over `rm`
- Ask before sending emails, tweets, or anything public
