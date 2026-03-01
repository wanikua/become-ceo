# 🏛️ Become CEO

Your AI executive team on Discord. 7 specialists who actually do the work — you just give the orders.

`@Engineering` ships your features. `@Finance` watches your burn rate. `@Marketing` writes your content. `@everyone` gets the whole team moving.

One command to set up. Zero employees to manage.

## Install

```bash
# Fresh Ubuntu server? One line:
bash <(curl -fsSL https://raw.githubusercontent.com/wanikua/become-ceo/main/become-ceo/scripts/setup.sh)
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
setup.sh                              # One-click server setup (repo root)
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
   - Anthropic API Key → [console.anthropic.com](https://console.anthropic.com)
   - Discord Bot Tokens (one per role) → [discord.com/developers](https://discord.com/developers/applications)
3. For each bot, flip on **Message Content Intent** + **Server Members Intent**
4. `systemctl --user start clawdbot-gateway` — you're live

## Your Team

| Who | What they do | Brain |
|---|---|---|
| **Chief of Staff** (main) | Routes your orders to the right person | Sonnet |
| **Engineering** | Code, architecture, system design | Opus |
| **Finance** | Budgets, cost analysis, spend tracking | Opus |
| **Marketing** | Content, branding, social media | Sonnet |
| **DevOps** | Servers, CI/CD, infrastructure | Sonnet |
| **Management** | Projects, hiring, team coordination | Sonnet |
| **Legal** | Compliance, contracts, IP | Sonnet |

Need a bigger team? Add more agents — the config is just JSON.

## What It Looks Like

```
You:          @Engineering build me a user auth API
Engineering:  Done. JWT-based, here's the code + tests.
              [Auto-opens a Discord thread for the details]

You:          @Finance how much did our API calls cost this month?
Finance:      $47.23. Sonnet usage is up 30% — want me to find where?

You:          @everyone Monday standup. What's everyone working on?
All agents:   [Each one reports in with their status]
```

## Common Gotchas

**@everyone does nothing?**
Each bot needs **Message Content Intent** + **Server Members Intent** turned on in Discord Developer Portal. Bot role needs **View Channels**.

**Agents can't write files?**
Sandbox is off by default. If you turned it on, add this to your config:
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

**Messages silently disappear?**
Every Discord account needs `"groupPolicy": "open"` set individually. The global one doesn't cascade — everyone hits this.

## How It Works

```
You: @Engineering build me a login API
              ↓
Discord → Clawdbot Gateway → Engineering Agent (Claude Opus)
                                    ↓
                             Reads company context (SOUL.md, IDENTITY.md)
                                    ↓
                             Does the work → reports back in Discord
```

Each team member is an independent Discord bot with its own:
- **Brain** — Opus for heavy thinking, Sonnet for quick tasks
- **Personality** — defined in config, customizable
- **Memory** — learns your project over time
- **Tools** — 60+ built-in skills (GitHub, Notion, browser, cron...)

Big tasks auto-spawn Discord threads. Your channels stay clean.

## Links

- [Clawdbot Docs](https://docs.clawd.bot)
- [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/) — free ARM server, 4 cores, 24GB RAM
- [中文版 — AI 朝廷（明朝六部）](https://github.com/wanikua/ai-court-skill)
- [中文教程](https://github.com/wanikua/boluobobo-ai-court-tutorial)

## ⚠️ Disclaimer

This project is provided "as is" without any warranties.

**Please note:**

1. **AI-generated content is for reference only**
   - Code, suggestions, etc. may contain errors
   - Please review before using in production

2. **Code Security**
   - Review AI-generated code before merging
   - Human review required for financial/sensitive operations

3. **API Key Security**
   - Keep your API keys safe
   - Don't commit config files with keys to public repos

4. **Server Costs**
   - Free servers (Oracle Cloud, etc.) have limits
   - Excess usage may incur charges

5. **Data Backup**
   - Regularly backup your workspace

---

## License

MIT
