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
- [Multi-Agent Collaboration Deep-Dive](#multi-agent-collaboration-deep-dive) — Sub-agent delegation, permissions, supervisor patterns
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

### Anti-Patterns to Avoid

| ❌ Don't | ✅ Do Instead |
|----------|--------------|
| Let every agent spawn every other agent | Use `allowAgents` to restrict — prevent circular delegation |
| Spawn sub-agents for trivial tasks | Only delegate when the task genuinely requires another specialist |
| Chain 5+ levels of delegation | Keep delegation to 2 levels max (CEO → Chief of Staff → Specialist) |
| Let agents spawn themselves | This creates infinite loops — `allowAgents` should never include the agent's own ID |

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
│       └── AGENTS.md                     # Group chat + memory rules
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

v4.0
