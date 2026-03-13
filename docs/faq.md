# ❓ Frequently Asked Questions

---

## Basic Questions

### Q: Do I need coding experience?
No. The one-click script handles installation. Config is just filling in a few API keys. All interaction is natural language via Discord.

### Q: How is this different from just using ChatGPT?
ChatGPT is one generalist that forgets everything after each conversation. This system is multiple specialists — each Agent has their own expertise, persistent memory, and tool access. They can auto-commit code to GitHub, write docs to Notion, and run scheduled tasks.

### Q: Can I use other models?
Yes. OpenClaw supports Anthropic, OpenAI, Google Gemini, and any OpenAI API-compatible provider. Just change the model config in `openclaw.json`. Different departments can use different models.

### Q: How much does API usage cost monthly?
Depends on usage. Light use: $10-15/month. Moderate: $20-30/month. Cost-saving tip: heavy tasks use strong models, light tasks use fast models (~5x cheaper). Simple tasks can use economy models.

### Q: What's the relationship to the 朝廷 (AI Court) project?
[AI Court](https://github.com/wanikua/boluobobo-ai-court-tutorial) is the Chinese-themed version of this project. Both use the same OpenClaw framework and architecture, but with different branding (Ming Dynasty court vs. modern corporate C-Suite).

---

## Technical Questions

### Q: @everyone not triggering Agent responses?
Each Bot in Discord Developer Portal needs **Message Content Intent** and **Server Members Intent** enabled. Bot roles need **View Channels** permission in the server.

### Q: Agent reports "read-only filesystem" or "apt failed"?
Sandbox mode is set to `all`, causing the Agent to run in a Docker container with a read-only filesystem.

**Simplest fix:** Turn off sandbox for non-coding departments:
```json
"sandbox": { "mode": "off" }
```

**If you need sandbox but want more permissions:**
```json
"sandbox": {
  "mode": "all",
  "workspaceAccess": "rw",
  "docker": {
    "network": "bridge",
    "env": { "LLM_API_KEY": "your_key" }
  }
}
```

> See [Security Guide](./security.md) for details.

### Q: Multiple people @mentioning the same Agent — any conflicts?
No. OpenClaw maintains independent sessions per user × Agent combination. Multiple people @mentioning Engineering at the same time won't interfere with each other.

### Q: Can Agents call each other?
Yes. Use `sessions_spawn` to create sub-tasks for other Agents. Use `sessions_send` to send messages to other Agent sessions.

### Q: How do I create custom Skills?
A Skill is a directory containing `SKILL.md` + scripts + resources. Place it in the `skills/` directory. You can also get community Skills from [OpenClaw Hub](https://github.com/openclaw/openclaw).

### Q: How do I connect self-hosted models (Ollama, etc.)?
Add an OpenAI API-compatible provider in `openclaw.json` → `models.providers`, set `baseUrl` to your Ollama address. Zero API cost.

### Q: Startup error "workspace does not exist"?
Create the missing directory, or have all Agents share one workspace (recommended):
```json
"agents": {
  "defaults": { "workspace": "$HOME/clawd" },
  "list": [
    { "id": "main" },
    { "id": "engineering" }
  ]
}
```

### Q: Gateway won't start?
```bash
journalctl --user -u openclaw-gateway --since today --no-pager
openclaw doctor
```
Common causes: API Key not filled, JSON syntax error, invalid Bot Token.

### Q: Config invalid error?
Newer OpenClaw versions removed deprecated fields (e.g., `runTimeoutSeconds`). Run `openclaw doctor --fix` to auto-fix.

### Q: Windows support?
Yes! Via WSL2. See [Windows WSL2 Guide](./windows-wsl.md).

---

← [Back to README](../README.md)
