# HEARTBEAT.md - Periodic Check-In Tasks

> Copy this into your workspace root. The main agent reads this on every heartbeat poll
> (typically every 30-60 minutes). Tasks listed here run automatically — no human input needed.
>
> Keep it small — each heartbeat costs tokens. Only include what matters.

---

<!--
## How Heartbeats Work

Your agent receives a heartbeat prompt periodically. It reads this file and:
1. Runs each task listed below
2. If something needs attention → sends a message to you
3. If nothing needs attention → replies HEARTBEAT_OK (silent, costs minimal tokens)

## Rules
- Don't duplicate cron jobs here — use cron for exact schedules
- Heartbeats are best for batching multiple quick checks
- Keep total checks under 5 to limit token burn per heartbeat
- Track last-check timestamps in memory/heartbeat-state.json
-->

# Keep this file empty (or with only comments) to skip heartbeat API calls.
# Uncomment one of the templates below when you're ready.

---

## 🎨 Scenario Templates

> Uncomment the template that matches your workflow. Mix and match as needed.

### Template A: Solo Founder (Low-Frequency)

Good for bootstrapped founders who want occasional check-ins without burning tokens.

```markdown
# Check every heartbeat (rotate — don't do all at once)
# Track state in memory/heartbeat-state.json

## Checks (rotate through these, pick 1-2 per heartbeat)
- [ ] GitHub: any open PRs waiting for review? Any failed CI runs?
- [ ] Costs: anything unusual in the last 24h?
- [ ] Uptime: are my sites responding?

## When to alert me
- Failed CI on main branch
- Site down for >5 minutes
- Cost spike >50% above daily average

## When to stay quiet (HEARTBEAT_OK)
- Nothing new since last check
- It's between 11pm and 8am
- All systems green
```

### Template B: Active Manager (High-Frequency)

For hands-on operators who want real-time awareness of everything.

```markdown
## Every heartbeat, check:
1. GitHub notifications — open PRs, review requests, CI failures
2. Notion inbox — any pages tagged "needs-review"
3. Social media — mentions, DMs, engagement spikes

## Smart scheduling
- Morning (8-10am): prioritize email + calendar
- Midday (11am-2pm): GitHub + deployments
- Afternoon (3-5pm): social media + content metrics
- Evening (6-9pm): light monitoring only
- Night (10pm-7am): emergencies only

## Alert thresholds
- Email: only if sender is in Important People list
- GitHub: only if PR is >24h old or CI failed on main
- Social: only if engagement >2x average or negative sentiment
- Costs: only if daily spend >$X
```

### Template C: DevOps Focus (Infrastructure Monitoring)

For teams where infrastructure health is the priority.

```markdown
## Every heartbeat:
1. Check server health (CPU, memory, disk via SSH)
2. Verify key endpoints respond (HTTP 200)
3. Review recent deploy status
4. Check error log volumes (spike detection)

## Endpoints to monitor
- https://myapp.com — main site
- https://api.myapp.com/health — API health check
- https://staging.myapp.com — staging environment

## Alert rules
- Any endpoint down → immediate alert with response code
- CPU >80% for >10min → warning
- Disk >90% → critical alert
- Error rate >5% of requests → investigate

## Response protocol
- If fixable (restart service, clear cache) → fix first, then report
- If not fixable → alert immediately with diagnosis
```

### Template D: Content & Social Media

For teams focused on content performance and social engagement.

```markdown
## Every heartbeat (rotate checks):
1. Social media notifications — new DMs, comments needing reply
2. Content performance — any post going viral? Any post underperforming?
3. Competitor activity — new posts from tracked competitors
4. Content calendar — anything due to publish in next 4 hours?

## Engagement thresholds
- Post doing 3x average impressions → alert "going viral, consider boosting"
- Post at <20% average engagement after 4h → alert "underperforming"
- Negative comment or review → alert immediately

## Competitor tracking
- Track: @competitor1, @competitor2, @competitor3
- Alert if they: launch new product, change pricing, run campaign

## Content calendar
- 4h before scheduled post → verify draft is ready
- 1h before → final review reminder
- Post-publish → check engagement after 2h
```

### Template E: Minimal (Just the Essentials)

For teams that want heartbeats active but ultra-lean.

```markdown
# Only check the absolute essentials.
# Everything else goes through cron or manual request.

## Check:
- [ ] Anything urgent in the last hour that I should know about?

## Alert only if:
- Production is down
- Security vulnerability detected
- Someone mentioned me by name in a channel I'm not watching
```

---

## Heartbeat State Tracking

Create `memory/heartbeat-state.json` to track when things were last checked:

```json
{
  "lastChecks": {
    "github": null,
    "email": null,
    "calendar": null,
    "uptime": null,
    "social": null,
    "costs": null
  },
  "lastAlertSent": null,
  "consecutiveQuiet": 0
}
```

> Your agent updates this file after each heartbeat. It prevents duplicate checks
> and helps rotate through different monitoring tasks efficiently.

---

*Start with everything commented out. Enable checks one at a time as you discover
what's actually useful for your workflow. Less is more — every check costs tokens.*
