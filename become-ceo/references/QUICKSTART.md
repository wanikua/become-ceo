# QUICKSTART.md — One-Page Cheat Sheet

> Print this. Tape it to your monitor. Everything you need on one page.

---

## 🚀 Setup (5 minutes)

```bash
git clone https://github.com/wanikua/become-ceo.git
cd become-ceo
bash setup.sh
```

That's it. The script installs everything, walks you through config, and starts the gateway.

---

## 📋 Essential Commands

| What | Command |
|------|---------|
| Start gateway | `systemctl --user start clawdbot-gateway` |
| Stop gateway | `systemctl --user stop clawdbot-gateway` |
| Restart gateway | `systemctl --user restart clawdbot-gateway` |
| Check status | `clawdbot status` |
| View logs | `journalctl --user -u clawdbot-gateway -f` |
| Diagnose issues | `clawdbot doctor` |
| Edit config | `nano ~/.clawdbot/clawdbot.json` |

> **Container/Docker?** Replace `systemctl` commands with `clawdbot gateway start/stop/restart`.

---

## 💬 Talking to Your Team

| What | How |
|------|-----|
| Ask one agent | `@Engineering review this PR` |
| Ask everyone | `@everyone what's your status?` |
| Delegate a chain | `@Chief of Staff get Engineering to build X and DevOps to deploy it` |
| Check costs | `@Finance how much did we spend this week?` |

---

## ⏰ Cron (Scheduled Tasks)

```bash
# Add a daily standup at 9 AM
clawdbot cron add --agent main --cron "0 9 * * *" --text "Run daily standup: collect status from all departments, post summary to #standup, archive to Notion"

# List all cron jobs
clawdbot cron list

# Test a job right now
clawdbot cron run <job-id>

# Disable a job
clawdbot cron disable <job-id>
```

---

## 📦 Skills (ClawdHub)

```bash
# Search for skills
clawdhub search "email"

# Install a skill
clawdhub install email-daily-summary

# Check for updates
clawdhub outdated

# Update all skills
clawdhub update --all
```

**Start with these 3:** `weather`, `gcalcli-calendar`, `email-daily-summary`

---

## 🗂️ Workspace Files

| File | What It Does | Edit When |
|------|-------------|-----------|
| `SOUL.md` | Team culture & rules | You want to change team behavior |
| `AGENTS.md` | Memory, safety, group chat rules | You add new workflows |
| `USER.md` | About you (name, timezone, prefs) | Your situation changes |
| `IDENTITY.md` | Org chart & model tiers | You add/remove agents |
| `TOOLS.md` | External services & credentials | You add new integrations |
| `HEARTBEAT.md` | Periodic monitoring checks | You want proactive alerts |

```bash
# Copy templates to your workspace
cp become-ceo/references/*.md ~/clawd/
# Edit to match your setup
nano ~/clawd/USER.md
```

---

## 🏗️ Config Structure (clawdbot.json)

```
models.providers     → LLM credentials (API key, base URL)
agents.defaults      → shared settings (workspace, concurrency)
agents.list[]        → each agent (id, model, identity, subagents)
channels.discord     → bot tokens, guild settings
bindings[]           → which Discord account → which agent
```

**Key fields per agent:**
- `id` — unique identifier (matches Discord account key)
- `model.primary` — which LLM to use (`$PROVIDER/$MODEL`)
- `identity.name` — display name
- `identity.theme` — behavior instructions (the agent's "personality")
- `subagents.allowAgents` — which other agents this one can delegate to

---

## 🎯 First 3 Things to Do After Setup

1. **Say hello** — `@Chief of Staff what can you do?` → verify it works
2. **Try a real task** — `@Engineering write a hello world REST API` → see tools in action
3. **Set up standup** — add a daily standup cron → start getting value while you sleep

---

## ⚡ Common Patterns

**Morning routine (automated):**
```
Cron at 8 AM → Chief of Staff collects weather + calendar + email + GitHub status → posts digest
```

**Feature development:**
```
You → @Engineering build X → Engineering codes → @DevOps deploy to staging → DevOps deploys → @Finance track the cost
```

**Incident response:**
```
Cron detects downtime → DevOps investigates → spawns Engineering if code issue → posts to #incidents → archives to Notion
```

**Content pipeline:**
```
@Marketing research trending topics → draft blog post → @Engineering review technical accuracy → publish
```

---

## 🆘 Something Broken?

| Symptom | Fix |
|---------|-----|
| Bot online but silent | Enable Message Content Intent in Discord Developer Portal |
| Messages disappear | Set `groupPolicy: "open"` on **each account** in config |
| Agent confused | Check workspace has SOUL.md, USER.md, IDENTITY.md |
| High costs | Switch more agents to Fast model in config |
| Gateway won't start | `clawdbot doctor` + check logs |
| Config error | `python3 -m json.tool < ~/.clawdbot/clawdbot.json` |

---

## 📐 Agent Sizing Guide

| Team Size | Agents | Monthly Cost (est.) | Template |
|-----------|--------|---------------------|----------|
| Solo / hobby | 3 | $5–10 | Lean Startup |
| Small team | 5 | $15–25 | Engineering-Heavy or Content |
| Full operation | 7 | $20–40 | Full Enterprise |
| With extras | 7+ | $30–50+ | Full Enterprise + custom agents |

---

## 🔗 Resources

| What | Where |
|------|-------|
| Full README | [README.md](../README.md) |
| Clawdbot Docs | [docs.clawd.bot](https://docs.clawd.bot) |
| Skill Marketplace | [clawdhub.com](https://clawdhub.com) |
| Config Template | [`clawdbot-template.json`](./clawdbot-template.json) |
| Cron Recipes | [`cron-recipes.md`](./cron-recipes.md) (18 templates) |
| Browser Recipes | [`browser-recipes.md`](./browser-recipes.md) (8 templates) |
| GitHub Workflows | [`github-workflows.md`](./github-workflows.md) (8 templates) |
| Notion Schemas | [`notion-templates.md`](./notion-templates.md) (8 databases) |
| Skill Combos | [`skill-combinations.md`](./skill-combinations.md) (8 recipes) |

---

*This is the 80/20 of Become CEO. For the other 80%, read the full [README](../README.md).*
