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

## ⚠️ 免责声明 / Disclaimer

本项目按"原样"提供，不承担任何直接或间接责任。/ This project is provided "as is" without any warranties.

**使用前请注意 / Please note:**

1. **AI 生成内容仅供参考 / AI-generated content is for reference only**
   - AI 生成的代码、文案、建议等可能存在错误或不准确之处
   - 使用前请自行审核，确认无风险后再实际应用
   - Code, suggestions, etc. may contain errors. Please review before using in production.

2. **代码安全 / Code Security**
   - 自动生成的代码建议在合并前进行 code review
   - 涉及财务、安全敏感的操作请务必人工复核
   - Review AI-generated code before merging. Human review required for financial/sensitive operations.

3. **API 密钥安全 / API Key Security**
   - 请妥善保管您的 API 密钥 / Keep your API keys safe
   - 不要将包含密钥的配置文件提交到公开仓库 / Don't commit config files with keys to public repos

4. **服务器费用 / Server Costs**
   - 免费服务器（Oracle Cloud 等）有一定使用限额 / Free servers have limits
   - 超出限额后可能产生费用，请留意账单 / Excess usage may incur charges

5. **数据备份 / Data Backup**
   - 建议定期备份您的工作区和数据 / Regularly backup your workspace
   - 本项目不提供任何数据保证 / This project provides no data guarantees

---

## License

MIT
