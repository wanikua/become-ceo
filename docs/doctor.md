# 🏥 Health Check (doctor.sh)

> ← [Back to README](../README.md)

---

## One-Click Diagnostics

Having issues? Run this one-liner:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/wanikua/become-ceo/main/doctor.sh)
```

## What It Checks

- ✅ OpenClaw / Node.js installation
- ✅ Config file format and API Key validation
- ✅ Discord Bot Token, allowBots, groupPolicy settings
- ✅ Agent and Binding route matching
- ✅ Workspace files (SOUL.md / USER.md / memory/)
- ✅ Notion and other optional integrations
- ✅ Feishu appId / appSecret / permissions / event subscriptions
- ✅ **Complete @everyone not triggering checklist**

---

## @everyone Not Triggering Bot Responses?

This is the most common issue. Usually caused by **missing Discord Developer Portal Intents**:

1. Open [Discord Developer Portal](https://discord.com/developers/applications)
2. Select your Bot → **Bot** page on the left
3. Scroll to **Privileged Gateway Intents**, enable:
   - ✅ **Message Content Intent** (required)
   - ✅ **Server Members Intent** (required)
   - ✅ **Presence Intent** (optional)
4. **Enable on EVERY Bot**, not just one!
5. Confirm each Bot's role has **View Channels** permission in the server
6. Confirm `channels.discord.groupPolicy` and each account's `groupPolicy` are both `"open"`

> ⚠️ After changing Intents, **restart the Gateway**: `openclaw gateway restart` or `systemctl --user restart openclaw-gateway`

---

## Common Debug Commands

```bash
# Check Gateway status
systemctl --user status openclaw-gateway

# View detailed logs
journalctl --user -u openclaw-gateway --since today --no-pager

# Auto config check
openclaw doctor

# Auto-fix deprecated config fields
openclaw doctor --fix

# Check Feishu messages
journalctl --user -u openclaw-gateway --since "5 min ago" | grep -i "feishu\|lark"
```

---

← [Back to README](../README.md) | [Full FAQ](./faq.md)
