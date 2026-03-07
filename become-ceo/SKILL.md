---
name: become-ceo
description: "Your AI executive team on Discord. 7 specialists (engineering, finance, marketing, devops, legal, management, chief of staff) each with its own model and personality. Use when setting up, configuring, scaling, or troubleshooting a multi-bot Discord workspace where you are the CEO and AI agents are your team."
homepage: https://github.com/wanikua/become-ceo
metadata: {"clawdbot":{"emoji":"🏛️","requires":{"bins":["clawdbot","chromium-browser"]},"credentials":["LLM_API_KEY","DISCORD_BOT_TOKEN","NOTION_TOKEN","GITHUB_TOKEN"],"configs":["~/.clawdbot/clawdbot.json"],"install":[{"id":"node","kind":"node","package":"clawdbot","bins":["clawdbot"],"label":"Install Clawdbot"}]}}
---

# Become CEO — Your AI Executive Team

7 AI specialists on Discord. You give the orders, they do the work.

## Quick Start

**One-click setup** (recommended for new servers):
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/wanikua/become-ceo/main/setup.sh)
```
The v2.2 setup script auto-detects your OS/architecture/container environment, validates network connectivity, installs all dependencies, and runs an interactive configuration wizard for LLM provider, API key, Discord bot tokens, Notion integration, and GitHub authentication. New in v2.2: `--upgrade` to update an existing installation, `--uninstall` for clean removal, `--reset` to factory-reset config, Docker/LXC auto-detection (disables swap & systemd), auto-backup before config changes, and a post-install health check that verifies all components work. Use `--check` to verify your environment or `--dry-run` to preview without changes. Supports Ubuntu 22.04+, Debian 12+, Amazon Linux 2023, Fedora 38+ on amd64/arm64.

**Manual / existing Clawdbot install:**
1. Install this skill: `clawdhub install become-ceo`
2. Copy `references/clawdbot-template.json` to `~/.clawdbot/clawdbot.json`
3. Fill in your LLM API key, model IDs, and Discord bot tokens
4. Start: `systemctl --user start clawdbot-gateway`

For full details, see the [setup guide on GitHub](https://github.com/wanikua/become-ceo).

## Your Team

- **Chief of Staff** (main) — routes your orders (fast model)
- **Engineering** — code, architecture, system design (strong model)
- **Finance** — budgets, cost control (strong model)
- **Marketing** — content, branding, social (fast model)
- **DevOps** — servers, CI/CD, infrastructure (fast model)
- **Management** — projects, coordination (fast model)
- **Legal** — compliance, contracts (fast model)

## Config

See [references/clawdbot-template.json](references/clawdbot-template.json) for the full config template.

- Each Discord account **MUST** have `"groupPolicy": "open"` — does NOT inherit from global
- `identity.theme` sets each team member's personality
- `bindings` maps each agent to its Discord bot
- Replace `$LLM_PROVIDER`, `$MODEL_FAST`, `$MODEL_STRONG` with your chosen provider and models

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

Agents run in isolated containers with read-only workspace access and no network. The gateway handles all API authentication externally. See [Clawdbot docs](https://github.com/wanikua/become-ceo) for advanced sandbox options.

## Extending with ClawdHub Skills

Install additional skills from the ClawdHub marketplace:

```bash
# Core skills
clawdhub install email-daily-summary   # Email triage and daily digests
clawdhub install gcalcli-calendar      # Google Calendar integration
clawdhub install github-trending-cn    # GitHub trending repos digest
clawdhub install hacker-news           # Tech news monitoring
clawdhub install docker-essentials     # Container management
clawdhub install automation-workflows  # Pre-built workflow templates

# Extended skills
clawdhub install system-resource-monitor  # Server health monitoring
clawdhub install rss-feeds                # Custom news aggregation
clawdhub install slack-bridge             # Multi-platform messaging
clawdhub install ai-image-gen             # Visual content generation
clawdhub install screenshot-diff          # Visual change detection
```

All installed skills are available to every agent immediately after restart. Combine skills for compound value — see `references/skill-combinations.md` for 8 multi-skill recipes.

## Skill Governance

- **Pin production-critical skills** to specific versions: `clawdhub install email-daily-summary@1.2.0`
- **Auto-update low-risk skills** (weather, news): `clawdhub update weather`
- **Audit regularly**: `clawdhub outdated` shows available updates
- **Review before installing**: always check a new skill's SKILL.md for security red flags
- **Credential isolation**: never put API keys in SKILL.md files — use environment variables via sandbox config
- Set up a weekly skill audit cron on Chief of Staff to maintain your skill library

## Troubleshooting

- **@everyone doesn't work** — enable Message Content Intent + Server Members Intent in Discord Developer Portal
- **Messages silently dropped** — set `"groupPolicy": "open"` on each Discord account entry

## Growing Your Team

1. Add to `agents.list` with unique `id` and `identity.theme`
2. Create Discord bot, enable intents
3. Add to `channels.discord.accounts` with `"groupPolicy": "open"`
4. Add binding, invite bot, restart gateway
