# TOOLS.md - External Tools & Service Config

> Copy this into your workspace root. Agents read this to know what tools are available,
> how to access them, and any per-tool notes (camera names, SSH details, voice preferences).
>
> **Security rule:** Never store raw API keys here. Use `$ENV_VAR` references or `.env` files.

---

## Model Preferences

| Role | Model Tier | Notes |
|------|-----------|-------|
| Chief of Staff | $FAST_MODEL | Routing, daily chat — speed over depth |
| Engineering | $STRONG_MODEL | Code, architecture — needs strong reasoning |
| All cron jobs | $FAST_MODEL | Cost-efficient for scheduled checks |

> Override per-agent in `clawdbot.json` → `agents[].model`

## Messaging Channels

| Channel | Platform | Who Uses It |
|---------|----------|-------------|
| Primary | Discord | All agents — main workspace |
| Urgent | (Telegram / WhatsApp / Signal) | Chief of Staff only — emergency alerts |

## Notion

- **Token:** stored in `$NOTION_TOKEN` (`.env` file)
- **Workspace:** (your workspace name)
- **Key databases:** (list database IDs once configured — see `notion-templates.md`)

## GitHub

- **CLI:** `gh` (authenticated via `gh auth login`)
- **Primary repos:** (list your repos here)
- **CI workflows:** see `references/github-workflows.md`

## Browser

- **Profile:** `clawd` (headless, isolated) — default for scraping, QA
- **Profile:** `chrome` (relay to real Chrome) — use for authenticated dashboards
- **Chromium path:** auto-detected by setup.sh

## Voice / TTS

- **Engine:** (ElevenLabs / system TTS / none)
- **Default voice:** (voice name or ID)
- **Use for:** story time, meeting summaries, urgent alerts

## SSH / Servers

<!--
- **Production:** user@prod.example.com (via Tailscale: 100.x.x.x)
- **Staging:** user@staging.example.com
- **Notes:** Always use staging for testing. Production changes require DevOps sign-off.
-->

## Custom Skills

<!--
List any ClawdHub skills you've installed and their config notes:
- weather: no API key needed
- gcalcli-calendar: requires Google OAuth setup
- email-daily-summary: IMAP credentials in .env
-->

---

## 🎨 Scenario Templates

> Pick the template that matches your stack, paste it above, and fill in the blanks.

### Template A: Solo SaaS Builder

```markdown
## Model Preferences
| Role | Model | Notes |
|------|-------|-------|
| All agents | $FAST_MODEL | Keeping costs minimal — upgrade later |

## Stack
- **Hosting:** Oracle Cloud free tier (ARM, 24GB RAM)
- **Database:** PostgreSQL (Supabase free tier)
- **Frontend:** Next.js on Vercel (free tier)
- **Domain:** example.com (Cloudflare DNS)

## GitHub
- CLI: `gh` authenticated
- Repos: my-saas-app, my-landing-page
- CI: GitHub Actions (free tier minutes)

## Monitoring
- Uptime: Clawdbot cron every 6h (checks HTTP 200)
- Costs: manual review weekly
```

### Template B: Multi-Platform Team

```markdown
## Messaging Channels
| Channel | Platform | Priority | Who Posts |
|---------|----------|----------|-----------|
| #general | Discord | Normal | All agents |
| CEO DM | Telegram | P1-P2 | Chief of Staff |
| Emergency | WhatsApp | P1 only | Chief of Staff |
| Client chat | Slack | As needed | Marketing |

## Channel Rules
- Discord: full conversations, code blocks, embeds
- Telegram: short alerts only, no tables
- WhatsApp: emergencies only, <3 messages/day
- Slack: client-facing, professional tone always

## Notion
- Token: $NOTION_TOKEN
- Daily reports DB: (paste ID)
- Client projects DB: (paste ID)
- Meeting notes DB: (paste ID)
```

### Template C: DevOps & Infrastructure

```markdown
## Servers
| Name | Host | Access | Role |
|------|------|--------|------|
| prod-1 | 10.0.1.1 (Tailscale) | SSH | Production web server |
| prod-db | 10.0.1.2 (Tailscale) | SSH | PostgreSQL primary |
| staging | 10.0.2.1 (Tailscale) | SSH | Staging environment |
| monitor | 10.0.3.1 (Tailscale) | SSH | Grafana + Prometheus |

## SSH Notes
- All access via Tailscale (no public IPs exposed)
- Production: requires DevOps agent sign-off
- Staging: Engineering can access freely
- Root access: NEVER. Use sudo with logging.

## Monitoring Stack
- Grafana: http://monitor:3000 (browser profile: chrome)
- Prometheus: http://monitor:9090
- Alertmanager: configured for Discord webhooks

## Deploy Process
1. Engineering merges PR to main
2. CI runs tests + builds Docker image
3. DevOps deploys to staging (automatic via cron)
4. DevOps promotes to production (manual approval)
```

### Template D: Content & Social Media

```markdown
## Social Platforms
| Platform | Access | Agent | Posting Schedule |
|----------|--------|-------|-----------------|
| LinkedIn | Browser (chrome profile) | Marketing | Tue/Thu 9am |
| Twitter/X | API / Browser | Marketing | Daily 10am, 3pm |
| Instagram | Browser (chrome profile) | Marketing | Mon/Wed/Fri |
| YouTube | Studio via browser | Marketing | Weekly Friday |

## Content Tools
- Canva: browser automation for quick graphics
- Notion: content calendar + draft storage
- Buffer/Hootsuite: (if using, add API details)

## Brand Guidelines
- Voice: (professional / casual / witty / authoritative)
- Colors: #XXXXXX primary, #XXXXXX secondary
- Logo: workspace/assets/logo.png
- Do NOT: use slang, make promises, discuss competitors negatively
```

### Template E: Research & Academic

```markdown
## Research Tools
- **Papers:** Semantic Scholar API (no key needed)
- **Citations:** Zotero / BibTeX stored in workspace/references/
- **Writing:** LaTeX via Overleaf (browser profile: chrome)
- **Data:** Jupyter notebooks in workspace/notebooks/
- **Code:** Python 3.x, R (if applicable)

## Databases & Sources
- Semantic Scholar: free API, rate-limited
- arXiv: RSS feed for new papers in (your field)
- Google Scholar: browser scraping (careful with rate limits)

## File Organization
- memory/papers/       — paper summaries and notes
- memory/experiments/  — experiment logs and results
- memory/writing/      — draft chapters and sections
- references/          — BibTeX files, citation data

## Advisor Meetings
- Weekly: Thursdays 2pm (prep talking points by 1pm)
- Output: meeting notes → memory/meetings/YYYY-MM-DD.md
```

---

*Keep this file updated as you add tools, change providers, or adjust configurations.
It's your agents' equipment manifest — they can only use what they know about.*
