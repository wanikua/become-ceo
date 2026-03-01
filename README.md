# Become CEO

Your AI executive team on Discord. 7 specialists who actually do the work — you just give the orders.

`@Engineering` ships your features. `@Finance` watches your burn rate. `@Marketing` writes your content. `@everyone` gets the whole team moving.

One command to set up. Zero employees to manage.

## Install

```bash
# Fresh Ubuntu server? One line:
bash <(curl -fsSL https://raw.githubusercontent.com/wanikua/become-ceo/main/setup.sh)
```

Already have Clawdbot?

```bash
# From ClawdHub (recommended):
clawdhub install become-ceo

# Or clone directly:
git clone https://github.com/wanikua/become-ceo.git ~/.clawdbot/skills/become-ceo
```

## What's Inside

```
setup.sh                              # One-click server setup
become-ceo/
├── SKILL.md                          # Skill definition (ClawdHub package)
└── references/
    ├── clawdbot-template.json        # Full 7-agent config, ready to fill in
    ├── SOUL.md                       # How your team behaves
    ├── IDENTITY.md                   # Org chart
    ├── USER.md                       # About you, the CEO
    └── AGENTS.md                     # Group chat + memory rules
```

## Get It Running

1. Run `setup.sh` — handles Node.js, Chromium, Clawdbot, workspace, everything
2. Open `~/.clawdbot/clawdbot.json`, fill in:
   - Your LLM provider, API key, and model IDs
   - Discord Bot Tokens (one per role) — [discord.com/developers](https://discord.com/developers/applications)
3. For each bot, flip on **Message Content Intent** + **Server Members Intent**
4. `systemctl --user start clawdbot-gateway` — you're live

## Your Team

| Who | What they do | Model tier |
|---|---|---|
| **Chief of Staff** (main) | Routes your orders to the right person | Fast |
| **Engineering** | Code, architecture, system design | Strong |
| **Finance** | Budgets, cost analysis, spend tracking | Strong |
| **Marketing** | Content, branding, social media | Fast |
| **DevOps** | Servers, CI/CD, infrastructure | Fast |
| **Management** | Projects, hiring, team coordination | Fast |
| **Legal** | Compliance, contracts, IP | Fast |

Need a bigger team? Add more agents — the config is just JSON.

## What It Looks Like

```
You:          @Engineering build me a user auth API
Engineering:  Done. JWT-based, here's the code + tests.

You:          @Finance how much did our API calls cost this month?
Finance:      $47.23. Usage is up 30% — want me to find where?

You:          @everyone Monday standup. What's everyone working on?
All agents:   [Each one reports in with their status]
```

## Common Gotchas

**@everyone does nothing?**
Each bot needs **Message Content Intent** + **Server Members Intent** turned on in Discord Developer Portal. Bot role needs **View Channels**.

**Messages silently disappear?**
Every Discord account needs `"groupPolicy": "open"` set individually. The global one doesn't cascade — everyone hits this.

## How It Works

```
You: @Engineering build me a login API
              ↓
Discord → Clawdbot Gateway → Engineering Agent (Strong Model)
                                    ↓
                             Reads company context (SOUL.md, IDENTITY.md)
                                    ↓
                             Does the work → reports back in Discord
```

Each team member is an independent Discord bot with its own:
- **Brain** — strong model for heavy thinking, fast model for quick tasks
- **Personality** — defined in config, customizable
- **Memory** — learns your project over time
- **Tools** — 60+ built-in skills (GitHub, Notion, browser, cron...)

Big tasks auto-spawn Discord threads. Your channels stay clean.

## Links

- [Clawdbot Docs](https://docs.clawd.bot)
- [中文版 — AI 朝廷（明朝六部）](https://github.com/wanikua/ai-court-skill)
- [中文教程](https://github.com/wanikua/boluobobo-ai-court-tutorial)

## Disclaimer

This project is provided "as is" without any warranties.

1. **AI-generated content is for reference only** — review before production use
2. **Code security** — review AI-generated code before merging; human review required for sensitive operations
3. **API key security** — keep keys safe; don't commit config files with keys to public repos
4. **Data backup** — regularly backup your workspace

## License

MIT
