# 🏛️ AI Team — Clawdbot Skill

Run a team of AI specialists on Discord. 7 bots, each with its own role, personality, and model — talk to them by @mentioning, or @everyone to rally the whole crew.

`@Engineering` builds your features. `@Finance` watches your spend. `@everyone` gets the whole team moving.

## Install

```bash
# Fresh Ubuntu server? One line:
bash <(curl -fsSL https://raw.githubusercontent.com/wanikua/ai-team-skill/main/ai-team/scripts/setup.sh)
```

Already have Clawdbot? Just clone:

```bash
git clone https://github.com/wanikua/ai-team-skill.git ~/.clawdbot/skills/ai-team
```

## What's Inside

```
ai-team/
├── SKILL.md                          # Skill definition
├── scripts/
│   └── setup.sh                      # One-click server setup
└── references/
    ├── clawdbot-template.json        # Full 7-agent config, ready to fill in
    ├── SOUL.md                       # How agents behave
    ├── IDENTITY.md                   # Team structure
    ├── USER.md                       # About you (fill this in)
    └── AGENTS.md                     # Group chat + memory rules
```

## Get It Running

1. Run `setup.sh` — handles Node.js, Chromium, Clawdbot, workspace, everything
2. Open `~/.clawdbot/clawdbot.json`, fill in:
   - Anthropic API Key → [console.anthropic.com](https://console.anthropic.com)
   - Discord Bot Tokens (one per agent) → [discord.com/developers](https://discord.com/developers/applications)
3. For each bot, flip on **Message Content Intent** + **Server Members Intent**
4. `systemctl --user start clawdbot-gateway` — you're live

## The Team

| Bot | What it does | Model |
|---|---|---|
| **Dispatcher** (main) | Routes tasks to the right specialist | Sonnet |
| **Engineering** | Code, architecture, system design | Opus |
| **Finance** | Budgets, cost analysis, spend tracking | Opus |
| **Marketing** | Content, branding, social media | Sonnet |
| **DevOps** | Servers, CI/CD, infrastructure | Sonnet |
| **Management** | Projects, hiring, team coordination | Sonnet |
| **Legal** | Compliance, contracts, IP | Sonnet |

Want more specialists? Add agents to `agents.list`, `channels.discord.accounts`, and `bindings`. The config is just JSON.

## Common Gotchas

**@everyone does nothing?**
Check Discord Developer Portal — each bot needs **Message Content Intent** + **Server Members Intent** turned on. Bot role needs **View Channels** in the server.

**Agents can't write files (sandbox)?**
Sandbox runs agents in Docker with no filesystem access by default. Fix:
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
- `workspaceAccess: "rw"` — lets the container read/write the workspace
- `docker.network: "bridge"` — turns networking on (default is off, which breaks most skills)
- `docker.env` — pass in API keys (sandbox doesn't inherit host env vars)

**Messages silently disappear?**
Every Discord account entry needs `"groupPolicy": "open"` set individually. The global setting doesn't cascade down — this trips up everyone.

## How It Works

```
You: @Engineering build me a login API
              ↓
Discord → Clawdbot Gateway → Engineering Agent (Claude Opus)
                                    ↓
                             Reads workspace context (SOUL.md, IDENTITY.md)
                                    ↓
                             Writes code → replies in Discord
```

Each agent is an independent Discord bot mapped to a Clawdbot agent with its own:
- **Model** — Opus for heavy lifting, Sonnet for quick tasks
- **Personality** — defined in `identity.theme`
- **Workspace** — shared project files, memory, tools

Big tasks automatically spawn Discord threads to keep the channel clean.

## Links

- [Clawdbot Docs](https://docs.clawd.bot)
- [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/) — free ARM server, 4 cores, 24GB RAM
- [Chinese version (中文版 — 明朝六部)](https://github.com/wanikua/ai-court-skill)
- [Full Tutorial (中文教程)](https://github.com/wanikua/boluobobo-ai-court-tutorial)

## License

MIT
