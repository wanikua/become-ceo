---
name: ai-team
description: "Deploy a multi-agent AI team on Discord using Clawdbot. 7 specialized bots (engineering, finance, marketing, devops, legal, management, dispatcher) each with its own model and personality. Use when setting up, configuring, scaling, or troubleshooting a multi-bot Discord workspace."
homepage: https://github.com/wanikua/ai-team-skill
metadata: {"clawdbot":{"emoji":"🏛️","requires":{"bins":["clawdbot"]},"install":[{"id":"node","kind":"node","package":"clawdbot","bins":["clawdbot"],"label":"Install Clawdbot"}]}}
---

# AI Team — Multi-Agent Discord Workspace

Deploy a team of specialized AI agents on Discord. Each agent runs as an independent bot with its own expertise, personality, and model tier.

## Quick Start

```bash
bash scripts/setup.sh
```

Then fill in API keys and Discord bot tokens in `~/.clawdbot/clawdbot.json`.

## Architecture

```
@Engineering build me a login API
       ↓
Discord → Clawdbot Gateway → Agent (Claude Opus)
                                ↓
                         Reads SOUL.md / IDENTITY.md
                                ↓
                           Does the work → replies
```

- **Dispatcher** (main) — routes tasks, quick responses (Sonnet)
- **Engineering** — code, architecture, system design (Opus)
- **Finance** — budgets, cost control (Opus)
- **Marketing** — content, branding, social (Sonnet)
- **DevOps** — servers, CI/CD, infrastructure (Sonnet)
- **Management** — projects, coordination (Sonnet)
- **Legal** — compliance, contracts (Sonnet)

Add more agents as needed.

## Config Template

Full template: [references/clawdbot-template.json](references/clawdbot-template.json)

Key points:
- Each Discord account **MUST** have `"groupPolicy": "open"` — does NOT inherit from global
- `identity.theme` sets the agent's personality and speaking style
- `bindings` maps each agent to its Discord bot

## Workspace Files

| File | What it does |
|---|---|
| `SOUL.md` | Core behavior rules |
| `IDENTITY.md` | Team structure and model tiers |
| `USER.md` | Info about you |
| `AGENTS.md` | Group chat rules, memory protocol |

## Sandbox

Off by default. To sandbox non-main agents:

```json
"sandbox": {
  "mode": "all",
  "workspaceAccess": "rw",
  "docker": {
    "network": "bridge",
    "env": { "ANTHROPIC_API_KEY": "sk-..." }
  }
}
```

- `workspaceAccess: "rw"` — mount workspace read-write
- `docker.network: "bridge"` — allow network (default `"none"` breaks most skills)
- `docker.env` — pass API keys in (sandbox doesn't inherit host env)

## Troubleshooting

**@everyone doesn't trigger agents** — each bot needs **Message Content Intent** + **Server Members Intent** in Discord Developer Portal, plus **View Channels** permission.

**Can't write files** — set `sandbox.mode: "off"`, or configure `workspaceAccess`/`network`/`env` as above.

**Messages silently dropped** — each Discord account needs `"groupPolicy": "open"` explicitly. Global setting doesn't cascade.

## Adding Agents

1. Add to `agents.list` with unique `id` and `identity.theme`
2. Create Discord bot, enable intents
3. Add to `channels.discord.accounts` with token and `"groupPolicy": "open"`
4. Add binding in `bindings`
5. Invite bot to server, restart gateway
