# 🖥️ GUI Dashboard

Become CEO provides three GUI layers: **Web Dashboard** for system status → **Discord** for commands → **Notion** for reports.

---

## Web Dashboard

Built-in web management dashboard (`gui/` directory), built with React + TypeScript + Vite.

### Features

- **Dashboard**: Real-time department status, token consumption, system load
- **Board Room**: Chat with department bots directly in the browser
- **Session Management**: View all historical sessions, message details, token stats
- **Scheduled Tasks**: Visual Cron task management (enable/disable/manual trigger)
- **Token Analytics**: Per-department, per-date token consumption analysis
- **System Health**: CPU/memory/disk monitoring, Gateway status

### Setup

```bash
cd become-ceo
cd gui && npm install && npm run build
cd server && npm install
CEO_AUTH_TOKEN=your_password node index.js
```

Visit: `http://your-server-ip:18795`

> ⚠️ **Login password**: Set via `CEO_AUTH_TOKEN` environment variable.
>
> 💡 For production, use Nginx reverse proxy + HTTPS. For persistence: `pm2 start server/index.js --name ceo-gui`

---

## Discord as GUI

Discord itself is an excellent management interface:
- **Mobile + Desktop** sync, manage anytime anywhere
- **Channel categories** naturally map to departments
- **Message history** permanently saved with search
- **Permission management** with fine-grained controls
- **@mention** any Agent, zero learning curve

---

## Notion for Data Visualization

Via the Notion Skill, data auto-syncs to Notion:
- **Daily Reports** and **Weekly Summaries** auto-generated
- **Finance Tracker** auto-records API consumption
- **Project Archives** track progress
- Notion boards, calendars, and table views provide rich visualization

> 📖 Setup: [Notion Integration Guide](./notion-setup.md)

---

← [Back to README](../README.md)
