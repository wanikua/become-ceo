# 🔒 Privacy Policy

> Last updated: 2026-03-13

← [Back to README](../README.md) | [📚 Docs Index](./README.md)

---

## 1. Overview

This Privacy Policy describes how the Become CEO system handles data. The Project is a self-hosted, open-source system — **you control all your data**.

## 2. Data Collection

### What the Project Does NOT Collect

- ❌ We do **not** collect any personal information
- ❌ We do **not** have access to your server, conversations, or API keys
- ❌ We do **not** use analytics, tracking, or telemetry
- ❌ We do **not** operate any central server that receives your data

### What Stays on Your Server

| Data | Location | Description |
|------|----------|-------------|
| Configuration | `~/.openclaw/openclaw.json` | API keys, bot tokens, agent settings |
| Conversations | `~/.clawdbot/agents/*/sessions/` | Chat history per agent |
| Memory files | `~/clawd/memory/` | Agent memory and notes |
| Workspace files | `~/clawd/` | SOUL.md, USER.md, IDENTITY.md, etc. |

**You have full control** over all data. Delete anytime by removing the directories.

## 3. Third-Party Data Sharing

Your data is sent to third-party services **that you configure**:

### AI Model Providers

| Provider | Their Privacy Policy |
|----------|---------------------|
| Anthropic | https://www.anthropic.com/privacy |
| OpenAI | https://openai.com/privacy |
| DeepSeek | https://www.deepseek.com/privacy |
| OpenRouter | https://openrouter.ai/privacy |

### Communication Platforms

| Platform | Their Privacy Policy |
|----------|---------------------|
| Discord | https://discord.com/privacy |
| Feishu/Lark | https://www.feishu.cn/privacy |

## 4. Data Security

Since the Project is self-hosted, data security is your responsibility. See [Security Guide](./security.md).

## 5. Open Source Transparency

- **Repository**: https://github.com/wanikua/become-ceo
- All installation scripts are readable before execution

## 6. Contact

For privacy questions, open a [GitHub Issue](https://github.com/wanikua/become-ceo/issues).

---

← [Back to README](../README.md)
