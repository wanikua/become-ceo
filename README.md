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
Yes. Agents can use `sessions_spawn` to create sub-tasks for other agents, or `sessions_send` to message another agent's session. For example, Chief of Staff can delegate a coding task to Engineering programmatically.

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

v3.6
