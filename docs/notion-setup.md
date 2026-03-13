# 📝 Notion Integration (Auto-Archive)

Become CEO can auto-write daily reports, archive data, and manage knowledge bases via the Notion Skill. Setup takes 3 steps.

---

## Step 1: Create Notion Integration

1. Visit [Notion Integrations](https://www.notion.so/profile/integrations)
2. Click **New integration**
3. Name it (e.g., "CEO Agent"), select your Workspace
4. Copy the **Internal Integration Secret** (`ntn_xxx` or `secret_xxx`)

## Step 2: Store API Key

```bash
mkdir -p ~/.config/notion
echo "ntn_your_token" > ~/.config/notion/api_key
```

## Step 3: Authorize Pages/Databases

> ⚠️ This step is **critical** — without it, the API returns 404!

1. Open the Notion page or database you want AI to access
2. Click **`···`** top-right → **Connect to**
3. Select your Integration
4. Child pages inherit permissions automatically

## Verify

```bash
NOTION_KEY=$(cat ~/.config/notion/api_key)
curl -s "https://api.notion.com/v1/users/me" \
  -H "Authorization: Bearer $NOTION_KEY" \
  -H "Notion-Version: 2025-09-03" | head -c 200
```

Returns JSON with your Integration name = success.

## Usage Examples

```
@Chief-of-Staff Write today's work summary to the Notion daily report database
@Finance Create a new financial database with date, revenue, expenses, and notes
@Marketing Update this week's social media metrics in the Notion tracker
```

---

← [Back to README](../README.md)
