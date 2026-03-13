# 🏢 Architecture Deep Dive

> ← [Back to README](../README.md) | [Deployment Guide →](./README.md)

---

## Technical Architecture

```
                          ┌─────────────────────┐
                          │      CEO (You)       │
                          │  Discord / Web UI    │
                          └──────────┬──────────┘
                                     │ Instructions (@mention / DM)
                                     ▼
                      ┌──────────────────────────────┐
                      │      OpenClaw Gateway         │
                      │      Node.js Daemon            │
                      │                              │
                      │  ┌─────────────────────────┐ │
                      │  │ Message Router (Bindings)│ │
                      │  │ channel + accountId      │ │
                      │  │ → agentId match → route  │ │
                      │  │ Session isolation · Cron  │ │
                      │  └─────────────────────────┘ │
                      └──┬───┬───┬───┬───┬───┬───┬───┘
                         │   │   │   │   │   │   │
           ┌─────────────┘   │   │   │   │   │   └─────────────┐
           ▼           ▼     ▼   ▼   ▼   ▼   ▼                ▼
     ┌───────────┐ ┌─────┐ ┌─────┐ ┌────┐ ┌────┐ ┌─────┐ ┌────────┐
     │Chief of   │ │Engr.│ │Fin. │ │ HR │ │Mktg│ │ Ops │ │ Legal  │
     │  Staff    │ │Code │ │$$   │ │Mgmt│ │Brand││DevOps│ │Complnc│
     │  (main)   │ │     │ │     │ │    │ │    │ │     │ │        │
     └───────────┘ └─────┘ └─────┘ └────┘ └────┘ └─────┘ └────────┘
           │          │      │      │      │      │          │
           ▼          ▼      ▼      ▼      ▼      ▼          ▼
     ┌───────────────────────────────────────────────────────────┐
     │           Skill Layer (OpenClaw 60+ ecosystem)            │
     │  GitHub · Notion · Browser · Cron · TTS · Screenshot      │
     │  sessions_spawn (cross-agent dispatch)                     │
     │  sessions_send (cross-agent messaging)                     │
     │  OpenClaw Hub community Skills                             │
     └───────────────────────────────────────────────────────────┘
```

Each Agent is bound to a Discord Bot account, all managed by a single Gateway process:
- **Independent sessions**: Each Agent has isolated session storage
- **Independent models**: Heavy work uses strong models, light work uses fast models — saves ~5x cost
- **Independent sandbox**: Configurable Docker sandbox isolation per Agent
- **Identity injection**: Gateway auto-assembles SOUL.md + IDENTITY.md + workspace files into system prompts
- **Message routing**: `bindings` config maps `(channel, accountId)` to `agentId`, most specific match wins

---

## C-Suite Structure

The C-Suite structure maps corporate departments to AI agents:

| Department | Corporate Role | AI Role | Recommended Model | Typical Tasks |
|-----------|---------------|---------|-------------------|---------------|
| **Chief of Staff** | Executive assistant | Coordination & dispatch | Fast Model | Daily chat, task routing, auto-reports |
| **Engineering** | CTO/VP Eng | Software development | Strong Model | Code, architecture, reviews, debugging |
| **Finance** | CFO | Financial operations | Strong Model | Cost analysis, budgets, e-commerce ops |
| **Marketing** | CMO | Brand & content | Fast Model | Copywriting, social media, campaigns |
| **Operations** | COO | Infrastructure | Fast Model | DevOps, CI/CD, server management |
| **HR** | VP HR | Project management | Fast Model | Team coordination, task tracking |
| **Legal** | General Counsel | Compliance | Fast Model | Contract review, IP, compliance checks |

> 💡 Model tiering strategy: Heavy tasks (coding/analysis) use strong models, light tasks (copy/management) use fast models — saves ~5x on costs.

---

## Multi-Provider Setup

The default template uses a single provider, but you can mix multiple providers and assign different models per department:

```json5
{
  "models": {
    "providers": {
      "anthropic": {
        "baseUrl": "https://api.anthropic.com",
        "apiKey": "sk-ant-xxx",
        "api": "anthropic-messages",
        "models": [
          { "id": "claude-sonnet-4-5", "name": "Claude Sonnet 4.5", "input": ["text", "image"], "contextWindow": 200000, "maxTokens": 8192 }
        ]
      },
      "deepseek": {
        "baseUrl": "https://api.deepseek.com/v1",
        "apiKey": "sk-xxx",
        "api": "openai-completions",
        "models": [
          { "id": "deepseek-chat", "name": "DeepSeek V3", "input": ["text"], "contextWindow": 128000, "maxTokens": 8192 }
        ]
      }
    }
  }
}
```

Then assign per agent:

```json5
{ "id": "engineering", "model": { "primary": "anthropic/claude-sonnet-4-5" } },  // Heavy work → Claude
{ "id": "marketing",   "model": { "primary": "deepseek/deepseek-chat" } }        // Light work → DeepSeek (cheap)
```

> Format: `providerName/modelId`. Supports any OpenAI API-compatible provider (Ollama, Gemini, etc.). See [OpenClaw model docs](https://docs.openclaw.ai/concepts/models).

---

## Core Capabilities

### Multi-Agent Collaboration

Each department is an independent Bot. @mention the right one and it responds. Large tasks auto-create Threads to keep channels clean.

**Built-in Approval Flow:**

```
CEO → @Chief-of-Staff: refactor user system
          │
          ├── spawn Engineering: implement
          │       │
          │       └── done → spawn Audit: code review
          │                       │
          │                       ├── ✅ Pass → merge
          │                       └── ❌ Reject → send back to Engineering
          │
          └── architecture change → spawn Strategy: review
                              │
                              ├── ✅ Approve → proceed
                              └── ❌ Veto → report back to CEO
```

> ⚠️ For bots to trigger each other, add `"allowBots": true` in `channels.discord` and set `"groupPolicy": "open"` on each account.

### Independent Memory

Each Agent has its own workspace and `memory/` directory. Knowledge accumulated through conversations persists to files across sessions. Agents get smarter about your projects over time.

### 60+ Skill Ecosystem

Built on the OpenClaw framework with 60+ built-in Skills:

| Category | Skills |
|----------|--------|
| Development | GitHub (Issues/PRs/CI), Coding Agent (code generation & refactoring) |
| Documentation | Notion (databases/pages/auto-reports) |
| Information | Browser automation, Web search, Web scraping, Hacker News |
| Automation | Cron scheduled tasks, heartbeat self-checks |
| Media | TTS voice, screenshots, video frame extraction |
| Operations | tmux remote control, shell commands, weather queries |
| Communication | Discord, Slack, Feishu (Lark), Telegram, WhatsApp, Signal… |
| Extensions | OpenClaw Hub community Skills, custom Skills |

#### 📦 Pre-installed Skills

| Skill | Description | API Key Required |
|-------|-------------|:---:|
| `weather` | Weather queries (wttr.in / Open-Meteo) | ❌ |
| `github` | GitHub operations (gh CLI) | ❌ (needs `gh auth login`) |
| `notion` | Notion page/database management | ✅ |
| `hacker-news` | Hacker News browsing and search | ❌ |
| `browser-use` | Browser automation | ❌ |
| `quadrants` | Four-quadrant task management | ✅ |
| `openviking` | Vector knowledge base | ✅ |

> 💡 Install more: `openclaw skill install <skill-name>`

### Scheduled Tasks (Cron)

Built-in Cron scheduler for automatic Agent execution:
- Auto-generate daily reports → send to Discord + save to Notion
- Weekly summaries
- Scheduled health checks, code backups
- Any custom scheduled task

### Sandbox Isolation

Agents can run in Docker sandboxes for isolated code execution. See [Security Guide](./security.md).

---

← [Back to README](../README.md)
