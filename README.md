[中文说明](./README_CN.md)

# 🏢 Become CEO — Your AI Executive Team on Discord

> One free server + [Clawdbot](https://github.com/clawdbot/clawdbot) = a 7-person team that works 24/7

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Built on Clawdbot](https://img.shields.io/badge/built%20on-Clawdbot-8A2BE2)](https://github.com/clawdbot/clawdbot)
[![Discord](https://img.shields.io/badge/interface-Discord-5865F2?logo=discord&logoColor=white)](https://discord.com)
[![One-Click Setup](https://img.shields.io/badge/setup-5%20minutes-brightgreen)](https://github.com/wanikua/become-ceo#quick-start)
[![Skills](https://img.shields.io/badge/skills-60%2B%20built--in-orange)](https://github.com/wanikua/become-ceo#built-in-skills-60)

**Ship features. Track spend. Write content. Run standup. Deploy to prod.**
Type one message in Discord — your team handles the rest.

### See it in action

```
You:          @Engineering build me a user auth API with JWT
Engineering:  On it. [opens thread, writes code, pushes to GitHub]

You:          @Finance how much did our API calls cost this month?
Finance:      $47.23 — up 30% from last month. Want me to find where the spike is?

You:          @everyone Monday standup. What's everyone working on?
Everyone:     [Each agent reports in with their status]
```

### What you get in 5 minutes

- 🤖 **7 specialized AI agents**, each with their own Discord bot, personality, and expertise
- 🧠 **Persistent memory** — agents remember your codebase, your budget, your preferences
- 🛠️ **60+ real tools** — GitHub, Notion, browser, cron, TTS, and more (not just chat)
- ⏰ **24/7 autonomous operation** — scheduled tasks run while you sleep
- 💰 **Smart cost control** — strong models for heavy work, fast models for everything else
- 🔒 **Sandboxed execution** — optional Docker isolation for safe code execution

---

> 📌 **About Originality** — This project is the English adaptation of [AI Court Tutorial](https://github.com/wanikua/boluobobo-ai-court-tutorial) (first commit 2026-02-22), the original implementation of "ancient governance systems as AI multi-agent orchestration." We noticed [cft0808/edict](https://github.com/cft0808/edict) (first commit 2026-02-23, ~21 hours later) shares highly similar framework choices, SOUL.md personality files, deployment methods, and competitor comparison tables — see [Issue #55](https://github.com/cft0808/edict/issues/55).
>
> **Redistribution welcome — please credit the source.**

---

## Why This Setup?

|  | ChatGPT / Web UIs | AutoGPT / CrewAI / MetaGPT | **Become CEO** ✅ |
|---|---|---|---|
| **Multi-agent collab** | ❌ Single generalist | ⚠️ Python orchestration required | ✅ Config file — zero code |
| **Independent memory** | ❌ Forgets between sessions | ⚠️ Roll your own vector DB | ✅ Each agent has its own workspace + persistent files |
| **Tool integrations** | ⚠️ Limited plugins | ⚠️ Build them yourself | ✅ 60+ built-in (GitHub, Notion, browser, cron…) |
| **Interface** | Web browser only | CLI / custom UI | ✅ Discord — phone, tablet, desktop |
| **Setup time** | None (SaaS) | Hours of Docker + coding | ✅ **5 minutes**, one script |
| **Always-on** | ❌ Manual conversations | ⚠️ Requires setup | ✅ Cron tasks + heartbeat self-checks |
| **Cost control** | ❌ Fixed subscription | ⚠️ Manual | ✅ Per-agent model tiers (save ~5×) |

> **The core difference: this isn't a framework — it's a finished product.** Run one script, get a working team. `@mention` anyone, they respond.

---

## Table of Contents

- [Discord as Your Company HQ](#discord-as-your-company-hq) — Channel architecture, voice control, TTS config, bot setup
- [Multi-Agent Collaboration Deep-Dive](#multi-agent-collaboration-deep-dive) — Delegation, error handling, monitoring, escalation, workflow templates
- [Notion Integration](#notion-integration--your-companys-knowledge-base) — Auto-archiving, daily/weekly reports, knowledge graph, relations & rollups, executive dashboard, incident post-mortems, backup & sync
- [GitHub Integration](#github-integration--your-engineering-pipeline) — Issue triage, PR management, code review, CI/CD automation, repo analytics, branch protection, release automation, multi-repo management, GitHub Projects, workflow templates, security scanning, conventional commits, GitHub Discussions
- [Browser Automation](#browser-automation--your-eyes-on-the-web) — Web scraping, social media management, screenshot verification, form automation, competitive analysis, multi-step workflows, browser profiles, error recovery, responsive testing, automation recipes
- [Architecture](#architecture) — How it works under the hood
- [Your Team](#your-team) — The 7 agents and their roles
- [Core Capabilities](#core-capabilities) — What makes this different
- [Prerequisites](#prerequisites) — What you need before starting
- [Quick Start](#quick-start) — Get running in 5 minutes
- [What It Looks Like](#what-it-looks-like) — Real usage examples
- [Config Deep-Dive](#config-deep-dive) — Customize everything
- [Growing Your Team](#growing-your-team) — Add new specialists
- [FAQ](#faq) — Common questions answered
- [Troubleshooting](#troubleshooting) — Fix common issues fast

---

## Discord as Your Company HQ

Your Discord server isn't just a chat room — it's your **entire company headquarters**. Here's how to structure it:

### Recommended Channel Layout

```
🏢 YOUR COMPANY
├── 📋 GENERAL
│   ├── #lobby              — casual chat, ask anyone anything
│   ├── #announcements       — company-wide updates
│   └── #standup             — daily automated standups (cron → here)
│
├── ⚔️ ENGINEERING
│   ├── #dev-general         — architecture discussions, code questions
│   ├── #code-review         — @Engineering reviews PRs here
│   ├── #bugs                — bug reports, @Engineering triages
│   └── #deployments         — release notes, deploy status
│
├── 💰 FINANCE
│   ├── #budget              — cost tracking, spend reports
│   └── #billing-alerts      — automated cost spike notifications
│
├── 🎭 MARKETING
│   ├── #content             — blog drafts, social media posts
│   ├── #brand               — design feedback, brand guidelines
│   └── #analytics           — engagement metrics, campaign results
│
├── 🔧 DEVOPS
│   ├── #infrastructure      — server status, scaling decisions
│   ├── #monitoring          — automated alerts, uptime checks
│   └── #incidents           — postmortems, incident response
│
├── 👔 MANAGEMENT
│   ├── #projects            — project tracking, milestones
│   ├── #hiring              — job descriptions, candidate pipeline
│   └── #meetings            — meeting notes, agendas
│
├── ⚖️ LEGAL
│   ├── #compliance          — policy reviews, regulatory updates
│   └── #contracts           — contract drafts, NDA tracking
│
└── 🤖 META
    ├── #bot-logs            — agent activity logs
    └── #bot-config          — configuration discussions
```

### Why This Structure Works

- **Department isolation** — Engineering discussions don't clutter Finance's view
- **Focused context** — when you `@Engineering` in `#code-review`, the agent has channel context about what's being reviewed
- **Auto-threading** — complex tasks spawn threads automatically, keeping channels clean
- **Cron targeting** — schedule daily standups to post in `#standup`, cost alerts to `#billing-alerts`
- **Onboarding** — new team members instantly see the org structure and know where to go

### Channel Permissions Tip

Restrict each bot's write permissions to relevant channels only. Engineering doesn't need to post in `#compliance`. This keeps things organized and prevents cross-talk:

```
#code-review  →  @Engineering bot: Send Messages ✅
#budget       →  @Finance bot:     Send Messages ✅
#content      →  @Marketing bot:   Send Messages ✅
```

> 💡 **All bots should have Read access everywhere** so they understand company context when asked cross-functional questions. Just restrict **write** access to keep channels focused.

### Voice Channels — Command Your Team by Voice

Discord voice channels open up a powerful workflow: **talk to your AI team instead of typing**.

```
🏢 YOUR COMPANY
├── 🔊 VOICE
│   ├── 🔊 war-room          — voice-to-text → all agents listen
│   ├── 🔊 engineering-sync  — voice standup with Engineering
│   └── 🔊 brainstorm        — creative sessions with Marketing
```

**How it works:**
1. Join a voice channel and speak
2. Discord's built-in voice-to-text transcribes your speech
3. The transcription appears as a text message → agents pick it up and respond
4. Agents can respond with **TTS (text-to-speech)** for a full voice conversation

```
You (voice):     "Engineering, what's the status on the API refactor?"
Engineering:     🔊 "Three endpoints done, two remaining. The auth middleware
                 is the bottleneck — should be wrapped up by end of day."

You (voice):     "Finance, are we still under budget this month?"
Finance:         🔊 "Yes, $38 spent against a $50 budget. Engineering's
                 strong model usage is 60% of that."
```

> 💡 **TTS is a built-in Clawdbot skill** — agents can respond with voice automatically. Configure it in your agent's identity to enable voice responses in voice channels.

### Running a Team Meeting by Voice

Discord voice channels let you run a full executive meeting — speak your agenda, and each agent responds in turn:

```
You (voice):       "Alright team, let's do a quick sync. Engineering, go first."
Engineering (TTS): "Auth refactor is 80% done. Blocked on the OAuth provider
                    docs being outdated. I worked around it — PR is up for review."

You (voice):       "Good. Finance, any budget concerns this week?"
Finance (TTS):     "We're at $34 of $50 budget. Engineering's strong model usage
                    spiked Tuesday during the refactor — I'd recommend switching
                    to fast model for code review tasks to save about $8/week."

You (voice):       "Marketing, what's the content pipeline look like?"
Marketing (TTS):   "Two blog posts drafted. SEO analysis shows we should target
                    'AI automation' keywords — I'll adjust the headlines. Want me
                    to post the first one today?"

You (voice):       "Yes, publish it. DevOps, are we good on infrastructure?"
DevOps (TTS):      "All green. SSL cert renews in 12 days — I'll handle it
                    automatically. Uptime is 99.97% this month."
```

The entire meeting happens hands-free. You don't touch a keyboard.

### Voice Notification Routing

Configure agents to **proactively speak up** when something urgent happens — even if you didn't ask:

```
# Finance detects a cost anomaly via scheduled cron check
Finance (TTS):     "⚠️ Heads up — API spend jumped 40% in the last 2 hours.
                    Looks like Engineering's coding agent is in a loop.
                    Want me to flag Engineering to investigate?"

You (voice):       "Yes, do it."
Finance:           → spawns task to Engineering
Engineering (TTS): "Found it — the retry logic had no backoff. Fixing now."
```

This turns Discord into a **real-time operations center** where your AI team monitors, reports, and escalates — all by voice.

### Combining Text + Voice Workflows

You don't have to pick one or the other. The most effective workflow combines both:

| Task | Best Channel |
|------|-------------|
| Quick status checks | 🔊 Voice — fastest way to get updates |
| Detailed code review | 💬 Text — you want to see the code |
| Brainstorming | 🔊 Voice — faster back-and-forth, less typing |
| Complex instructions | 💬 Text — precise, referenceable, can include links/code |
| Meeting summaries | 💬 Text — agents auto-post written summaries after voice meetings |
| Urgent alerts | 🔊 Voice — grabs your attention immediately |

> 💡 **Pro tip:** After a voice meeting, ask the Chief of Staff to "summarize what we just discussed and post it to `#standup`." You get the speed of voice with the permanence of text.

### Enabling TTS for Your Agents

To make an agent respond with voice, enable TTS in their identity configuration:

```json
{
  "id": "engineering",
  "identity": {
    "name": "Engineering",
    "theme": "You are the Engineering lead. Direct, working solutions.",
    "emoji": "⚔️"
  },
  "tts": {
    "enabled": true,
    "voice": "alloy"
  }
}
```

Each agent can have a different voice — give Engineering a deep, authoritative tone and Marketing something more upbeat. Your team literally sounds different, making it easy to know who's talking in a voice channel.

> 💡 Clawdbot's built-in `tts` skill converts text to speech on the fly. For advanced voice options (custom voices, multilingual), check out the ElevenLabs TTS integration on [ClawdHub](https://clawdhub.com).

### Discord Bot Threads — Auto-Organized Work

When an agent works on a complex task, Clawdbot automatically creates a **Discord thread** to keep the main channel clean:

```
#dev-general
├── 💬 You: @Engineering refactor the auth module
│   └── 🧵 Thread: "Auth Module Refactor"
│       ├── Engineering: Here's my plan...
│       ├── Engineering: PR ready — github.com/you/app/pull/42
│       └── Engineering: ✅ Merged. Auth module now uses refresh tokens.
│
├── 💬 You: @Engineering set up rate limiting on the API
│   └── 🧵 Thread: "API Rate Limiting"
│       └── Engineering: Working on it...
```

Threads keep your channels scannable. You see the high-level request in the channel; the detailed work lives in the thread. No more scrolling through 50 messages of code output to find the next conversation.

### Bot Status & Presence

Your bots show as "online" in Discord's member list, making your AI team feel like real coworkers. You can customize their status to show what they're working on or their current availability:

```
👥 ONLINE — 8
    ⚡ Chief of Staff    — Watching the team
    ⚔️ Engineering       — Coding
    💰 Finance           — Reviewing spend
    🎭 Marketing         — Drafting content
    🔧 DevOps            — Systems nominal
    👔 Management        — Tracking projects
    ⚖️ Legal             — Reviewing contracts
    👤 You               — Being the CEO
```

### Creating 7 Discord Bots — Step by Step

This is the most time-consuming part of setup (~10 minutes). Here's the exact process:

**For each of the 7 roles** (Chief of Staff, Engineering, Finance, Marketing, DevOps, Management, Legal):

1. Go to [discord.com/developers/applications](https://discord.com/developers/applications)
2. Click **"New Application"** → name it (e.g., "Engineering")
3. Go to **Bot** tab → click **"Add Bot"**
4. Under **Privileged Gateway Intents**, enable:
   - ✅ **Message Content Intent** (required — bot can't read messages without this)
   - ✅ **Server Members Intent** (required for `@everyone` to work)
5. Click **"Reset Token"** → copy the token → paste into `clawdbot.json`
6. Go to **OAuth2** → **URL Generator**:
   - Scopes: `bot`, `applications.commands`
   - Bot Permissions: `Send Messages`, `Read Message History`, `View Channels`, `Create Public Threads`, `Send Messages in Threads`, `Use Slash Commands`
7. Copy the generated URL → open it → select your server → authorize

Repeat 7 times. Yes, it's tedious. But you only do it once.

> 💡 **Naming tip:** Name each application exactly like its role (Engineering, Finance, etc.) so you can tell them apart in the Developer Portal. Upload a unique avatar for each bot to make your Discord server feel alive.

> ⚠️ **Common mistake:** Forgetting to enable **Message Content Intent**. Without it, your bot connects to Discord but receives empty messages — it looks online but never responds. This is Discord's privacy restriction, not a Clawdbot bug.

---

## Multi-Agent Collaboration Deep-Dive

Your agents aren't just individual bots — they can **delegate work to each other**. This is the core mechanism that turns 7 independent agents into a coordinated team.

### How Sub-Agent Delegation Works

When an agent needs help from another specialist, it uses `sessions_spawn` to create a **background task** assigned to that specialist. The spawned agent works independently and reports back when done.

```
┌──────────────────────────────────────────────────────────────┐
│  You: @Chief of Staff "Launch the new product page"          │
└──────────────┬───────────────────────────────────────────────┘
               ▼
┌──────────────────────────────────────┐
│  Chief of Staff (orchestrator)       │
│  Breaks task into sub-tasks:         │
│                                      │
│  sessions_spawn → Engineering        │
│    "Build landing page with Next.js" │
│                                      │
│  sessions_spawn → Marketing          │
│    "Write hero copy + CTA text"      │
│                                      │
│  sessions_spawn → DevOps             │
│    "Set up Vercel deployment"        │
└──────┬───────────┬───────────┬───────┘
       ▼           ▼           ▼
   ┌────────┐ ┌────────┐ ┌────────┐
   │  Eng   │ │  Mktg  │ │ DevOps │    ← work in parallel
   │ (Code) │ │ (Copy) │ │(Deploy)│
   └───┬────┘ └───┬────┘ └───┬────┘
       └───────────┴───────────┘
               ▼
┌──────────────────────────────────────┐
│  Chief of Staff collects results     │
│  Posts combined update to Discord    │
└──────────────────────────────────────┘
```

Each spawned sub-agent runs in its own **isolated session** — they don't interfere with each other, and each has full access to the skill layer (GitHub, Notion, browser, etc.).

### Configuring Sub-Agent Permissions

Not every agent should be able to spawn every other agent. Use `subagents.allowAgents` to define who can delegate to whom:

```json
{
  "id": "main",
  "identity": { "name": "Chief of Staff", "emoji": "⚡" },
  "subagents": {
    "allowAgents": ["engineering", "finance", "marketing", "devops", "management", "legal"],
    "maxConcurrent": 8
  }
}
```

| Config Key | What It Does |
|------------|-------------|
| `allowAgents` | Whitelist of agent IDs this agent can spawn tasks for |
| `maxConcurrent` | Max number of sub-agent sessions running at the same time |

**Recommended permission structure:**

| Agent | Can Delegate To | Why |
|-------|----------------|-----|
| **Chief of Staff** | Everyone | Central coordinator — needs full access |
| **Engineering** | DevOps | Needs to trigger deployments after code changes |
| **Finance** | — | Doesn't need to spawn others |
| **Marketing** | — | Works independently |
| **DevOps** | Engineering | May need code fixes for infra issues |
| **Management** | Everyone | Project coordination requires cross-team access |
| **Legal** | — | Works independently |

To give Engineering delegation access to DevOps, add:

```json
{
  "id": "engineering",
  "subagents": {
    "allowAgents": ["devops"]
  }
}
```

### Real Example: Chain of Delegation

Here's what happens when you ask Chief of Staff to handle a complex, cross-functional task:

```
You:             @Chief of Staff We got a security vulnerability report.
                 Handle it end to end.

Chief of Staff:  Understood. Triaging now. Here's the plan:

                 → Spawning Engineering: review the CVE, patch the affected
                   code, write tests
                 → Spawning Legal: assess disclosure obligations and timeline
                 → Spawning DevOps: prepare hotfix deployment pipeline

[Engineering works in background — reads the codebase, writes patch, pushes PR]
[Legal works in background — checks compliance requirements]
[DevOps works in background — sets up fast-track deploy]

Chief of Staff:  ✅ All teams reported back:
                 • Engineering: patch merged (PR #87), tests passing
                 • Legal: no mandatory disclosure required for this severity,
                   but recommends a changelog entry
                 • DevOps: hotfix deployed to production, rollback ready

                 Shall I have Marketing draft a security update blog post?
```

The CEO gave **one command**. Three agents worked in parallel. Chief of Staff orchestrated everything and reported a unified result.

### Direct Agent-to-Agent Messaging

Beyond spawning sub-tasks, agents can also **send messages to each other's active sessions** using `sessions_send`. This is useful for real-time coordination:

```
# Engineering finishes a feature and notifies DevOps directly
Engineering → sessions_send(agentId: "devops"):
  "Feature branch `auth-v2` is ready. Please deploy to staging."

DevOps:  "Deploying auth-v2 to staging... Done. Staging URL:
          https://staging.example.com — running smoke tests now."
```

The difference:
- **`sessions_spawn`** — creates a new isolated session for a specific task (fire-and-forget)
- **`sessions_send`** — sends a message into an existing session (real-time coordination)

### Supervisor / Watchdog Pattern

You can configure an agent to act as a **supervisor** that monitors other agents' work. Add a cron job that periodically checks on active sessions:

```bash
# Every 2 hours, Management reviews what everyone is working on
clawdbot cron add \
  --name "team-check-in" --agent management \
  --cron "0 */2 * * *" \
  --message "Check all active agent sessions. Report: who's working on what, anything stuck or idle for >1 hour, any tasks that need escalation." \
  --session isolated --token <your-token>
```

Management becomes a **project oversight layer** — catching stuck tasks, flagging blockers, and keeping you informed without you having to ask.

### Error Handling & Resilience

Real work fails sometimes. Sub-agents can time out, hit API errors, or produce bad results. Here's how to handle it:

**Timeouts:** Set `runTimeoutSeconds` on `sessions_spawn` to prevent runaway tasks:

```
Chief of Staff:
  sessions_spawn(
    agentId: "engineering",
    task: "Refactor the payment module",
    runTimeoutSeconds: 300    ← kills the task after 5 minutes
  )
```

**What happens when a sub-agent fails:**

| Failure | What Happens | Recovery |
|---------|-------------|----------|
| **Timeout** | Task is killed, spawner gets a timeout notification | Retry with simpler scope, or escalate to CEO |
| **API error** | Clawdbot retries automatically (3×) | If persistent, the agent reports the failure back |
| **Bad output** | Spawner receives the result and can judge quality | Re-spawn with more specific instructions |
| **Agent unavailable** | Spawn fails immediately | Spawner falls back or reports to CEO |

**Building resilient delegation chains:**

```
# Chief of Staff's approach to a complex task:

1. Spawn Engineering with timeout: 300s
2. If Engineering succeeds → spawn DevOps for deployment
3. If Engineering fails/times out → report to CEO with error details
4. Never silently swallow failures — always surface them
```

> 💡 **Pro tip:** Include "If you encounter errors, report them clearly rather than guessing" in your agent's `identity.theme`. This prevents agents from hallucinating success when something actually broke.

### Monitoring Multi-Agent Work

When you have 7 agents working, you need visibility. Clawdbot provides built-in tools to see what's happening:

**List active sessions:**
```bash
# See all running sessions — who's working on what
clawdbot sessions list --active
```

```
Active Sessions:
  engineering  │ session_abc │ "Refactoring auth module"     │ 3m 22s
  devops       │ session_def │ "Setting up staging deploy"   │ 1m 45s
  marketing    │ session_ghi │ "Drafting launch blog post"   │ 5m 10s
```

**Check a specific agent's work:**
```bash
# Pull the last 10 messages from Engineering's session
clawdbot sessions history --session session_abc --limit 10
```

**In Discord — ask Chief of Staff to monitor:**
```
You:             @Chief of Staff what's everyone working on right now?

Chief of Staff:  📊 Team Status:
                 • Engineering: refactoring auth (3 min in, active)
                 • DevOps: staging deploy (almost done)
                 • Marketing: blog draft (needs review)
                 • Finance, Legal, Management: idle
```

This is exactly how a real Chief of Staff works — they maintain situational awareness so you don't have to ask each person individually.

### Escalation Patterns

Not everything should reach the CEO. Configure your agents to **handle what they can** and **escalate what they can't**:

```
┌──────────────────────────────────────────────┐
│              Escalation Pyramid              │
│                                              │
│                  👑 CEO                      │
│              (You — Discord)                 │
│         "Only bother me for big stuff"       │
│                    ▲                         │
│             escalate if:                     │
│         - budget > $100 impact               │
│         - production is down                 │
│         - legal/compliance risk              │
│         - conflicting priorities             │
│                    │                         │
│           ⚡ Chief of Staff                  │
│         (Coordinator — handles most)         │
│         - routes tasks between agents        │
│         - resolves minor conflicts           │
│         - consolidates status updates        │
│                    ▲                         │
│             escalate if:                     │
│         - cross-team dependency              │
│         - task blocked > 10 min              │
│         - unclear ownership                  │
│                    │                         │
│    ⚔️ Eng  💰 Fin  🎭 Mktg  🔧 DevOps      │
│         (Specialists — handle own domain)    │
│         - do the actual work                 │
│         - report results up                  │
│         - flag blockers immediately          │
└──────────────────────────────────────────────┘
```

**Encoding escalation behavior in agent themes:**

```json
{
  "id": "engineering",
  "identity": {
    "theme": "You are the Engineering lead. Handle coding tasks independently. Escalate to Chief of Staff if: (1) you need input from another department, (2) a task will take more than 30 minutes, or (3) you find a security issue. Never silently fail — always report back."
  }
}
```

This creates a **self-managing team** where most issues resolve without your involvement. You only hear about the important stuff.

### Ready-to-Use Workflow Templates

Copy these patterns for common multi-agent scenarios:

**🚀 Feature Launch (5 agents)**
```
You → Chief of Staff: "Launch user dashboard feature"

Chief of Staff orchestrates:
  1. Engineering: build the feature (spawn, strong model)
  2. Marketing: write announcement copy (spawn, fast model)
  3. DevOps: prepare deployment pipeline (spawn, fast model)
  4. [waits for all 3]
  5. DevOps: deploy to production (spawn)
  6. Marketing: publish announcement (spawn)
  7. Finance: log infrastructure cost change (send)

Result: Feature built, deployed, and announced — one command from you.
```

**🐛 Bug Triage (3 agents)**
```
You → Engineering: "Users report 500 errors on /api/checkout"

Engineering handles:
  1. Investigates logs, identifies root cause
  2. Writes fix, pushes PR
  3. send → DevOps: "Hotfix PR #92 ready, deploy ASAP"
  4. DevOps deploys, confirms fix
  5. Engineering → send → Chief of Staff: "Resolved. Root cause: null pointer in payment handler."

You get one update: "Fixed."
```

**📊 Monthly Report (4 agents)**
```
Cron triggers Chief of Staff: "Generate monthly report"

Chief of Staff orchestrates:
  1. Finance: "Pull this month's spend data and trends" (spawn)
  2. Engineering: "List all PRs merged, features shipped" (spawn)
  3. Marketing: "Summarize content performance metrics" (spawn)
  4. [waits for all 3]
  5. Chief of Staff compiles into unified report
  6. Posts to #announcements on Discord

Zero human involvement — runs automatically on the 1st of each month.
```

**🔐 Security Incident Response (4 agents, parallel + sequential)**
```
Alert → Chief of Staff: "Possible data breach detected"

Phase 1 — Parallel (immediate):
  spawn → Engineering: "Audit access logs for unauthorized access"
  spawn → DevOps: "Isolate affected service, rotate credentials"
  spawn → Legal: "Assess disclosure obligations"

Phase 2 — Sequential (after Phase 1):
  send → Engineering: "Patch the vulnerability"
  send → DevOps: "Deploy fix and restore service"
  spawn → Marketing: "Draft incident communication for users"

Phase 3 — Cleanup:
  Chief of Staff compiles incident report
  Posts to #incidents channel
  Schedules post-mortem meeting
```

### Anti-Patterns to Avoid

| ❌ Don't | ✅ Do Instead |
|----------|--------------|
| Let every agent spawn every other agent | Use `allowAgents` to restrict — prevent circular delegation |
| Spawn sub-agents for trivial tasks | Only delegate when the task genuinely requires another specialist |
| Chain 5+ levels of delegation | Keep delegation to 2 levels max (CEO → Chief of Staff → Specialist) |
| Let agents spawn themselves | This creates infinite loops — `allowAgents` should never include the agent's own ID |
| Ignore sub-agent failures silently | Always surface errors — add "report failures clearly" to agent themes |
| Skip timeouts on spawned tasks | Set `runTimeoutSeconds` — prevent runaway tasks from burning budget |

---

## Notion Integration — Your Company's Knowledge Base

Your AI team doesn't just chat — it **documents everything** to Notion automatically. Meeting notes, daily reports, project wikis, financial records — all organized in databases your whole team can search.

### Why Notion?

Discord is great for real-time work. But conversations scroll away. Notion is where knowledge **persists**:

- 📅 **Daily reports** — auto-generated standup summaries, archived forever
- 📊 **Weekly/monthly reviews** — trend analysis with actual data
- 📝 **Project documentation** — specs, decisions, postmortems
- 💰 **Financial records** — cost tracking in structured databases
- 🗂️ **Knowledge base** — SOPs, onboarding docs, technical references

### Recommended Notion Structure

Set up your Notion workspace to mirror your company departments:

```
🏢 Company HQ (parent page)
├── 📅 Daily Reports         ← database: auto-filled by Chief of Staff via cron
│   ├── 2026-03-07 Standup
│   ├── 2026-03-06 Standup
│   └── ...
│
├── 📊 Weekly Reports        ← database: auto-generated every Monday
│   ├── Week 10 Review
│   └── ...
│
├── 💰 Financial Records     ← database: cost tracking per day/week
│   ├── March API Spend
│   └── ...
│
├── 🖥️ Engineering Wiki      ← database: architecture docs, ADRs, runbooks
│   ├── Auth Module Design
│   ├── API Rate Limiting
│   └── ...
│
├── 📢 Marketing Hub         ← database: content calendar, campaign results
│   ├── Blog Post Pipeline
│   └── ...
│
├── 🗂️ Project Archives      ← database: per-project decision logs
│   ├── Project Alpha
│   └── ...
│
└── 📖 SOPs & Playbooks      ← pages: how we do things
    ├── Incident Response
    ├── Deploy Checklist
    └── ...
```

### Setting Up Notion Access

1. Go to [notion.so/my-integrations](https://www.notion.so/my-integrations)
2. Create a new integration → copy the token
3. Share your Notion pages with the integration (click "..." → "Add connections")
4. Add the token to your agent config or workspace:

```bash
# Store in your workspace's TOOLS.md or environment
NOTION_TOKEN=ntn_your_token_here
```

> 💡 Clawdbot's built-in **Notion skill** handles all API calls — agents can create pages, query databases, and update records using natural language. No code required.

### Auto-Archiving Daily Reports to Notion

The killer workflow: your Chief of Staff generates a daily standup and **automatically writes it to Notion**:

```bash
# Daily at 10 PM — generate report and save to Notion
clawdbot cron add \
  --name "daily-notion-report" --agent main \
  --cron "0 22 * * *" --tz "America/New_York" \
  --message "Generate today's standup report. Include: what each agent worked on, key decisions made, blockers. Post to Discord #standup AND create a new page in the Daily Reports Notion database." \
  --session isolated --token <your-token>
```

**What the agent does:**
1. Reviews the day's Discord conversations
2. Summarizes each agent's contributions
3. Posts a summary to `#standup` on Discord
4. Creates a structured Notion page in the Daily Reports database with:
   - Date, title, department breakdowns
   - Key metrics (PRs merged, costs, content published)
   - Action items for tomorrow

```
# Example Notion page created automatically:

📅 2026-03-07 Daily Report
━━━━━━━━━━━━━━━━━━━━━━━━━
⚔️ Engineering
  • Merged PR #42: auth module refactor
  • Started rate limiting implementation
  • Blocked: waiting on DevOps for staging env

💰 Finance
  • API spend today: $4.20 (within budget)
  • Flagged 15% increase in Engineering model usage

🎭 Marketing
  • Published blog post: "Why AI Teams Work"
  • Drafted social media calendar for next week

🔧 DevOps
  • SSL cert renewed (auto)
  • Uptime: 99.98%

📋 Action Items
  • [ ] Engineering: finish rate limiting
  • [ ] DevOps: provision staging environment
  • [ ] Marketing: review SEO keywords
```

### Weekly & Monthly Summaries to Notion

Scale the same pattern for longer-term reports:

```bash
# Weekly — every Monday at 9 AM
clawdbot cron add \
  --name "weekly-notion-summary" --agent main \
  --cron "0 9 * * 1" --tz "America/New_York" \
  --message "Create a weekly summary in the Weekly Reports Notion database. Review the past 7 daily reports, synthesize trends, highlight wins, flag risks. Include cost trends from Finance." \
  --session isolated --token <your-token>

# Monthly — 1st of each month at 9 AM
clawdbot cron add \
  --name "monthly-notion-review" --agent main \
  --cron "0 9 1 * *" --tz "America/New_York" \
  --message "Create a monthly review in Notion. Aggregate weekly summaries, show month-over-month trends, project ROI analysis, team performance metrics." \
  --session isolated --token <your-token>
```

This creates a **self-documenting company** — reports generate themselves, archive to Notion, and build a searchable history over time.

### Engineering → Notion: Auto-Document Technical Decisions

When Engineering makes architecture decisions, capture them in Notion automatically:

```
You:           @Engineering We need to decide: PostgreSQL or MongoDB for the
               new user service. Analyze and decide.

Engineering:   After analysis:
               • PostgreSQL wins for our use case — relational data,
                 ACID compliance needed for user accounts
               • MongoDB would only make sense for unstructured logs

               ✅ Decision: PostgreSQL
               📝 Documenting to Engineering Wiki on Notion...

               → Created: "ADR-003: Database Selection for User Service"
                 in Engineering Wiki database
```

Now every technical decision is **findable in Notion** months later, not buried in Discord scroll-back.

### Finance → Notion: Structured Cost Tracking

Finance can maintain a live cost database in Notion:

```
You:           @Finance log this month's costs to Notion

Finance:       📊 March 2026 cost data written to Financial Records:

               | Category      | Amount  | vs Last Month |
               |---------------|---------|---------------|
               | Strong Model  | $28.50  | +12%          |
               | Fast Model    | $8.20   | -5%           |
               | Server        | $0.00   | —             |
               | Total         | $36.70  | +8%           |

               → Notion page created with full breakdown and trend chart data.
               → Tagged: March 2026, Q1, API Costs
```

The Financial Records database becomes your **single source of truth** for cost tracking — queryable, filterable, and always up to date.

### Querying Notion from Discord

Your agents can also **read from Notion** to answer questions:

```
You:           @Chief of Staff what did we decide about the database last month?

Chief of Staff: Let me check the Engineering Wiki on Notion...

               Found: ADR-003 (Feb 15, 2026)
               Decision: PostgreSQL for User Service
               Rationale: ACID compliance, relational data model,
               team familiarity
               Status: Implemented (PR #38)
```

Notion becomes your team's **institutional memory** — even if agents' conversation context resets, the knowledge persists in structured databases.

### Notion Database Properties Template

When setting up your Notion databases, use these property schemas for best results:

**📅 Daily Reports Database:**
| Property | Type | Purpose |
|----------|------|---------|
| Title | Title | Report date + title |
| Date | Date | Report date (for calendar view) |
| Status | Select | Draft / Published |
| Departments | Multi-select | Which teams reported |
| Highlights | Rich text | Key achievements |
| Blockers | Rich text | Issues needing attention |
| Cost Today | Number | API spend for the day |

**💰 Financial Records Database:**
| Property | Type | Purpose |
|----------|------|---------|
| Title | Title | Period label (e.g., "March 2026") |
| Period | Date | Date range |
| Total Spend | Number | Total cost |
| Strong Model | Number | Strong model costs |
| Fast Model | Number | Fast model costs |
| Trend | Select | Up / Down / Flat |
| Notes | Rich text | Anomalies and recommendations |

> 💡 **Pro tip:** Create Notion database templates for each report type. When agents create new pages, they follow the template structure automatically — consistent, clean, every time. See [`references/notion-templates.md`](./become-ceo/references/notion-templates.md) for ready-to-use schemas.

### Cross-Agent Knowledge Sharing via Notion

The real power of Notion integration isn't individual agents writing docs — it's **agents reading each other's work**. Notion becomes the shared brain your team builds together:

```
┌─────────────────────────────────────────────────────────┐
│                    Notion (Shared Brain)                 │
│                                                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │ Eng Wiki │  │ Fin Recs │  │ Mktg Hub │  ...        │
│  │ ADR-001  │  │ Mar Cost │  │ Blog #5  │             │
│  │ ADR-002  │  │ Apr Cost │  │ Campaign │             │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘             │
│       │              │              │                   │
│       └──────────────┼──────────────┘                   │
│                      ▼                                  │
│         ┌────────────────────────┐                      │
│         │ Cross-references &     │                      │
│         │ linked databases       │                      │
│         └────────────────────────┘                      │
└───────────┬──────────┬──────────┬───────────────────────┘
            ▼          ▼          ▼
         ⚔️ Eng     💰 Fin     🎭 Mktg    (read + write)
```

**Example: Marketing uses Engineering's decision log**

```
You:             @Marketing write a blog post about our new database architecture

Marketing:       Let me check what Engineering documented on Notion...

                 Found: ADR-003 — "PostgreSQL for User Service"
                 Context: ACID compliance, relational model, team familiarity

                 📝 Blog draft: "Why We Chose PostgreSQL (and What We Learned)"
                 → Created in Marketing Hub database on Notion
                 → Tagged: Technical, Architecture, Blog Post
                 → Cross-linked to ADR-003 in Engineering Wiki
```

Marketing didn't hallucinate technical details — it pulled from Engineering's actual documentation.

**Example: Finance audits Engineering's spend**

```
Finance (cron):  Weekly cost review complete.

                 📊 Findings from cross-referencing:
                 • Engineering used Strong Model for 23 tasks this week
                 • 8 of those were simple formatting tasks (should use Fast Model)
                 • Estimated savings if switched: $6.40/week ($27.50/month)

                 → Updated Financial Records on Notion with recommendations
                 → Linked to Engineering's task log for traceability
```

Finance doesn't just report numbers — it correlates cost data with what agents actually did.

### Notion as Executive Dashboard

Configure your Chief of Staff or Management agent to **aggregate data across all Notion databases** for a unified view:

```
You:             @Management give me the executive dashboard

Management:      📊 Executive Dashboard — March 7, 2026

                 ═══ Engineering ═══
                 • 12 ADRs documented (3 new this month)
                 • 47 PRs merged, 2 open
                 • Tech debt score: improving (4 items resolved)

                 ═══ Finance ═══
                 • MTD spend: $36.70 (budget: $50)
                 • Runway: 14 days at current rate
                 • Top cost: Engineering Strong Model ($28.50)

                 ═══ Marketing ═══
                 • 5 blog posts published, 2 in draft
                 • Best performer: "AI Teams" (2.3k views)
                 • Content pipeline: 3 weeks ahead of schedule

                 ═══ Infrastructure ═══
                 • Uptime: 99.97% (SLA: 99.9% ✅)
                 • 0 open incidents (1 resolved this week)
                 • SSL certs: all valid, next renewal in 12 days

                 ═══ Projects ═══
                 • Active: 3 | Completed: 1 | At risk: 0
                 • Next milestone: Auth v2 launch (Mar 12)

                 Full data: [Notion Dashboard Link]
```

This is exactly what a CEO sees in a real company — one page that synthesizes everything.

### Incident Post-Mortem to Notion

When something breaks, your team documents the full incident lifecycle to Notion automatically:

```
DevOps (alert):  ⚠️ API latency spike detected — p99 at 3.2s (threshold: 500ms)

Chief of Staff:  Initiating incident response.
                 → Created INC-007 in Incident Log on Notion
                 → Status: Investigating
                 → Spawning Engineering to diagnose

Engineering:     Root cause: database connection pool exhausted.
                 Fix: increased pool size from 10 to 50.
                 → PR #94 merged, deploying now.
                 → Updated INC-007: Root Cause filled

DevOps:          Fix deployed. Latency back to 120ms.
                 → Updated INC-007: Status → Resolved, Duration: 14 minutes

Chief of Staff:  Post-mortem:
                 → Updated INC-007 with action items:
                   1. Add connection pool monitoring alert
                   2. Set auto-scaling threshold for DB connections
                   3. Update runbook with pool tuning steps
                 → Status → Post-mortem Done
                 → Linked to ADR-004: "Connection Pool Sizing"
```

Every incident is documented, searchable, and linked to the fix. Next time a similar issue occurs, agents can find the previous incident and apply the same solution.

### Notion Relations & Rollups — Connecting Your Data

Individual databases are useful. **Connected databases** are powerful. Use Notion's Relations and Rollups to build a knowledge graph your agents can traverse:

```
┌───────────────┐       ┌───────────────┐       ┌───────────────┐
│ 🗂️ Projects   │──────▶│ 💰 Fin Recs   │◀──────│ 📅 Daily Reps │
│               │       │               │       │               │
│ "Auth v2"     │       │ Mar API Spend │       │ 2026-03-07    │
│ Budget: $120  │       │ Total: $36.70 │       │ Cost: $4.20   │
│ Status: Active│       │ ↕ Rollup: sum │       │ Project: Auth │
└───────┬───────┘       └───────────────┘       └───────────────┘
        │
        ▼
┌───────────────┐       ┌───────────────┐
│ 🖥️ Eng Wiki   │──────▶│ 🔒 Incidents  │
│               │       │               │
│ ADR-003: PG   │       │ INC-007: Pool │
│ Project: Auth │       │ Related ADR:  │
│ Status: Done  │       │ ADR-004       │
└───────────────┘       └───────────────┘
```

**Key relation patterns:**

| Relation | From → To | Why |
|----------|-----------|-----|
| Project ↔ Costs | Projects → Financial Records | Track budget burn per project |
| Daily → Weekly | Daily Reports → Weekly Reports | Roll up daily data into weekly |
| ADR ↔ Incident | Engineering Wiki → Incident Log | Link fixes to root-cause decisions |
| ADR ↔ Project | Engineering Wiki → Projects | Track which decisions belong to which project |
| Incident → Daily | Incident Log → Daily Reports | Include incidents in daily summaries |
| Content → Project | Marketing Hub → Projects | Track content per project/launch |

**Using Rollups for automatic aggregation:**

```
# In the Projects database, add:
#   Relation: "Daily Costs" → Daily Reports database
#   Rollup:   "Total Cost" → sum of "Cost Today" from related Daily Reports
#
# Now each project page auto-calculates its total spend!

You:             @Management what's the total spend on Project Alpha?

Management:      Checking Notion...
                 Project Alpha — Total Spend (rollup): $142.30
                 Budget: $200 | Remaining: $57.70 | Burn rate: $4.70/day
                 At current rate, budget runs out in ~12 days.
```

> 💡 **Set up Relations in Notion UI** — the API can create relation properties, but it's easier to configure them visually in Notion. Once set up, agents can read and write related records via the API.

### Notion ↔ Workspace Backup

Discord conversations vanish into scroll-back. Notion could go down. Your workspace files are the **last line of defense**. Configure periodic backups from Notion to your workspace:

```bash
# Weekly — back up critical Notion data to workspace files
clawdbot cron add \
  --name "notion-backup" --agent main \
  --cron "0 3 * * 0" --tz "America/New_York" \
  --message "Export the last 7 days of Notion data to workspace. Query Daily Reports, Financial Records, and Incident Log databases. Write summaries to memory/notion-backup/YYYY-MM-DD.md. This is our disaster recovery copy." \
  --session isolated --token <your-token>
```

**What gets backed up:**

```
~/clawd/
└── memory/
    └── notion-backup/
        ├── 2026-03-07.md    ← daily reports, incidents, costs
        ├── 2026-02-28.md
        └── ...
```

This gives you a **local, searchable archive** of everything your team documented in Notion. If Notion is ever unreachable, agents can still reference the backup files.

> 💡 **Two-way sync:** Agents can also **restore to Notion from workspace files**. If you accidentally delete a Notion page, ask your Chief of Staff to recreate it from the backup in `memory/notion-backup/`.

### Notion Quick-Reference Card

Here's everything you need for Notion integration at a glance:

| Step | What to Do |
|------|-----------|
| **1. Create integration** | [notion.so/my-integrations](https://www.notion.so/my-integrations) → New → copy token |
| **2. Share pages** | Open each Notion page → "..." → Add connections → your integration |
| **3. Store token** | Add `NOTION_TOKEN=ntn_...` to your workspace env or TOOLS.md |
| **4. Create databases** | Use schemas from [`references/notion-templates.md`](./become-ceo/references/notion-templates.md) |
| **5. Set up relations** | Connect databases in Notion UI (Projects ↔ Costs, ADRs ↔ Incidents) |
| **6. Add cron jobs** | Daily reports, weekly summaries, monthly reviews (see examples above) |
| **7. Set up backup** | Weekly Notion → workspace export cron (disaster recovery) |

**Databases to create (recommended order):**

1. 📅 Daily Reports — your foundation, everything flows from here
2. 💰 Financial Records — cost tracking, budget monitoring
3. 🖥️ Engineering Wiki — ADRs, technical decisions
4. 🔒 Incident Log — outage tracking, post-mortems
5. 📊 Weekly Reports — aggregate dailies (add relation to Daily Reports)
6. 🌙 Monthly Reports — aggregate weeklies
7. 📢 Marketing Hub — content calendar
8. 🗂️ Project Archives — project-level view with cost rollups

> 💡 **Start with just #1 and #2.** You can always add more databases later. The daily report + cost tracking combo alone gives you 80% of the value.

---

## GitHub Integration — Your Engineering Pipeline

Your AI team doesn't just talk about code — it **manages your entire GitHub workflow**. Issues, PRs, code reviews, CI/CD pipelines — all driven by natural language commands on Discord.

### Why GitHub Integration Matters

Discord is where you give orders. Notion is where knowledge persists. **GitHub is where the work actually ships.** With Clawdbot's built-in GitHub skill, your agents can:

- 🐛 **Triage issues** — auto-label, assign, and prioritize incoming bug reports
- 🔀 **Manage PRs** — create, review, approve, merge, and close pull requests
- 🚀 **Trigger CI/CD** — kick off builds, check run status, re-run failed workflows
- 📋 **Create issues** — turn Discord conversations into trackable GitHub issues
- 🔍 **Code review** — Engineering reads diffs, spots bugs, suggests improvements
- 📊 **Repository analytics** — PR merge times, issue velocity, contributor stats

### Setting Up GitHub Access

Your agents use the `gh` CLI (GitHub CLI) under the hood. Set it up once:

```bash
# On your server, authenticate with GitHub
gh auth login

# Verify it works
gh auth status
```

> 💡 **The `gh` CLI is installed automatically** by the `setup.sh` script. If you're adding GitHub integration to an existing setup, just run `sudo apt install gh` and authenticate.

**For organization-level access**, use a GitHub App or fine-grained personal access token with these permissions:
- **Issues:** Read & Write
- **Pull Requests:** Read & Write
- **Actions:** Read & Write (for CI/CD)
- **Contents:** Read & Write (for code operations)

Store the token in your workspace environment — agents inherit it automatically.

### Issue Management — From Bug Report to Resolution

Turn your Discord channels into a **fully automated issue tracker**:

```
# A user reports a bug in Discord
User:            @Engineering the checkout page throws a 500 error
                 when the cart has more than 10 items

Engineering:     Investigating. Creating a GitHub issue to track this.

                 → Created: wanikua/myapp#142
                   Title: "Checkout 500 error with 10+ cart items"
                   Labels: bug, priority-high, checkout
                   Assignee: Engineering bot

                 I'll look at the code now...
```

**Auto-triage incoming issues with a cron job:**

```bash
# Every hour, Engineering checks for new untriaged issues
clawdbot cron add \
  --name "issue-triage" --agent engineering \
  --cron "0 * * * *" \
  --message "Check for new GitHub issues in wanikua/myapp without labels. For each: read the issue, add appropriate labels (bug/feature/docs/question), set priority (critical/high/medium/low), and post a comment with your initial assessment. If it's critical, notify Chief of Staff." \
  --session isolated --token <your-token>
```

**What auto-triage looks like:**

```
Engineering (cron): 📋 Issue Triage — 3 new issues processed:

  #143 "Login fails on Safari" 
    → Labels: bug, browser-compat, priority-high
    → Comment: "Likely a WebKit cookie handling issue. 
       Will investigate SameSite attribute."

  #144 "Add dark mode support"
    → Labels: feature, ui, priority-medium
    → Comment: "Feature request noted. Would require 
       CSS variable refactor. Estimated 2-3 days."

  #145 "Typo in API docs"
    → Labels: docs, priority-low, good-first-issue
    → Comment: "Quick fix. Opening a PR now."
    → PR #89 created with the fix ✅
```

Notice: simple issues get **fixed immediately** without human involvement. The agent triages, creates a PR, and moves on.

### Pull Request Workflows

Your Engineering agent handles the full PR lifecycle:

**Creating PRs from Discord:**

```
You:             @Engineering add rate limiting to the /api/search endpoint.
                 Max 100 requests per minute per API key.

Engineering:     Working on it.
                 [reads codebase, writes implementation, writes tests]

                 ✅ Done. PR created:
                 → wanikua/myapp#90 "Add rate limiting to /api/search"
                   • Added express-rate-limit middleware
                   • 100 req/min per API key (configurable)
                   • Tests: 4 new test cases, all passing
                   • CI status: ✅ green

                 Ready for your review, or I can merge it.
```

**Automated code review:**

```
You:             @Engineering review PR #91

Engineering:     Reviewing wanikua/myapp#91...

                 📝 Code Review — PR #91: "Refactor user authentication"

                 ✅ Good:
                 • Clean separation of auth middleware
                 • Proper error handling on token expiry
                 • Tests cover happy path + edge cases

                 ⚠️ Suggestions:
                 1. Line 42: `jwt.verify()` should use `algorithms: ['HS256']`
                    to prevent algorithm switching attacks
                 2. Line 78: Missing rate limit on /auth/refresh — could be
                    abused for token farming
                 3. Line 103: Consider using `httpOnly` flag on the cookie

                 🔴 Blocker:
                 • No input validation on the `redirect_uri` parameter
                   (potential open redirect vulnerability)

                 Recommend: fix the blocker, address suggestions, then merge.
                 Want me to push fixes directly?
```

**Cross-agent PR coordination:**

```
# Engineering finishes code, needs DevOps to deploy
Engineering:     PR #92 merged. @DevOps — ready for staging deployment.

DevOps:          Deploying PR #92 to staging...
                 → Triggered workflow: deploy-staging.yml
                 → Build: ✅ passed (2m 14s)
                 → Staging URL: https://staging.example.com
                 → Running smoke tests...
                 → All 12 smoke tests passed ✅

                 Staging is live. Want me to promote to production?
```

### CI/CD Pipeline Control

Your agents can trigger, monitor, and manage GitHub Actions workflows directly:

**Checking CI status:**

```
You:             @DevOps what's the CI status on our main repos?

DevOps:          📊 CI Status Overview:

                 wanikua/myapp (main)
                 └── Last run: ✅ passed (3m 22s) — 2 hours ago
                     Tests: 142/142 passing
                     Coverage: 87%

                 wanikua/api-gateway (main)
                 └── Last run: ❌ failed (1m 45s) — 6 hours ago
                     Failure: test_rate_limiting (timeout)
                     → This has failed 3 times this week

                 wanikua/landing-page (main)
                 └── Last run: ✅ passed (45s) — 1 day ago

                 ⚠️ api-gateway needs attention — flaky test detected.
                 Want me to investigate?
```

**Re-running failed workflows:**

```
You:             @DevOps re-run the failed CI on api-gateway

DevOps:          Re-running workflow on wanikua/api-gateway...
                 → Triggered: ci.yml (run #487)
                 → Status: running...
                 → ✅ Passed this time (2m 01s)

                 The test_rate_limiting failure was intermittent.
                 Recommend: add retry logic or increase timeout.
                 Want Engineering to fix the flaky test?
```

**Automated deploy pipeline (cron-driven):**

```bash
# Auto-deploy to staging every day at midnight (if tests pass)
clawdbot cron add \
  --name "nightly-staging-deploy" --agent devops \
  --cron "0 0 * * *" \
  --message "Check if there are new merged PRs on wanikua/myapp since last deploy. If yes: trigger the deploy-staging workflow, wait for completion, run smoke tests, and report results. If anything fails, notify Engineering and Chief of Staff." \
  --session isolated --token <your-token>
```

### Issue-to-PR Pipeline — Full Automation

The ultimate workflow: an issue comes in, gets triaged, fixed, reviewed, and deployed — all automatically:

```
┌──────────────────────────────────────────────────────────────┐
│  New Issue: #150 "API returns wrong timezone for UTC users"  │
└──────────────┬───────────────────────────────────────────────┘
               ▼
┌──────────────────────────────────────┐
│  Engineering (cron: hourly triage)   │
│  1. Labels: bug, priority-high, api │
│  2. Reads code, identifies the fix  │
│  3. Creates branch: fix/issue-150   │
│  4. Pushes code + tests             │
│  5. Opens PR #95 linked to #150     │
└──────────────┬───────────────────────┘
               ▼
┌──────────────────────────────────────┐
│  CI/CD (GitHub Actions)             │
│  • Tests: ✅ 143/143 passing        │
│  • Lint: ✅ clean                    │
│  • Coverage: 88% (+1%)              │
└──────────────┬───────────────────────┘
               ▼
┌──────────────────────────────────────┐
│  Engineering (self-review)          │
│  • Reviews own PR for quality       │
│  • Merges PR #95                    │
│  • Issue #150 auto-closed           │
└──────────────┬───────────────────────┘
               ▼
┌──────────────────────────────────────┐
│  DevOps (nightly deploy cron)       │
│  • Detects merged PR                │
│  • Deploys to staging               │
│  • Smoke tests pass                 │
│  • Reports to Discord               │
└──────────────────────────────────────┘

Zero human involvement. Issue → Fix → Deploy.
```

> ⚠️ **Safety note:** Fully automated merge-and-deploy is powerful but risky. For production systems, add a human review step: Engineering creates the PR and flags it for your review, then you approve and DevOps deploys. Start with staging-only automation and add production auto-deploy once you trust the pipeline.

### Repository Analytics

Your agents can provide insights into your development velocity:

```
You:             @Management give me the engineering metrics for this month

Management:      📊 Engineering Metrics — March 2026

                 ═══ Pull Requests ═══
                 • Opened: 23 | Merged: 19 | Closed: 2 | Open: 2
                 • Avg time to merge: 4.2 hours
                 • Largest PR: #87 (auth refactor, +420/-180 lines)

                 ═══ Issues ═══
                 • New: 31 | Closed: 27 | Open: 18
                 • Avg resolution time: 1.8 days
                 • Bugs: 12 | Features: 14 | Docs: 5
                 • Critical issues resolved: 3/3 (100%)

                 ═══ CI/CD ═══
                 • Total runs: 156 | Pass rate: 94.2%
                 • Flaky tests identified: 2 (both fixed)
                 • Avg build time: 2m 48s

                 ═══ Code Quality ═══
                 • Test coverage: 87% (+3% vs last month)
                 • Lint violations: 0 (clean)

                 → Full report archived to Notion: Project Archives
```

### GitHub + Notion Integration

Your GitHub activity flows into Notion automatically for long-term tracking:

```
# Engineering documents a PR in both GitHub and Notion
Engineering:     PR #95 merged. Updating records:

                 GitHub:
                 → Issue #150 closed (linked to PR #95)
                 → Milestone "v2.1" progress: 8/10 issues done

                 Notion:
                 → Daily Report: added "Fixed timezone bug (PR #95)"
                 → Engineering Wiki: updated API docs for timezone handling
                 → Project Archives: "v2.1 Milestone" — 80% complete
```

### GitHub Quick-Reference Card

| Step | What to Do |
|------|-----------|
| **1. Install gh CLI** | `sudo apt install gh` (or auto-installed by setup.sh) |
| **2. Authenticate** | `gh auth login` — follow the prompts |
| **3. Verify access** | `gh auth status` — check scopes |
| **4. Test from Discord** | `@Engineering list open issues on wanikua/myapp` |
| **5. Add cron jobs** | Issue triage (hourly), nightly staging deploy |
| **6. Connect to Notion** | Engineering logs PRs/issues to Engineering Wiki |

**Common `gh` commands your agents use:**

| Action | Command |
|--------|---------|
| List issues | `gh issue list --repo owner/repo` |
| Create issue | `gh issue create --title "..." --body "..."` |
| List PRs | `gh pr list --repo owner/repo` |
| Create PR | `gh pr create --title "..." --body "..."` |
| Review PR | `gh pr diff 42 --repo owner/repo` |
| Merge PR | `gh pr merge 42 --merge --repo owner/repo` |
| Check CI | `gh run list --repo owner/repo` |
| Re-run CI | `gh run rerun <run-id> --repo owner/repo` |
| View workflow | `gh run view <run-id> --repo owner/repo` |

> 💡 **Agents compose these commands automatically** — you just say "review PR #42" and Engineering translates that into the right `gh` commands, reads the diff, and provides feedback. No need to memorize the CLI.

### Branch Protection & Merge Policies

Your DevOps agent can enforce branch protection rules programmatically — no clicking through GitHub's UI:

```
You:             @DevOps set up branch protection on our main repos

DevOps:          Setting up branch protection rules:

                 wanikua/myapp (main):
                 ✅ Require PR reviews before merge (1 reviewer)
                 ✅ Require status checks to pass (ci.yml)
                 ✅ Require branches up-to-date before merge
                 ✅ Restrict direct pushes — only merge via PR
                 ✅ Require linear history (no merge commits)

                 wanikua/api-gateway (main):
                 ✅ Same rules applied

                 → All repos now require CI pass + PR review to merge.
                 → Nobody (including agents) can push directly to main.
```

**How agents interact with protected branches:**

```
# Engineering creates a branch, pushes code, opens a PR
Engineering:     Branch fix/issue-150 created.
                 → PR #95 opened against main
                 → CI running...

# Direct merge blocked — needs review
Engineering:     CI passed ✅ but branch protection requires review.
                 @DevOps — can you review and approve?

DevOps:          Reviewing PR #95...
                 Code looks good. Approved ✅
                 → Merged via squash merge.
```

**Configuring protection via the GitHub API:**

```bash
# DevOps can set this up using gh api
gh api repos/OWNER/REPO/branches/main/protection \
  --method PUT \
  --field required_status_checks='{"strict":true,"contexts":["ci"]}' \
  --field enforce_admins=true \
  --field required_pull_request_reviews='{"required_approving_review_count":1}'
```

> 💡 Add "Enforce branch protection rules on all new repos" to DevOps's `identity.theme` to make this automatic for every new repository.

### Release Automation

Manual releases are error-prone. Let your agents handle the full release lifecycle:

```
You:             @DevOps prepare a release for v2.1.0

DevOps:          Preparing release v2.1.0...

                 1. ✅ All CI checks passing on main
                 2. ✅ Changelog generated from merged PRs since v2.0.0:
                    • feat: JWT refresh tokens (#87)
                    • feat: rate limiting on /api/search (#90)
                    • fix: timezone handling for UTC users (#95)
                    • fix: connection pool sizing (#94)
                 3. ✅ Version bumped in package.json
                 4. ✅ Git tag v2.1.0 created
                 5. ✅ GitHub Release published with changelog

                 → Release: github.com/wanikua/myapp/releases/tag/v2.1.0
                 → npm package published (if configured)

                 Shall I deploy v2.1.0 to production?
```

**Automated release cron — tag on schedule:**

```bash
# Every Friday at 4 PM — create a release from the week's work
clawdbot cron add \
  --name "weekly-release" --agent devops \
  --cron "0 16 * * 5" --tz "America/New_York" \
  --message "Check if there are unreleased commits on wanikua/myapp since the last tag. If yes: bump the patch version, generate a changelog from merged PRs, create a GitHub release, and notify Engineering + Chief of Staff. If nothing new, skip." \
  --session isolated --token <your-token>
```

**Changelog generation pattern:**

```
# DevOps generates a changelog from PR titles
DevOps:          📋 Changelog for v2.1.0 (auto-generated):

                 ### ✨ Features
                 - JWT refresh token support (#87) — @Engineering
                 - API rate limiting (#90) — @Engineering

                 ### 🐛 Bug Fixes
                 - Timezone handling for UTC users (#95) — @Engineering
                 - Connection pool exhaustion (#94) — @Engineering

                 ### 📊 Stats
                 - 4 PRs merged | 6 issues closed | 892 lines changed
                 - 0 breaking changes

                 → Written to CHANGELOG.md and attached to GitHub Release
```

### Multi-Repo Management

Most companies run multiple repos. Your agents manage them all from one Discord server:

```
You:             @DevOps give me a health check on all our repos

DevOps:          📊 Repository Health Check:

                 wanikua/myapp
                 ├── Branch: main (protected ✅)
                 ├── CI: ✅ passing | Coverage: 87%
                 ├── Open PRs: 2 | Open Issues: 5
                 ├── Last release: v2.1.0 (3 days ago)
                 └── Dependencies: 0 critical vulnerabilities

                 wanikua/api-gateway
                 ├── Branch: main (protected ✅)
                 ├── CI: ⚠️ flaky (test_timeout — 3rd time this week)
                 ├── Open PRs: 1 | Open Issues: 3
                 ├── Last release: v1.4.2 (2 weeks ago)
                 └── Dependencies: 1 moderate vulnerability (lodash)

                 wanikua/landing-page
                 ├── Branch: main (unprotected ⚠️)
                 ├── CI: ✅ passing | Coverage: N/A
                 ├── Open PRs: 0 | Open Issues: 0
                 ├── Last release: none (static site)
                 └── Dependencies: 0 vulnerabilities

                 ⚠️ Action items:
                 1. api-gateway: fix flaky test (Engineering)
                 2. api-gateway: update lodash to fix vulnerability
                 3. landing-page: add branch protection rules
```

**Cross-repo dependency management:**

```
You:             @Engineering we need to update the shared auth library
                 across all repos

Engineering:     Updating shared-auth@2.0.0 across 3 repos:

                 1. wanikua/myapp
                    → Branch: chore/update-shared-auth
                    → Updated package.json + package-lock.json
                    → Tests passing ✅
                    → PR #97 created

                 2. wanikua/api-gateway
                    → Branch: chore/update-shared-auth
                    → Updated + ran migration script
                    → Tests passing ✅
                    → PR #45 created

                 3. wanikua/landing-page
                    → No dependency on shared-auth. Skipped.

                 All PRs are ready for review.
                 Want me to merge them after CI passes?
```

### GitHub Projects — Visual Task Tracking

Your agents can manage GitHub Projects (the built-in project board) for visual task tracking alongside code:

```
You:             @Management set up a project board for the v3 launch

Management:      Created GitHub Project: "v3 Launch Roadmap"
                 → github.com/orgs/wanikua/projects/4

                 Columns:
                 📋 Backlog | 🔄 In Progress | 👀 Review | ✅ Done

                 Populated from open issues:
                 • Backlog: 8 issues (features + enhancements)
                 • In Progress: 2 (auth refactor, rate limiting)
                 • Review: 1 (PR #91 awaiting review)
                 • Done: 12 (completed this sprint)

                 I'll keep this updated as issues move through the pipeline.
```

**Auto-update project board via cron:**

```bash
# Every 4 hours, Management syncs the project board
clawdbot cron add \
  --name "project-board-sync" --agent management \
  --cron "0 */4 * * *" \
  --message "Sync the v3 Launch Roadmap GitHub Project. Move issues to correct columns based on their status: unassigned→Backlog, assigned→In Progress, has open PR→Review, PR merged→Done. Report any blockers to Chief of Staff." \
  --session isolated --token <your-token>
```

**Connecting GitHub Projects to Notion:**

```
Management:      📊 Sprint Summary (synced from GitHub Project):

                 GitHub Project: v3 Launch Roadmap
                 ═══════════════════════════════════
                 Backlog:      8 issues (est. 24 story points)
                 In Progress:  2 issues (est. 8 story points)
                 Review:       1 issue  (est. 3 story points)
                 Done:         12 issues (35 story points completed)

                 Velocity: 35 points / 2 weeks = 17.5 pts/sprint
                 Forecast: at current velocity, remaining backlog
                           clears in ~2 sprints (4 weeks)

                 → Archived to Notion: Project Archives → "v3 Launch"
                 → Updated weekly report with sprint metrics
```

### GitHub Workflow Templates

For common CI/CD patterns, see [`references/github-workflows.md`](./become-ceo/references/github-workflows.md) — ready-to-use GitHub Actions workflow templates your DevOps agent can deploy to any repo:

| Template | What It Does |
|----------|-------------|
| **CI (Node.js)** | Install, lint, test, coverage report on every PR |
| **CI (Python)** | Install, pytest, type checking, coverage |
| **Deploy Staging** | Auto-deploy to staging when PR merges to main |
| **Deploy Production** | Manual approval + deploy to production |
| **Release Drafter** | Auto-generate changelog from PR labels |
| **Dependency Audit** | Weekly security scan of dependencies |
| **Stale Issue Cleanup** | Auto-close inactive issues after 30 days |
| **Secret & SAST Scanning** | Secret leak detection, dependency audit, license compliance |

```
You:             @DevOps set up CI for our new Python repo

DevOps:          Deploying CI workflow to wanikua/ml-service...

                 → Created .github/workflows/ci.yml
                   • Python 3.11 + pip install
                   • pytest with coverage (min 80%)
                   • mypy type checking
                   • Runs on: push to main, all PRs

                 → Created .github/workflows/deploy-staging.yml
                   • Auto-deploys on merge to main
                   • Runs tests first, then deploys

                 → Branch protection updated:
                   • Require ci.yml to pass before merge

                 CI pipeline is live. First run triggered now.
```

> 💡 **DevOps maintains your workflow templates.** When you ask "set up CI for repo X," DevOps picks the right template from `references/github-workflows.md`, customizes it for the repo's language/framework, and commits it. No manual YAML editing required.

### Security Scanning & Vulnerability Management

Your agents don't just write code — they **guard it**. Automated security scanning catches vulnerabilities before they reach production:

**Automated dependency auditing:**

```
You:             @DevOps run a security scan on all our repos

DevOps:          🔒 Security Scan Results:

                 wanikua/myapp
                 ├── npm audit: 0 critical, 1 moderate (lodash prototype pollution)
                 ├── Recommendation: npm update lodash (fix available)
                 └── License scan: all dependencies MIT/Apache — ✅ compliant

                 wanikua/api-gateway
                 ├── npm audit: 1 critical (jsonwebtoken <9.0.0 — CVE-2022-23529)
                 ├── Recommendation: URGENT — update jsonwebtoken to 9.0.2+
                 └── License scan: 1 GPL-3.0 dependency (review needed) ⚠️

                 wanikua/ml-service
                 ├── pip audit: 0 critical, 0 moderate
                 └── License scan: all dependencies permissive ✅

                 🚨 Action items:
                 1. CRITICAL: api-gateway jsonwebtoken update — creating PR now
                 2. MODERATE: myapp lodash update — scheduling for next sprint
                 3. REVIEW: api-gateway GPL dependency — flagging Legal

                 → Spawning Engineering: fix critical vulnerability
                 → Spawning Legal: review GPL-3.0 license compatibility
```

**Scheduled security scans (cron-driven):**

```bash
# Weekly Monday security audit across all repos
clawdbot cron add \
  --name "security-audit" --agent devops \
  --cron "0 8 * * 1" --tz "America/New_York" \
  --message "Run security audit on all repos: npm audit / pip audit, check for known CVEs, scan for exposed secrets in recent commits (git log --diff-filter=A). Report critical findings immediately to Chief of Staff. Log all results to the Incident Log on Notion tagged 'security-audit'." \
  --session isolated --token <your-token>
```

**Secret scanning — catch leaked credentials:**

```
DevOps (cron):   🚨 SECRET LEAK DETECTED

                 Repository: wanikua/myapp
                 Commit: abc1234 (3 hours ago)
                 File: src/config/database.js
                 Finding: Hardcoded database connection string detected

                 → Notified Engineering to rotate credentials
                 → Notified Chief of Staff
                 → Created INC-009 in Incident Log on Notion
                 → Recommendation: add pre-commit hook to prevent future leaks
```

> 💡 **Add secret scanning to your CI pipeline.** See [`references/github-workflows.md`](./become-ceo/references/github-workflows.md) for the Secret & SAST Scanning workflow template. DevOps can deploy it to any repo with one command.

### Conventional Commits & Semantic Versioning

Consistent commit messages make changelogs, release notes, and git history actually useful. Configure your Engineering agent to follow **Conventional Commits**:

```
# Commit message format:
#   <type>(<scope>): <description>
#
# Types: feat, fix, docs, style, refactor, perf, test, chore
# Breaking changes: add ! after type — feat!: remove legacy auth

# Examples from your Engineering agent:
feat(auth): add JWT refresh token support
fix(checkout): handle cart with 10+ items
docs(api): update rate limiting documentation
refactor(db): migrate from callbacks to async/await
perf(search): add database index for user queries
test(auth): add edge case tests for token expiry
chore(deps): update lodash to 4.17.21
feat!(api): remove deprecated v1 endpoints
```

**Why this matters:**

| Benefit | How |
|---------|-----|
| **Auto-generated changelogs** | Release Drafter groups commits by type (features, fixes, etc.) |
| **Semantic version bumps** | `feat` → minor bump, `fix` → patch, `feat!` → major bump |
| **Searchable history** | `git log --grep="fix(auth)"` finds all auth fixes instantly |
| **Cross-agent clarity** | When DevOps reads Engineering's commits, the intent is clear |

**Enforce in agent themes:**

```json
{
  "id": "engineering",
  "identity": {
    "theme": "...Follow Conventional Commits for all git operations (feat/fix/docs/refactor/perf/test/chore). Include scope when relevant. Mark breaking changes with !..."
  }
}
```

> 💡 Agents follow Conventional Commits automatically when instructed in their theme. No git hooks or tooling required — the LLM formats commit messages correctly based on the instruction.

### GitHub Discussions — Long-Form Decision Making

Not everything fits in a Discord message or a GitHub Issue. Use **GitHub Discussions** for architectural debates, RFCs, and decisions that need structured input from multiple agents:

```
You:             @Engineering we need to decide on our API versioning
                 strategy. Open a Discussion for it.

Engineering:     Created GitHub Discussion in wanikua/myapp:

                 📋 "RFC: API Versioning Strategy"
                 Category: Architecture Decisions

                 Options analyzed:
                 1. URL versioning (/v1/, /v2/) — simple, explicit
                 2. Header versioning (Accept: application/vnd.api+v2)
                 3. Query param (?version=2) — easy but messy

                 Recommendation: URL versioning for simplicity.
                 Trade-offs documented in the Discussion body.

                 @Finance @DevOps — your input on migration cost
                 and infrastructure impact?
```

**Discussions → Notion pipeline:**

```
# After a Discussion reaches consensus:
Engineering:     Discussion "API Versioning Strategy" resolved.
                 Decision: URL versioning (/v1/, /v2/).

                 → Created ADR-005 in Engineering Wiki on Notion
                 → Linked to GitHub Discussion #12
                 → Closed Discussion with summary comment
```

This creates a **decision trail**: the debate lives on GitHub (public, commentable), the decision lives on Notion (structured, searchable), and both cross-reference each other.

### GitHub Integration Summary

After three rounds of GitHub coverage, here's what your AI team can do with GitHub — all from Discord:

```
┌─────────────────────────────────────────────────────────────────┐
│                    GitHub Integration Map                        │
│                                                                 │
│  📋 Issues                    🔀 Pull Requests                  │
│  • Auto-triage (hourly cron)  • Create from Discord             │
│  • Label + prioritize         • Code review (security-focused)  │
│  • Create from conversations  • Auto-merge (with protection)    │
│  • Link to Notion projects    • Cross-agent coordination        │
│                                                                 │
│  🚀 CI/CD                     🔒 Security                       │
│  • Monitor build status       • Dependency audits (weekly)      │
│  • Re-run failed workflows    • Secret scanning                 │
│  • Nightly staging deploys    • License compliance              │
│  • Production with approval   • CVE response automation         │
│                                                                 │
│  📊 Analytics                  📦 Releases                      │
│  • PR merge times             • Semantic versioning             │
│  • Issue velocity             • Auto-changelog from PRs         │
│  • CI pass rates              • Weekly release cron             │
│  • Code coverage trends       • GitHub Release publishing       │
│                                                                 │
│  📁 Multi-Repo                 💬 Discussions                    │
│  • Health checks across repos • RFCs and architecture debates   │
│  • Cross-repo dependency sync • Decision → Notion ADR pipeline  │
│  • GitHub Projects boards     • Structured long-form input      │
│  • Sprint velocity tracking   • Cross-agent collaboration       │
└─────────────────────────────────────────────────────────────────┘
```

---

## Browser Automation — Your Eyes on the Web

Your AI team doesn't just read APIs — it can **see and interact with real websites**. Browser automation turns your agents into web power users: scraping data, filling forms, managing social media accounts, monitoring competitors, and navigating any web UI — all from Discord commands.

### Why Browser Automation?

Not everything has an API. Many critical business tasks require interacting with actual web pages:

- 📊 **Competitor monitoring** — check competitor pricing, features, and announcements
- 📱 **Social media management** — post to platforms, respond to DMs, scrape leads
- 📝 **Form filling** — submit applications, register for services, fill surveys
- 🔍 **Web scraping** — extract data from websites that don't offer APIs
- 📸 **Visual verification** — take screenshots to confirm deployments look correct
- 🛒 **E-commerce ops** — monitor product listings, check inventory, track orders

### How It Works

Clawdbot includes a built-in browser control layer that agents use to interact with web pages programmatically:

```
┌──────────────────────────────────────────────────────────────┐
│  You: @Marketing check our competitor's pricing page         │
└──────────────┬───────────────────────────────────────────────┘
               ▼
┌──────────────────────────────────────┐
│  Marketing Agent                     │
│                                      │
│  1. browser → open competitor URL    │
│  2. browser → snapshot (read DOM)    │
│  3. Extract pricing data from page   │
│  4. Compare with our pricing         │
│  5. Report findings to Discord       │
└──────────────────────────────────────┘
```

Under the hood, Clawdbot manages a headless Chromium instance. Agents interact with it through high-level actions: navigate, click, type, snapshot, screenshot — no Puppeteer or Selenium code required.

```
┌───────────────────────────────────────────────────────────┐
│                  Browser Automation Stack                  │
│                                                           │
│  Discord Command                                          │
│       ↓                                                   │
│  Agent (Marketing / Engineering / DevOps)                 │
│       ↓                                                   │
│  ┌─────────────────────────────────────────────────────┐  │
│  │  Browser Control Layer                              │  │
│  │                                                     │  │
│  │  • navigate(url)     — go to a URL                  │  │
│  │  • snapshot()        — read page content (DOM/aria) │  │
│  │  • screenshot()      — capture visual screenshot    │  │
│  │  • click(ref)        — click an element             │  │
│  │  • type(ref, text)   — type into input fields       │  │
│  │  • select(ref, val)  — choose from dropdowns        │  │
│  │  • evaluate(js)      — run custom JavaScript        │  │
│  │  • upload(ref, file) — upload files to forms        │  │
│  └─────────────────────────────────────────────────────┘  │
│       ↓                                                   │
│  Headless Chromium (managed by Clawdbot)                  │
│       ↓                                                   │
│  🌐 Any Website                                          │
└───────────────────────────────────────────────────────────┘
```

### Setting Up Browser Automation

Browser support is installed automatically by `setup.sh` (Chromium is included). No additional configuration needed — agents can start using the browser immediately.

If you're adding browser capabilities to an existing setup:

```bash
# Install Chromium (if not already present)
sudo apt install -y chromium-browser

# Verify it works
chromium-browser --headless --no-sandbox --dump-dom https://example.com
```

> 💡 **No API keys required** for browser automation. The browser runs locally on your server — you're just automating what a human would do in Chrome.

### Web Scraping — Extract Data from Any Site

Your agents can read and extract structured data from websites that don't offer APIs:

```
You:             @Engineering scrape the documentation structure from
                 docs.example.com and create a summary

Engineering:     Navigating to docs.example.com...

                 📄 Documentation Structure:
                 ├── Getting Started (4 pages)
                 │   ├── Installation
                 │   ├── Quick Start Guide
                 │   ├── Configuration
                 │   └── First Project
                 ├── API Reference (12 pages)
                 │   ├── Authentication
                 │   ├── Endpoints
                 │   └── ...
                 └── Tutorials (8 pages)

                 Total: 24 pages across 3 sections.
                 → Summary saved to Engineering Wiki on Notion.
```

**Scraping competitor pricing:**

```
You:             @Marketing compare our pricing with competitors X, Y, and Z

Marketing:       Checking pricing pages...

                 📊 Pricing Comparison:

                 | Feature        | Us    | Competitor X | Competitor Y | Competitor Z |
                 |----------------|-------|-------------|-------------|-------------|
                 | Free tier      | ✅ Yes | ✅ Yes      | ❌ No       | ✅ Yes      |
                 | Starter plan   | $9/mo | $12/mo      | $15/mo      | $10/mo      |
                 | Pro plan       | $29/mo| $39/mo      | $35/mo      | $49/mo      |
                 | API access     | ✅ All | ⚠️ Pro only | ✅ All      | ⚠️ Pro only |
                 | Custom domain  | ✅ Yes | ✅ Yes      | ❌ No       | ✅ Yes      |

                 💡 Our pricing is competitive on all tiers.
                    Gap: Competitor X offers SSO on Starter — we only offer it on Pro.

                 → Saved to Marketing Hub on Notion: "Competitive Analysis Q1"
```

### Social Media Management

Browser automation shines for social media — platforms where API access is limited or expensive:

```
You:             @Marketing post our product update to LinkedIn

Marketing:       Navigating to LinkedIn...

                 ✅ Posted to company page:
                 "🚀 Exciting update! Our v2.1 release includes JWT refresh
                 tokens, rate limiting, and faster API response times.
                 Read the full changelog: [link]"

                 → Post URL: linkedin.com/posts/...
                 → Logged to Marketing Hub on Notion
```

**Social media monitoring:**

```
You:             @Marketing check for any mentions of our brand this week

Marketing:       Scanning social platforms...

                 📱 Brand Mentions (past 7 days):

                 LinkedIn:
                 • 3 mentions — 2 positive (feature praise), 1 question (pricing)
                 • Top post: "[User] called our API docs 'best in class'" (142 likes)

                 Twitter/X:
                 • 5 mentions — 4 neutral, 1 support request
                 • Support request: "@ourcompany getting timeout errors" → flagging Engineering

                 Reddit:
                 • 1 thread in r/webdev comparing our tool to alternatives
                 • Sentiment: mostly positive, 12 upvotes

                 → Full report saved to Marketing Hub on Notion
                 → Flagged support request → Engineering for follow-up
```

**Lead scraping from professional networks:**

```
You:             @Marketing find potential partners in the AI tools space
                 on Product Hunt

Marketing:       Browsing Product Hunt...

                 🎯 Potential Partners (AI Tools — launched this month):

                 1. ToolAI — AI writing assistant (450 upvotes)
                    • Complementary to our product
                    • Founder: active on Product Hunt
                    • Integration opportunity: embed our API

                 2. DataPipe — ETL automation (320 upvotes)
                    • Potential data pipeline integration
                    • Already supports similar tools

                 3. DesignBot — AI design tool (280 upvotes)
                    • Marketing collaboration potential
                    • Large social following

                 → List saved to Marketing Hub on Notion: "Partner Prospects"
                 Want me to draft outreach messages?
```

### Screenshot Verification — Visual QA

After deployments, your agents can visually verify that everything looks right:

```
You:             @DevOps verify the production deployment looks correct

DevOps:          Taking screenshots of key pages...

                 📸 Visual Verification — production.example.com:

                 ✅ Homepage — renders correctly, hero banner visible
                 ✅ Login page — form elements present, no layout shift
                 ✅ Dashboard — charts loading, data populated
                 ⚠️ Pricing page — footer overlaps content on mobile viewport

                 Found 1 issue. Flagging Engineering for the pricing page
                 footer bug.

                 → Screenshots archived to #deployments channel
```

**Scheduled visual regression monitoring:**

```bash
# Daily at 6 AM — check production pages for visual regressions
clawdbot cron add \
  --name "visual-qa" --agent devops \
  --cron "0 6 * * *" \
  --message "Take screenshots of the top 5 pages on production (homepage, login, dashboard, pricing, docs). Compare against yesterday's screenshots. Flag any visual differences or broken layouts. Only alert if something looks wrong." \
  --session isolated --token <your-token>
```

### Form Automation & Data Entry

Agents can fill out web forms — useful for repetitive registration, application, or data entry tasks:

```
You:             @Engineering register our API on the three developer
                 directories I listed yesterday

Engineering:     Checking yesterday's conversation...
                 Found: DevDirectory, APIHub, and ToolsList.

                 Registering on each:
                 1. DevDirectory — navigating → filling form → submitted ✅
                    → Listing URL: devdirectory.com/tools/our-api
                 2. APIHub — navigating → filling form → submitted ✅
                    → Listing URL: apihub.io/listing/our-api
                 3. ToolsList — navigating → filling form → submitted ✅
                    → Pending review (manual approval)

                 All 3 directories submitted.
                 → Logged to Marketing Hub on Notion: "Directory Listings"
```

### Browser + Agent Cross-Collaboration

The real power comes when browser automation combines with your multi-agent team:

```
┌──────────────────────────────────────────────────────────────┐
│  You: @Chief of Staff do a full competitive analysis         │
└──────────────┬───────────────────────────────────────────────┘
               ▼
┌──────────────────────────────────────┐
│  Chief of Staff orchestrates:        │
│                                      │
│  spawn → Marketing                   │
│    "Browse competitor websites,      │
│     extract pricing and features"    │
│                                      │
│  spawn → Engineering                 │
│    "Check competitor GitHub repos,   │
│     analyze their tech stack and     │
│     release frequency"               │
│                                      │
│  spawn → Finance                     │
│    "Research competitor funding      │
│     rounds on Crunchbase"            │
└──────────────────────────────────────┘

Marketing:   [browser → competitor sites → extract pricing tables]
Engineering: [gh CLI → competitor repos → analyze stars, commits, stack]
Finance:     [browser → Crunchbase → extract funding data]

Chief of Staff:  📊 Competitive Analysis Complete:

                 Competitor A:
                 • Pricing: $15/mo starter, $49/mo pro
                 • Tech: React + Python, 2.3k GitHub stars
                 • Funding: Series A, $8M (2025)
                 • Release cadence: biweekly

                 Competitor B:
                 • Pricing: $12/mo flat
                 • Tech: Vue + Go, 890 GitHub stars
                 • Funding: Seed, $1.5M (2024)
                 • Release cadence: monthly

                 → Full report archived to Notion: Project Archives
```

Three agents used three different tools (browser, GitHub CLI, browser again) to produce a unified competitive analysis — from one command.

### Browser Security & Best Practices

Browser automation is powerful but requires care. Follow these guidelines:

| ✅ Do | ❌ Don't |
|-------|---------|
| Use browser for public web pages | Log into accounts with real credentials via bot |
| Scrape publicly available data | Violate website Terms of Service |
| Take screenshots for visual QA | Store passwords in agent themes or SOUL.md |
| Fill forms with provided data | Automate human-verification (CAPTCHA) bypasses |
| Monitor your own properties | Scrape at rates that could trigger IP bans |
| Use headless mode (default) | Leave browser sessions open indefinitely |

**Rate limiting best practices:**

```
# Add delays between page loads to avoid detection/blocking
# Clawdbot handles this automatically — but be mindful of:
# - Respect robots.txt when scraping
# - Add 2-3 second delays between rapid page navigations
# - Rotate user agents for large scraping jobs
# - Cache results to avoid repeated fetches
```

**Credential management:**

If your agents need to interact with authenticated web pages, use environment variables — never hardcode credentials in agent themes or workspace files:

```json
{
  "sandbox": {
    "docker": {
      "env": {
        "LINKEDIN_SESSION": "$SESSION_COOKIE",
        "TWITTER_AUTH": "$AUTH_TOKEN"
      }
    }
  }
}
```

> ⚠️ **Important:** Browser automation for social media should follow platform guidelines. Use official APIs where available (Twitter API, LinkedIn API) and fall back to browser automation only for actions not covered by APIs. Always respect rate limits and Terms of Service.

### Browser Quick-Reference Card

| Step | What to Do |
|------|-----------|
| **1. Verify Chromium** | `chromium-browser --version` (auto-installed by setup.sh) |
| **2. Test from Discord** | `@Engineering take a screenshot of example.com` |
| **3. Common actions** | Navigate, snapshot, screenshot, click, type, select |
| **4. Social media** | Use Marketing agent for posting, monitoring, lead gen |
| **5. Visual QA** | Use DevOps agent for deployment verification screenshots |
| **6. Competitive intel** | Use Marketing + Engineering for cross-agent analysis |

**Common browser actions your agents use:**

| Action | What It Does | Example |
|--------|-------------|---------|
| `navigate(url)` | Go to a web page | Open competitor's pricing page |
| `snapshot()` | Read page content as structured text | Extract article text, table data |
| `screenshot()` | Capture a visual image of the page | Visual QA after deployment |
| `click(ref)` | Click a button or link | Navigate multi-page sites |
| `type(ref, text)` | Type into an input field | Fill search boxes, forms |
| `select(ref, value)` | Choose from a dropdown menu | Select country, plan tier |
| `evaluate(js)` | Run custom JavaScript on the page | Extract complex data structures |
| `upload(ref, file)` | Upload a file to a form | Submit documents, images |

> 💡 **Agents compose browser actions automatically** — you just say "check our homepage on mobile" and the agent translates that into: set viewport to 375px, navigate, screenshot. No need to learn the browser control API yourself.

### Multi-Step Browser Workflows

Real-world browser tasks rarely consist of a single page visit. Your agents handle complex, multi-step workflows with state carried across pages:

```
You:             @Marketing log into our analytics dashboard, export last
                 week's traffic report, and compare with the previous week

Marketing:       Starting multi-step browser workflow...

                 Step 1/4 — Navigating to analytics.example.com
                 Step 2/4 — Logging in (using stored credentials)
                 Step 3/4 — Setting date range: Feb 24 – Mar 2
                 Step 4/4 — Extracting report data

                 📊 Weekly Traffic Comparison:

                 | Metric          | This Week | Last Week | Change  |
                 |-----------------|-----------|-----------|---------|
                 | Visitors        | 12,340    | 11,890    | +3.8%   |
                 | Page views      | 45,200    | 42,100    | +7.4%   |
                 | Bounce rate     | 34%       | 38%       | -4% ✅  |
                 | Avg session     | 3m 12s    | 2m 48s    | +14% ✅ |
                 | Top source      | Organic   | Organic   | —       |

                 📈 Traffic trending up across all key metrics.
                 → Report saved to Marketing Hub on Notion
```

**Multi-step workflow anatomy:**

```
┌─────────────────────────────────────────────────────────────┐
│  Multi-Step Browser Workflow                                │
│                                                             │
│  1. navigate(url)              — open target site           │
│  2. snapshot() → find login    — locate the login form      │
│  3. type(email) + type(pass)   — fill credentials           │
│  4. click(submit)              — authenticate               │
│  5. snapshot() → verify login  — confirm we're logged in    │
│  6. navigate(dashboard)        — go to target page          │
│  7. snapshot() → extract data  — read the information       │
│  8. Return structured results  — format and report          │
│                                                             │
│  State is maintained across all steps — cookies, session,   │
│  and page context persist within a single browser session.  │
└─────────────────────────────────────────────────────────────┘
```

> 💡 **State persistence:** Within a workflow, the browser maintains cookies, local storage, and session tokens automatically. An agent can log in once and navigate multiple pages without re-authenticating.

### Browser Profiles — Isolating Sessions

Different tasks may need different browser contexts. Clawdbot supports browser profiles to isolate sessions:

```
┌─────────────────────────────────────────────────────────────┐
│  Browser Profiles                                           │
│                                                             │
│  profile="clawd" (default)                                  │
│  └── Isolated, headless Chromium managed by Clawdbot        │
│  └── Clean session each time — no leftover cookies          │
│  └── Best for: scraping, screenshots, form filling          │
│                                                             │
│  profile="chrome"                                           │
│  └── Connects to your existing Chrome via browser relay     │
│  └── Uses your logged-in sessions and extensions            │
│  └── Best for: accessing authenticated dashboards,          │
│       managing accounts you're already signed into          │
└─────────────────────────────────────────────────────────────┘
```

**When to use each profile:**

| Profile | Use Case | Persistence | Auth |
|---------|---------|-------------|------|
| `clawd` | Scraping, visual QA, public sites | Fresh each time | None (clean) |
| `chrome` | Authenticated dashboards, admin panels | Uses your sessions | Your cookies |

**Example — using Chrome profile for authenticated access:**

```
You:             @Marketing check our Google Ads performance
                 (I'm already logged in on Chrome)

Marketing:       Connecting via Chrome relay...
                 Using your authenticated Google Ads session.

                 📊 Google Ads — Last 7 Days:
                 • Impressions: 23,400
                 • Clicks: 1,240 (CTR: 5.3%)
                 • Spend: $187.40
                 • Conversions: 34
                 • Cost per conversion: $5.51

                 → Logged to Financial Records on Notion
```

### Error Recovery & Retry Patterns

Web pages are unpredictable — they time out, change layout, show CAPTCHAs, or require JavaScript. Your agents handle these gracefully:

```
┌─────────────────────────────────────────────────────────────┐
│  Browser Error Recovery                                     │
│                                                             │
│  Error Type           │ Agent Response                      │
│  ─────────────────────┼───────────────────────────────────  │
│  Page timeout          │ Retry with longer timeout (2×)     │
│  Element not found     │ Re-snapshot, try alternate selector │
│  CAPTCHA detected      │ Notify human, skip task             │
│  Login required        │ Use stored credentials or ask human │
│  Rate limited (429)    │ Back off, retry after delay         │
│  SSL / network error   │ Report failure, try alternative URL │
│  Unexpected modal      │ Dismiss and continue                │
│  Page layout changed   │ Re-snapshot, adapt dynamically      │
└─────────────────────────────────────────────────────────────┘
```

**Error recovery in action:**

```
You:             @DevOps check the status page for our CDN provider

DevOps:          Navigating to cdn-provider.com/status...

                 ⚠️ Page took 12s to load (slow response).
                 Retrying with extended timeout...

                 ✅ Loaded on second attempt.

                 CDN Status — All Regions:
                 • US-East: ✅ Operational
                 • US-West: ✅ Operational
                 • EU-West: ⚠️ Degraded (latency +40ms)
                 • AP-South: ✅ Operational

                 EU-West shows degradation. Want me to set up
                 a monitoring cron to check every 30 minutes?
```

**CAPTCHA handling (the honest approach):**

```
You:             @Engineering submit our tool to that review directory

Engineering:     Navigating to directory.example.com/submit...

                 ⛔ CAPTCHA detected on submission form.
                 I can't solve CAPTCHAs — that's a human thing.

                 I've filled out all other fields:
                 • Tool name: ✅
                 • Description: ✅
                 • Category: ✅
                 • URL: ✅

                 → Please solve the CAPTCHA manually, then tell me
                   to click Submit.
```

### Page Interaction Strategies

Agents use smart strategies to interact with complex web pages:

**Aria refs (accessible references):**
```
# Agents read the page using aria snapshots — like screen readers
# Elements are referenced by accessible roles and labels
# This is more resilient than CSS selectors (survives redesigns)

snapshot → finds: [button "Sign In"] [textbox "Email"] [link "Pricing"]
click("Sign In")    — clicks by aria label
type("Email", "…")  — types into named field
```

**Handling dynamic content:**
```
# For pages that load content with JavaScript:
# 1. Navigate to the page
# 2. Wait for key elements to appear (agent checks snapshot)
# 3. If content not loaded, agent retries with delay
# 4. Extract once content is confirmed present

# For infinite scroll pages:
# 1. Scroll to bottom using evaluate(js)
# 2. Wait for new content to load
# 3. Repeat until desired data collected or limit reached
```

**Responsive testing — multiple viewports:**
```
You:             @DevOps test our homepage on mobile, tablet, and desktop

DevOps:          Running responsive checks...

                 📱 Mobile (375×812):
                 ✅ Navigation hamburger menu works
                 ✅ Hero text readable, no overflow
                 ⚠️ CTA button partially hidden below fold

                 📱 Tablet (768×1024):
                 ✅ Two-column layout renders correctly
                 ✅ Images properly scaled

                 🖥️ Desktop (1440×900):
                 ✅ Full navigation bar visible
                 ✅ Three-column feature grid aligned
                 ✅ Footer links all visible

                 1 issue found → CTA position on mobile.
                 → Screenshot comparison saved to #design-review
```

### Browser Automation Recipes

For ready-to-use browser workflow templates covering common scenarios (SEO audits, price monitoring, content publishing, report extraction), see [`references/browser-recipes.md`](become-ceo/references/browser-recipes.md).

Available recipes:
- 🔍 **SEO Audit** — check meta tags, headings, broken links, page speed
- 💰 **Price Monitoring** — track competitor prices with change alerts
- 📝 **Content Publishing Pipeline** — draft → review → publish across platforms
- 📊 **Report Extraction** — extract data from dashboards to Notion
- 🔄 **Multi-Site Health Check** — batch-check status pages and uptime
- 📱 **Social Media Scheduler** — queue and publish posts at optimal times

---

## Architecture

```
Discord message
    ↓
Clawdbot Gateway (Node.js daemon)
    ├── Message routing: @mention → match binding → dispatch to agent
    ├── Session isolation: each agent has independent sessions + workspace
    ├── Auto-threading: big tasks spawn threads, channels stay clean
    └── Cron scheduler: agents execute tasks on a timer
         ↓
    ┌───────────┐  ┌───────────┐  ┌───────────┐
    │ ⚔️ Eng    │  │ 💰 Finance│  │ 🎭 Mktg   │  ... (extensible)
    │ Strong LLM│  │ Strong LLM│  │ Fast LLM  │
    │ Code, arch│  │ Costs, ops│  │ Content   │
    └─────┬─────┘  └─────┬─────┘  └─────┬─────┘
          │              │              │
    ┌─────┴──────────────┴──────────────┴─────┐
    │          Skill Layer (60+)               │
    │  GitHub · Notion · Browser · Cron · TTS  │
    │  Weather · Screenshots · Video · Shell … │
    └──────────────────────────────────────────┘
```

Each agent is an **independent Discord bot** bound to an independent AI identity:

- **Independent memory** — each agent has its own `memory/` directory, getting smarter over time
- **Independent model** — heavy work uses strong models, light work uses fast models (save 5×)
- **Independent sandbox** — agents run in isolation, code execution can't interfere
- **Identity injection** — Clawdbot auto-assembles SOUL.md + IDENTITY.md + workspace files into the system prompt

---

## Your Team

| Role | Agent ID | Emoji | What They Do | Model Tier |
|------|----------|-------|--------------|------------|
| **Chief of Staff** | `main` | ⚡ | Routes tasks, daily standups, delegation | Fast |
| **Engineering** | `engineering` | ⚔️ | Code, architecture, code review, debugging | Strong |
| **Finance** | `finance` | 💰 | Budgets, cost analysis, spend tracking | Strong |
| **Marketing** | `marketing` | 🎭 | Content creation, branding, social media | Fast |
| **DevOps** | `devops` | 🔧 | Servers, CI/CD, deployments, infrastructure | Fast |
| **Management** | `management` | 👔 | Project coordination, hiring, team ops | Fast |
| **Legal** | `legal` | ⚖️ | Compliance, contracts, IP, risk assessment | Fast |

> 💡 **Model tiering strategy:** Heavy lifting (code, analysis) → strong model. Light work (content, coordination) → fast model. This saves ~5× on costs. You can also mix in budget models for further savings.

---

## Core Capabilities

### 🤖 Multi-Agent Collaboration
Each role is its own Discord bot. `@Engineering` and Engineering answers. `@everyone` and the whole team responds. Large tasks automatically spawn Discord threads to keep your channels clean.

> ⚠️ Want bots to trigger each other (e.g., chain-of-thought discussions, multi-bot brainstorms)? Add `"allowBots": true` in `clawdbot.json` under `channels.discord`. Without it, bots ignore other bots by default. Also set `"groupPolicy": "open"` on each account — otherwise group messages get silently dropped.

### 🧠 Independent Memory
Each agent has its own workspace and `memory/` directory. Project knowledge from conversations persists to files and survives across sessions. Your Engineering agent remembers your codebase conventions. Your Finance agent remembers last month's budget. They get smarter over time.

### 🛠️ 60+ Built-in Skills
These aren't chatbots — they have real tools:

| Category | Skills |
|----------|--------|
| **Development** | GitHub (Issues/PRs/CI), Coding Agent (autonomous coding) |
| **Documents** | Notion (databases, pages, automated reports) |
| **Research** | Browser automation, web search, web scraping |
| **Automation** | Cron scheduled tasks, heartbeat self-checks |
| **Media** | TTS voice, screenshots, video frame extraction |
| **Operations** | tmux remote control, shell command execution |
| **Messaging** | Discord, Slack, Telegram, WhatsApp, Signal… |

### ⏰ Cron Scheduling
Built-in scheduler lets agents run tasks autonomously:
- Daily standup reports → Discord + Notion
- Weekly summaries with cost breakdowns
- Health checks and code backups
- Any custom scheduled task you can describe in plain English

### 👥 Team Collaboration
Invite teammates or co-founders to your Discord server. Everyone can `@` any agent. Conversations are isolated per user — results are visible to all. Your CTO can ask Engineering to review code while your CFO asks Finance for a spend report, simultaneously.

### 🔒 Sandbox Isolation
Agents can run inside Docker containers with configurable isolation levels:
- **Read-only filesystem** — agents can't modify the host
- **Network isolation** — agents can't reach the internet (or you can allow it)
- **Environment isolation** — API keys are injected explicitly, not inherited from the host

```json
"sandbox": {
  "mode": "all",
  "workspaceAccess": "rw",
  "docker": { "network": "bridge", "env": { "LLM_API_KEY": "your-key" } }
}
```

---

## Prerequisites

Before you start, you'll need:

| Requirement | Details |
|-------------|---------|
| **Server** | Ubuntu 22.04 or 24.04 (ARM or x86). See below for free options. |
| **LLM API Key** | From any OpenAI-compatible provider (Anthropic, OpenAI, Google, Mistral, etc.) |
| **Discord Bots** | 7 bot tokens from [discord.com/developers](https://discord.com/developers/applications) |
| **Discord Server** | Your own server where you can invite bots |

### Free server options

| Provider | Specs | Notes |
|----------|-------|-------|
| **Oracle Cloud** | 4 ARM cores, 24GB RAM | Always-free tier, best specs |
| **Google Cloud** | 1 vCPU, 1GB RAM (e2-micro) | Always-free, tight on RAM |
| **AWS** | 1 vCPU, 1GB RAM (t2.micro) | Free for 12 months |

> 💡 **Oracle Cloud's free ARM instance** is the sweet spot — 24GB RAM means you can run all 7 agents comfortably with room to spare.

---

## Quick Start

### Step 1: One-Click Deploy (~5 min)

SSH into your Ubuntu server and run:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/wanikua/become-ceo/main/setup.sh)
```

The script automatically handles:
- ✅ System update + cloud firewall config
- ✅ 4GB swap (prevents OOM on free tier)
- ✅ Node.js 22 + GitHub CLI + Chromium
- ✅ Clawdbot global install
- ✅ Workspace initialization (SOUL.md / IDENTITY.md / USER.md / clawdbot.json template)
- ✅ Gateway systemd service (auto-starts on boot)

> **Already have Clawdbot?** Install just the skill:
> ```bash
> clawdhub install become-ceo
> ```

### Step 2: Fill In Your Keys (~10 min)

You need two things:

1. **LLM API Key** — from your LLM provider's dashboard
2. **Discord Bot Tokens** — one per team member (7 total) from [discord.com/developers](https://discord.com/developers/applications)

```bash
# Edit config — fill in API keys and bot tokens
nano ~/.clawdbot/clawdbot.json

# Start your team
systemctl --user start clawdbot-gateway

# Verify it's running
systemctl --user status clawdbot-gateway
```

> ⚠️ **Discord bot setup:** For each of the 7 bots, go to the Discord Developer Portal → Bot → enable **Message Content Intent** and **Server Members Intent**. Then invite each bot to your server with the bot + applications.commands scope.

### Step 3: Test It

In Discord, `@mention` any of your bots:

```
@Chief of Staff  what can you do?
@Engineering     write me a hello world API in Node.js
@Finance         what's the cheapest LLM provider right now?
```

If you get a response, you're live. 🎉

---

## What It Looks Like

### Solo tasking
```
You:           @Engineering refactor the auth module to use refresh tokens
Engineering:   [opens thread] Working on it. Here's the plan:
               1. Add refresh_token table...
               2. Modify /login endpoint...
               [commits code to GitHub]
```

### Cross-team collaboration
```
You:           @Chief of Staff I need a launch plan for next Tuesday
Chief of Staff: I'll coordinate. Delegating:
               → @Engineering: feature freeze + final QA
               → @Marketing: launch copy + social posts
               → @DevOps: staging → production deploy checklist
```

### Daily standup (automated via cron)
```
Chief of Staff: 📋 Daily Standup — here's what happened today:
               • Engineering: merged 3 PRs, resolved auth bug
               • Finance: API costs at $12.40/day, within budget
               • Marketing: published 2 blog posts, drafted newsletter
               • DevOps: SSL cert renewed, monitoring alert resolved
```

### Inter-agent delegation (Chief of Staff routes automatically)
```
You:           @Chief of Staff We need to launch a blog. Handle it.
Chief of Staff: Coordinating. Here's the plan:

               → Spawning Engineering: set up a static site with Next.js,
                 push to GitHub, configure CI/CD
               → Spawning Marketing: draft 3 launch blog posts with SEO keywords
               → Spawning DevOps: configure Vercel deployment from the new repo

               I'll follow up when each team reports back.

[10 minutes later]

Chief of Staff: ✅ All tasks complete:
               • Engineering: repo `company-blog` created, Next.js + MDX,
                 CI passing — github.com/you/company-blog
               • Marketing: 3 drafts ready in /content/posts/
               • DevOps: live at blog.yourcompany.com (Vercel auto-deploy on push)
```

### Setting up automated reports
```bash
# Get your gateway token
clawdbot gateway token

# Daily report at 10 PM
clawdbot cron add \
  --name "daily-report" --agent main \
  --cron "0 22 * * *" --tz "America/New_York" \
  --message "Generate today's standup report and post it to Discord" \
  --session isolated --token <your-token>
```

### Weekly cost review (automated via cron)
```bash
# Every Monday at 9 AM — Finance reviews API spend
clawdbot cron add \
  --name "weekly-cost-review" --agent finance \
  --cron "0 9 * * 1" --tz "America/New_York" \
  --message "Review this week's API costs. Compare to last week. Flag any anomalies. Post summary to Discord." \
  --session isolated --token <your-token>
```

---

## Config Deep-Dive

Your entire team is defined in `~/.clawdbot/clawdbot.json`. Here's how it's structured:

### Models — Define your LLM providers

```json
"models": {
  "providers": {
    "$LLM_PROVIDER": {
      "baseUrl": "$LLM_BASE_URL",
      "apiKey": "$LLM_API_KEY",
      "models": [
        { "id": "$MODEL_FAST", "name": "Fast Model" },
        { "id": "$MODEL_STRONG", "name": "Strong Model" }
      ]
    }
  }
}
```

Mix providers freely — one agent on Provider A, another on Provider B, another on a local Ollama instance. Any OpenAI-compatible API works.

### Agents — Define your team

```json
"agents": {
  "list": [
    {
      "id": "engineering",
      "model": { "primary": "$LLM_PROVIDER/$MODEL_STRONG" },
      "identity": {
        "name": "Engineering",
        "theme": "You are the Engineering lead. Direct, working solutions, not lectures.",
        "emoji": "⚔️"
      }
    }
  ]
}
```

Each agent gets: an ID, a model, a personality (`theme`), and optionally subagent permissions to delegate to others.

### Channels — Wire up Discord

```json
"channels": {
  "discord": {
    "enabled": true,
    "groupPolicy": "open",
    "accounts": {
      "engineering": {
        "name": "Engineering",
        "token": "$DISCORD_BOT_TOKEN_ENGINEERING",
        "groupPolicy": "open"
      }
    }
  }
}
```

### Bindings — Connect agents to accounts

```json
"bindings": [
  { "agentId": "engineering", "match": { "channel": "discord", "accountId": "engineering" } }
]
```

When someone `@Engineering` on Discord → the `engineering` Discord account receives the message → binding routes it to the `engineering` agent → agent processes and responds.

### ⚠️ The `groupPolicy` Gotcha

This is the #1 thing people miss. The top-level `groupPolicy: "open"` does **not** cascade to individual accounts. You must set it on **each account individually**:

```json
"accounts": {
  "main":        { "token": "...", "groupPolicy": "open" },
  "engineering": { "token": "...", "groupPolicy": "open" },
  "finance":     { "token": "...", "groupPolicy": "open" }
}
```

Without this, group messages (including `@everyone`) will be silently dropped. Every single person hits this.

> 📄 Full template: [`become-ceo/references/clawdbot-template.json`](./become-ceo/references/clawdbot-template.json)

---

## Growing Your Team

Want to add a new specialist? Three steps:

**1. Add the agent:**
```json
{
  "id": "data",
  "model": { "primary": "$LLM_PROVIDER/$MODEL_FAST" },
  "identity": {
    "name": "Data Science",
    "theme": "You are the Data Science lead. Statistical rigor, clear visualizations, actionable insights.",
    "emoji": "📊"
  }
}
```

**2. Add a Discord account:**
Create a new bot at [discord.com/developers](https://discord.com/developers/applications), then add to your config:
```json
"data": { "name": "Data Science", "token": "YOUR_NEW_BOT_TOKEN", "groupPolicy": "open" }
```

**3. Add a binding:**
```json
{ "agentId": "data", "match": { "channel": "discord", "accountId": "data" } }
```

Restart the gateway (`systemctl --user restart clawdbot-gateway`) and your new team member is live.

> 💡 **Want bots to talk to each other?** (e.g., Engineering delegates to DevOps) Add `"allowBots": true` to your `channels.discord` config. Without it, bots ignore messages from other bots.

---

## Built-In Skills (60+)

Your agents aren't just chatbots — they have tools:

| Category | Skills |
|----------|--------|
| **Development** | GitHub (Issues, PRs, CI), Coding Agent (autonomous coding) |
| **Documentation** | Notion (databases, pages, automated reports) |
| **Research** | Browser automation, web search, web scraping |
| **Automation** | Cron scheduled tasks, heartbeat self-checks |
| **Media** | TTS voice, screenshots, video frame extraction |
| **Ops** | tmux remote control, shell command execution |
| **Comms** | Discord, Slack, Telegram, WhatsApp, Signal… |

---

## FAQ

### Basics

**Q: Do I need to know how to code?**
No. The one-click script handles installation. The config file just needs a few keys filled in. All interaction is natural language on Discord.

**Q: Is the server really free?**
Many cloud providers offer always-free VMs — for example, ARM instances with 4 cores and 24GB RAM. Check your provider's free tier details and usage limits.

**Q: How is this different from just using ChatGPT?**
ChatGPT is a single generalist that forgets everything when you close the tab. This system is a team of specialists — each agent has its own expertise, persistent memory, and tool access. They can push code to GitHub, write docs to Notion, and run tasks on a schedule while you sleep.

**Q: Can I use other models?**
Yes. Clawdbot supports any provider with an OpenAI-compatible API — Anthropic, OpenAI, Google, Mistral, local Ollama, and more. Set the `model` field per agent in `clawdbot.json`. Different roles can use different providers.

**Q: How much does the API cost per month?**
Depends on usage intensity. Light use: $10–15/month. Moderate: $20–30/month. Cost tip: use Strong Model only for heavy work (Engineering, Finance), Fast Model for everything else (~5× cheaper). You can also add a Budget Model tier for trivial tasks.

### Technical

**Q: `@everyone` doesn't trigger any agents?**
In the Discord Developer Portal, each bot needs **Message Content Intent** and **Server Members Intent** enabled. The bot's role in the server needs **View Channels** permission. Clawdbot treats `@everyone` as an explicit mention for every bot.

**Q: Messages silently disappear?**
`groupPolicy: "open"` must be set on **each individual account** in the config. The global setting does NOT cascade. [See the config section above.](#%EF%B8%8F-the-grouppolicy-gotcha) This is the #1 gotcha — everyone hits it.

**Q: Multiple people `@` the same agent — do they conflict?**
No. Clawdbot maintains separate sessions for each user × agent combination. Multiple people can talk to Engineering simultaneously without interference.

**Q: Can agents call each other?**
Yes. Agents can use `sessions_spawn` to create sub-tasks for other agents, or `sessions_send` to message another agent's session. For example, Chief of Staff can delegate a coding task to Engineering programmatically. See the [Multi-Agent Collaboration Deep-Dive](#multi-agent-collaboration-deep-dive) section for detailed examples, permission configuration, and best practices.

**Q: Sandbox mode — agent says "permission denied"?**
`sandbox.mode: "all"` runs agents in Docker containers with a read-only filesystem and no network by default. Fix it with:

```json
"sandbox": {
  "mode": "all",
  "workspaceAccess": "rw",
  "docker": {
    "network": "bridge",
    "env": { "LLM_API_KEY": "your-key-here" }
  }
}
```

- `workspaceAccess: "rw"` — lets the sandbox read/write the workspace
- `docker.network: "bridge"` — allows network access
- `docker.env` — pass in API keys (sandbox doesn't inherit host env vars)

**Q: How do I connect Notion?**
Create an integration at [notion.so/my-integrations](https://www.notion.so/my-integrations), copy the token, share your pages with the integration, and store the token in your workspace. Clawdbot's built-in Notion skill handles all API calls — agents create pages, query databases, and update records via natural language. See the [Notion Integration](#notion-integration--your-companys-knowledge-base) section for setup details and workflow examples.

**Q: How does GitHub integration work?**
Your agents use the `gh` CLI (GitHub CLI) to interact with repositories. Authenticate once on your server with `gh auth login`, and all agents can create issues, manage PRs, review code, and trigger CI/CD workflows. Engineering handles most GitHub operations, but any agent can read repo data. See the [GitHub Integration](#github-integration--your-engineering-pipeline) section for setup and workflow examples.

**Q: How do I set up automated security scanning?**
DevOps can deploy the Secret & SAST Scanning workflow template to any repo from `references/github-workflows.md`. It runs on every PR and weekly on a schedule — catching leaked secrets, vulnerable dependencies, and license conflicts automatically. DevOps notifies Engineering for code fixes and Legal for license issues. See the [Security Scanning](#security-scanning--vulnerability-management) section for details.

**Q: How does browser automation work?**
Your agents control a headless Chromium instance managed by Clawdbot. They can navigate to any URL, read page content, take screenshots, click buttons, fill forms, and extract data — all through natural language commands. Chromium is installed automatically by `setup.sh`. No additional API keys or browser drivers needed. See the [Browser Automation](#browser-automation--your-eyes-on-the-web) section for setup and examples.

**Q: How do I create custom skills?**
Clawdbot has a built-in Skill Creator. Each skill is a directory with `SKILL.md` (instructions) + scripts + assets. Drop it in your workspace's `skills/` directory and agents use it automatically.

**Q: Can I use local models (Ollama, etc.)?**
Yes. Add an OpenAI-compatible provider in `clawdbot.json` under `models.providers` and point `baseUrl` to your Ollama endpoint. Local models = zero API costs.

**Q: Gateway won't start — how do I debug?**
```bash
# Check logs
journalctl --user -u clawdbot-gateway --since today --no-pager

# Run diagnostics
clawdbot doctor

# Common causes: missing API key, invalid JSON syntax, bad bot token
```

---

## Troubleshooting

Quick fixes for the most common first-run issues:

### Gateway won't start
```bash
# Check the logs first
journalctl --user -u clawdbot-gateway --since today --no-pager -n 50

# Run diagnostics
clawdbot doctor
```

**Common causes:**
- Invalid JSON in `clawdbot.json` — run `cat ~/.clawdbot/clawdbot.json | python3 -m json.tool` to find syntax errors
- Missing or invalid API key — double-check your LLM provider dashboard
- Bad bot token — regenerate in Discord Developer Portal

### Bot is online but doesn't respond
1. **Check intents:** Discord Developer Portal → Bot → enable "Message Content Intent" + "Server Members Intent"
2. **Check permissions:** Bot role needs "View Channels", "Send Messages", "Read Message History"
3. **Check `groupPolicy`:** Must be `"open"` on **each individual account**, not just the top level
4. **Check `requireMention`:** If `true`, the bot only responds to `@mentions`, not plain text

### Agent responds but seems confused
- Check the workspace has `SOUL.md`, `IDENTITY.md`, `USER.md` — missing files mean missing context
- Verify `identity.theme` in `clawdbot.json` gives clear role instructions
- Make sure the correct model is set — complex tasks need a Strong Model, not a Fast Model

### High API costs
- Audit which agents use Strong Model vs Fast Model — only Engineering and Finance typically need strong
- Add a Budget Model tier for trivial tasks (greetings, acknowledgements)
- Reduce `historyLimit` in Discord config to send fewer past messages as context
- Use `clawdbot cron` for scheduled tasks instead of keeping sessions alive

---

## What's In The Box

```
become-ceo/
├── setup.sh                              # One-click server setup script
├── become-ceo/
│   ├── SKILL.md                          # Skill definition (ClawdHub package)
│   └── references/
│       ├── clawdbot-template.json        # Full 7-agent config, ready to customize
│       ├── SOUL.md                       # Team behavioral norms
│       ├── IDENTITY.md                   # Org chart and role definitions
│       ├── USER.md                       # About you, the CEO
│       ├── AGENTS.md                     # Group chat + memory rules
│       ├── notion-templates.md           # Ready-to-use Notion database schemas
│       ├── github-workflows.md           # Ready-to-use GitHub Actions templates
│       └── browser-recipes.md            # Ready-to-use browser automation recipes
├── README.md                             # You are here
├── README_CN.md                          # 中文说明
└── LICENSE                               # MIT
```

---

## Community & Links

| Resource | Link |
|----------|------|
| 📖 **Clawdbot Docs** | [docs.clawd.bot](https://docs.clawd.bot) |
| 💻 **Clawdbot GitHub** | [github.com/clawdbot/clawdbot](https://github.com/clawdbot/clawdbot) |
| 🇨🇳 **Chinese Version** — AI Court (Dynasty Theme) | [wanikua/boluobobo-ai-court-tutorial](https://github.com/wanikua/boluobobo-ai-court-tutorial) |
| 🇨🇳 **Chinese Skill Package** | [wanikua/ai-court-skill](https://github.com/wanikua/ai-court-skill) |
| 📦 **ClawdHub Install** | `clawdhub install become-ceo` |

> This project is the English adaptation of [boluobobo-ai-court-tutorial](https://github.com/wanikua/boluobobo-ai-court-tutorial) — the original implementation of role-based multi-agent AI collaboration (first commit 2026-02-22). The Chinese version uses an ancient dynasty metaphor; this version uses a corporate CEO theme. Same engine, different flavor.

---

## ⚠️ Disclaimer

This project is provided "as is" without any warranties.

1. **AI-generated content is for reference only** — code, copy, and recommendations may contain errors. Review before production use.
2. **Code security** — always review AI-generated code before merging. Human review is mandatory for financial and security-sensitive operations.
3. **API key security** — keep your keys safe. Never commit config files with real keys to public repos.
4. **Server costs** — free-tier servers have usage limits. Monitor your cloud provider's billing to avoid unexpected charges.
5. **Data backup** — regularly back up your workspace and memory files. This project provides no data guarantees.

---

## License

MIT — see [LICENSE](./LICENSE)

> 📜 If you create derivative works or projects inspired by this architecture, please credit the original: [boluobobo-ai-court-tutorial](https://github.com/wanikua/boluobobo-ai-court-tutorial) by [@wanikua](https://github.com/wanikua)

---

v4.9
