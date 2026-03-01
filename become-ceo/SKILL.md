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

For full server setup (Node.js, Chromium, firewall, swap), see the [setup guide on GitHub](https://github.com/wanikua/become-ceo).

## Your Team

- **Chief of Staff** (main) — routes your orders (Sonnet)
- **Engineering** — code, architecture, system design (Opus)
- **Finance** — budgets, cost control (Opus)
- **Marketing** — content, branding, social (Sonnet)
- **DevOps** — servers, CI/CD, infrastructure (Sonnet)
- **Management** — projects, coordination (Sonnet)
- **Legal** — compliance, contracts (Sonnet)

## Config Template

Full template: [references/clawdbot-template.json](references/clawdbot-template.json)

Key points:
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

Off by default. To sandbox non-main agents:

```json
"sandbox": {
  "mode": "all",
  "workspaceAccess": "ro",
  "docker": {
    "network": "none"
  }
}
```

The sandbox settings above use secure defaults. You can adjust them to fit your needs:

| Setting | Default | Options | Notes |
|---|---|---|---|
| `workspaceAccess` | `"ro"` | `"ro"`, `"rw"` | `"rw"` lets agents write to the workspace (including skills). Only use if agents need to create/edit files. |
| `docker.network` | `"none"` | `"none"`, `"bridge"` | `"bridge"` gives container network access. Only enable if agents need to call external APIs. |
| `docker.env` | _(omitted)_ | e.g. `{"KEY": "$KEY"}` | Pass env vars into the container. The gateway already handles API auth, so this is usually unnecessary. |

## Troubleshooting

**@everyone doesn't work** — each bot needs **Message Content Intent** + **Server Members Intent** in Discord Developer Portal, plus **View Channels** permission.

**Can't write files** — set `sandbox.mode: "off"` for that agent, or change `workspaceAccess` to `"rw"`.

**Messages silently dropped** — each Discord account needs `"groupPolicy": "open"` explicitly.

## Growing Your Team

1. Add to `agents.list` with unique `id` and `identity.theme`
2. Create Discord bot, enable intents
3. Add to `channels.discord.accounts` with token and `"groupPolicy": "open"`
4. Add binding in `bindings`
5. Invite bot to server, restart gateway
