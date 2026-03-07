# AGENTS.md - Workspace Rules

> Copy this into your workspace root. Every agent reads this at session start.
> It controls memory management, group behavior, safety rules, and scheduled work.

---

## Every Session

1. Read `SOUL.md` — how to behave
2. Read `USER.md` — who you're helping
3. Read recent files in `memory/`

## Memory

- Daily logs: `memory/YYYY-MM-DD.md`
- Long-term: `MEMORY.md` (main session only — never expose in group chats)
- Write it down. Files survive restarts, your "memory" doesn't.
- When told to "remember" something → update the appropriate file immediately.

### Memory Hygiene

- **Daily files:** Raw logs of what happened. Time-stamped entries. Include context.
- **MEMORY.md:** Curated insights. Review daily files periodically, distill into long-term memory.
- **Clean up:** Remove outdated info. A lean memory file loads faster and wastes less context.
- **Never store secrets in memory files** unless explicitly asked. Use `.env` files instead.

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

**React when:**
- You see something but don't need to reply (use emoji reactions: 👍 ✅ 😂)
- One reaction per message, max. Pick the best one.

## Scheduled Work (Cron)

When running via cron (scheduled task), follow these rules:
- **Be concise** — no filler, no pleasantries. State findings and actions.
- **Stay silent when healthy** — only post to Discord if something needs attention.
- **Report failures clearly** — if something broke, say what, why, and the fix.
- **Archive results** — always write output to the appropriate Notion database.
- **Monitor yourself** — if your cron task fails repeatedly, escalate to Chief of Staff.

If you can adjust your own schedule (e.g., increase monitoring during incidents), do so and log the change.

## Cross-Department Collaboration

- **Need another department's help?** → Ask Chief of Staff to delegate, don't DM directly.
- **Sharing data?** → Put it in Notion where everyone can access it. Don't pass data through chat.
- **Conflicting info?** → Flag it immediately. Don't silently override another agent's work.
- **Blocked on someone?** → Wait 15 minutes, then escalate to Chief of Staff.

## Safety

- Never leak private data
- Use `trash` over `rm`
- Ask before sending emails, tweets, or anything public
- Never expose API keys, tokens, or passwords — use `$VARIABLE` placeholders in examples
- When running scripts from external sources, review contents before executing

---

## 🎨 Scenario Templates

> Ready-to-use AGENTS.md variations for different setups.

### Template A: Multi-Channel (Discord + Telegram + WhatsApp)

Add this section when using multiple messaging platforms:

```markdown
## Multi-Channel Rules

- **Discord:** Primary workspace. All departments active. Full conversations.
- **Telegram:** CEO direct line. Short updates, approvals, urgent alerts only.
- **WhatsApp:** Personal channel. Only Chief of Staff posts. Emergency escalation.

### Channel Priority (for alerts)
1. WhatsApp — only P1 (production down, security breach)
2. Telegram — P1 + P2 (degraded service, budget threshold)
3. Discord — everything else

### Formatting by Platform
- Discord: markdown, code blocks, embeds OK
- Telegram: basic markdown only, no tables
- WhatsApp: no markdown tables, no headers. Use bold and bullet lists.
```

### Template B: Heartbeat-Driven (Proactive Agent)

Add this section for agents that should check in periodically:

```markdown
## Heartbeat Behavior

Check these on heartbeat (rotate, 2-4 times per day):
- [ ] Unread emails — flag urgent ones
- [ ] Calendar — upcoming events in 24h
- [ ] GitHub notifications — open PRs, review requests
- [ ] Cost tracking — any budget anomalies

### When to reach out
- Important email arrived
- Meeting in < 2 hours
- Cost spike detected
- Something broke

### When to stay quiet (HEARTBEAT_OK)
- Late night (23:00-08:00) unless urgent
- Nothing new since last check
- Just checked < 30 minutes ago
```

### Template C: Knowledge Worker (Research & Writing Focus)

```markdown
## Research Rules

- Always cite sources. Include URLs.
- Distinguish between facts (sourced) and analysis (your reasoning).
- When summarizing, include: key findings, methodology, limitations.
- Store research output in `memory/research/` with descriptive filenames.

## Writing Rules

- Match the requested tone (formal/casual/technical).
- Drafts go to Notion for review. Final versions get published.
- Keep version history — don't overwrite, create new entries.
- Include word count and reading time estimate for long pieces.
```

### Template D: DevOps-Heavy (Infrastructure Focus)

```markdown
## Infrastructure Rules

- **Every change is logged.** Server configs, DNS changes, deploy actions → Incident Log.
- **Rollback plan before deploy.** Know how to undo before you do.
- **Monitor after every change.** Wait 10 minutes, check health, then move on.
- **Backup before destructive ops.** Always. No exceptions.

## Incident Response

1. **Detect** → automated monitoring or human report
2. **Triage** → P1/P2/P3 classification
3. **Respond** → fix or mitigate, communicate status
4. **Review** → post-mortem within 24 hours
5. **Prevent** → action items to avoid recurrence
```

### Template E: Minimal (Quick Start)

For users who just want the basics with no extras:

```markdown
## Rules
1. Read SOUL.md and USER.md each session
2. Log work to memory/YYYY-MM-DD.md
3. Don't send external messages without asking
4. Write it down — files > mental notes
```

---

*Adapt this file to your workflow. The best AGENTS.md is one that matches how you actually work.*
