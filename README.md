[中文说明](./README_CN.md)

# 🏢 Become CEO — Your AI Executive Team on Discord

> One free server + [Clawdbot](https://github.com/clawdbot/clawdbot) = a 7-person team that works 24/7

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Built on Clawdbot](https://img.shields.io/badge/built%20on-Clawdbot-8A2BE2)](https://github.com/clawdbot/clawdbot)
[![Discord](https://img.shields.io/badge/interface-Discord-5865F2?logo=discord&logoColor=white)](https://discord.com)

Ship features. Track spend. Write content. Run standup. Deploy to prod.
You just type one message in Discord — your team handles the rest.

```
You:          @Engineering build me a user auth API with JWT
Engineering:  On it. [opens thread, writes code, pushes to GitHub]

You:          @Finance how much did our API calls cost this month?
Finance:      $47.23 — up 30% from last month. Want me to find where the spike is?

You:          @everyone Monday standup. What's everyone working on?
Everyone:     [Each agent reports in with their status]
```

---

> 📌 **About Originality** — This project is the English adaptation of [AI Court Tutorial](https://github.com/wanikua/boluobobo-ai-court-tutorial) (first commit 2026-02-22), the original implementation of "ancient governance systems as AI multi-agent orchestration." We noticed [cft0808/edict](https://github.com/cft0808/edict) (first commit 2026-02-23, ~21 hours later) shares highly similar framework choices, SOUL.md personality files, deployment methods, and competitor comparison tables — see [Issue #55](https://github.com/cft0808/edict/issues/55).
>
> **Redistribution welcome — please credit the source.**

---

## Why This Setup?

|  | ChatGPT / Web UIs | AutoGPT / CrewAI / MetaGPT | **Become CEO (this project)** |
|---|---|---|---|
| Multi-agent collab | ❌ Single generalist | ✅ Requires Python orchestration | ✅ Config file — zero code |
| Independent memory | ⚠️ One shared context | ⚠️ Roll your own vector DB | ✅ Each agent has its own workspace + memory files |
| Tool integrations | ⚠️ Limited plugins | ⚠️ Build them yourself | ✅ 60+ built-in skills (GitHub, Notion, browser, cron…) |
| Interface | Web browser | CLI / custom UI | ✅ Discord — works on phone, tablet, desktop |
| Setup difficulty | None (SaaS) | Docker + coding | ✅ One-line script, 5 minutes to running |
| 24/7 online | ❌ Manual conversations | ✅ | ✅ Cron tasks + heartbeat self-checks |

**The core difference: this isn't a framework — it's a finished product.** Run one script, get a working team. `@mention` anyone, they respond.

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

## Quick Start

### Step 1: One-Click Deploy (~5 min)

Grab an Ubuntu server — [Oracle Cloud free tier](https://www.oracle.com/cloud/free/) gives you ARM 4-core / 24GB RAM permanently free. SSH in and run:

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

1. **LLM API Key** — from your provider (Anthropic, OpenAI, Google, etc.)
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

---

## Config Deep-Dive

Your entire team is defined in `~/.clawdbot/clawdbot.json`. Here's how it's structured:

### Models — Define your LLM providers

```json
"models": {
  "providers": {
    "anthropic": {
      "apiKey": "sk-ant-...",
      "models": [
        { "id": "claude-sonnet-4-20250514", "name": "Fast Model" },
        { "id": "claude-opus-4-20250514", "name": "Strong Model" }
      ]
    }
  }
}
```

Mix providers freely — one agent on Anthropic, another on OpenAI, another on a local Ollama instance.

### Agents — Define your team

```json
"agents": {
  "list": [
    {
      "id": "engineering",
      "model": { "primary": "anthropic/claude-opus-4-20250514" },
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
  "model": { "primary": "anthropic/claude-sonnet-4-20250514" },
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

## Common Gotchas / Troubleshooting

### `@everyone` doesn't trigger any agents

Each bot needs **Message Content Intent** + **Server Members Intent** enabled in the Discord Developer Portal. The bot's role in your server also needs **View Channels** permission.

### Messages silently disappear

`groupPolicy: "open"` must be set on **each individual account** in the config. The global setting doesn't cascade. [See the config section above.](#%EF%B8%8F-the-grouppolicy-gotcha)

### Gateway won't start

```bash
# Check logs
journalctl --user -u clawdbot-gateway --since today --no-pager

# Run diagnostic
clawdbot doctor

# Common causes: missing API key, invalid JSON, bad bot token
```

### Sandbox mode blocks file writes

If you've enabled sandbox mode (`"mode": "all"`), the container defaults to read-only filesystem and no network. Fix:

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

### Multiple people @-ing the same agent — do they conflict?

No. Clawdbot maintains separate sessions per user × agent combination. Multiple people can talk to Engineering simultaneously without interference.

### Can agents call each other?

Yes. Agents can use `sessions_spawn` to create sub-tasks for other agents, or `sessions_send` to message another agent's session. For example, Chief of Staff can delegate a coding task to Engineering automatically.

### Can I use local models (Ollama, etc.)?

Yes. Add any OpenAI-compatible provider to `models.providers` with a `baseUrl` pointing to your local instance. Zero API cost.

### How much does it cost per month?

Depends on usage. Light use: $10–15/mo. Medium: $20–30/mo. Save money by using strong models only for heavy tasks (code, analysis) and fast/budget models for everything else.

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

## Links

| Resource | Link |
|----------|------|
| **Clawdbot** (the engine) | [github.com/clawdbot/clawdbot](https://github.com/clawdbot/clawdbot) |
| **Clawdbot Docs** | [docs.clawd.bot](https://docs.clawd.bot) |
| **Chinese Version** — AI Court (Ming Dynasty metaphor) | [wanikua/boluobobo-ai-court-tutorial](https://github.com/wanikua/boluobobo-ai-court-tutorial) |
| **Chinese Skill Package** — AI Court Skill | [wanikua/ai-court-skill](https://github.com/wanikua/ai-court-skill) |
| **ClawdHub** | `clawdhub install become-ceo` |

---

## ⚠️ Disclaimer

This project is provided "as is" without any warranties.

1. **AI-generated content is for reference only** — code, copy, and recommendations may contain errors. Review before production use.
2. **Code security** — always review AI-generated code before merging. Human review is mandatory for financial and security-sensitive operations.
3. **API key security** — keep your keys safe. Never commit config files with real keys to public repos.
4. **Server costs** — Oracle Cloud free tier has usage limits. Monitor your billing to avoid unexpected charges.
5. **Data backup** — regularly back up your workspace and memory files. This project provides no data guarantees.

---

## License

MIT — see [LICENSE](./LICENSE)

> 📜 If you create derivative works or projects inspired by this architecture, please credit the original: [boluobobo-ai-court-tutorial](https://github.com/wanikua/boluobobo-ai-court-tutorial) by [@wanikua](https://github.com/wanikua)

---

v3.4
