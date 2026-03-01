---
name: become-ceo
description: "Your AI executive team on Discord. 7 specialists (engineering, finance, marketing, devops, legal, management, chief of staff) each with its own model and personality. Use when setting up, configuring, scaling, or troubleshooting a multi-bot Discord workspace where you are the CEO and AI agents are your team."
homepage: https://github.com/wanikua/become-ceo
metadata: {"clawdbot":{"emoji":"🏛️","requires":{"bins":["clawdbot"]},"install":[{"id":"node","kind":"node","package":"clawdbot","bins":["clawdbot"],"label":"Install Clawdbot"}]}}
---

# Become CEO — Your AI Executive Team

7 AI specialists on Discord. You give the orders, they do the work.

## Quick Start

1. Install Clawdbot: `npm install -g clawdbot`
2. Install this skill: `clawdhub install become-ceo`
3. Copy `references/clawdbot-template.json` to `~/.clawdbot/clawdbot.json`
4. Fill in your Anthropic API key and Discord bot tokens
5. Start: `systemctl --user start clawdbot-gateway`

For full server setup, see the [setup guide on GitHub](https://github.com/wanikua/become-ceo).

## Your Team

- **Chief of Staff** (main) — routes your orders (Sonnet)
- **Engineering** — code, architecture, system design (Opus)
- **Finance** — budgets, cost control (Opus)
- **Marketing** — content, branding, social (Sonnet)
- **DevOps** — servers, CI/CD, infrastructure (Sonnet)
- **Management** — projects, coordination (Sonnet)
- **Legal** — compliance, contracts (Sonnet)

## Config

See [references/clawdbot-template.json](references/clawdbot-template.json) for the full config template.

- Each Discord account **MUST** have `"groupPolicy": "open"` — does NOT inherit from global
- `identity.theme` sets each team member's personality
- `bindings` maps each agent to its Discord bot

## Workspace Files

| File | What it does |
|---|---|
| `SOUL.md` | How your team behaves |
| `IDENTITY.md` | Org chart and model tiers |
| `USER.md` | About you, the CEO |
| `AGENTS.md` | Group chat rules, memory protocol |

## Sandbox

Off by default. To enable read-only sandboxed execution:

```json
"sandbox": {
  "mode": "all",
  "workspaceAccess": "ro",
  "docker": { "network": "none" }
}
```

Agents run in isolated containers with read-only workspace access and no network. The gateway handles all API authentication externally — agents do not need direct access to keys. See [Clawdbot docs](https://github.com/wanikua/become-ceo) for advanced sandbox options.

## Troubleshooting

- **@everyone doesn't work** — enable Message Content Intent + Server Members Intent in Discord Developer Portal
- **Messages silently dropped** — set `"groupPolicy": "open"` on each Discord account entry

## Growing Your Team

1. Add to `agents.list` with unique `id` and `identity.theme`
2. Create Discord bot, enable intents
3. Add to `channels.discord.accounts` with `"groupPolicy": "open"`
4. Add binding, invite bot, restart gateway
