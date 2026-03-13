# 🛡️ Security Guide

> ← [Back to README](../README.md) | [FAQ →](./faq.md)

---

## ⚠️ Don't Install on Your Personal Computer

**Strongly recommend using a cloud server, not your personal machine:**

| | Cloud Server | Personal Computer |
|---|---|---|
| Files Agent can access | Only server workspace | **All your personal files** |
| If something breaks | Rebuild server in 5 min | Personal files may be lost |
| API key exposure | Isolated on server | Exposed in personal env |
| 24/7 uptime | ✅ Server stays on | ❌ Stops when you close laptop |

> 🔴 Agents have **full read/write access** within their workspace, including command execution.

---

## 🔒 Workspace Permissions

```
✅ Recommended: dedicated directory
"workspace": "/home/ubuntu/clawd"        ← Agent can only access this

❌ Dangerous: home directory
"workspace": "/home/ubuntu"              ← Agent can access all your files

❌ Never: root
"workspace": "/"                         ← Equivalent to root access
```

---

## 🐳 Sandbox Configuration

| Mode | Meaning | Best For | Capabilities |
|------|---------|----------|-------------|
| `"off"` | No sandbox, runs on host | Chief of Staff, Marketing, Finance | ✅ Full access |
| `"non-main"` | Main session no sandbox, spawned tasks sandboxed | Default | Main normal, sub-tasks isolated |
| `"all"` | Everything in sandbox | Engineering, Audit (code runners) | ❌ Read-only FS, ✅ Workspace RW |

### Recommended Config

```json
"agents": {
  "defaults": {
    "workspace": "/home/ubuntu/clawd",
    "sandbox": { "mode": "non-main" }
  },
  "list": [
    { "id": "main", "sandbox": { "mode": "off" } },
    { "id": "engineering", "sandbox": { "mode": "all", "scope": "agent" } },
    { "id": "audit", "sandbox": { "mode": "all", "scope": "agent" } },
    { "id": "marketing", "sandbox": { "mode": "off" } },
    { "id": "finance", "sandbox": { "mode": "off" } }
  ]
}
```

---

## 🔑 API Key Security

- **Don't** commit config files with API keys to public repos
- **Don't** share API keys in group chats
- **Do** set usage limits on API keys (in provider dashboard)
- **Do** rotate keys periodically

---

## 📜 Disclaimer

This project is provided "as is" without any warranties. AI-generated content is for reference only — review before acting on it. Keep API keys safe. Back up your data regularly.

---

← [Back to README](../README.md)
