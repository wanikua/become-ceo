# Cron Recipes — Ready-to-Use Scheduled Task Templates

Copy these recipes and customize for your team. Each includes the cron command, expected agent behavior, output destination, and integration notes.

## Quick Index

| # | Recipe | Agent | Schedule |
|---|--------|-------|----------|
| 1 | [Daily Standup Report](#-1-daily-standup-report) | Chief of Staff | Daily 9 AM |
| 2 | [Weekly Cost Review](#-2-weekly-cost-review) | Finance | Friday 9 AM |
| 3 | [Monthly Executive Summary](#-3-monthly-executive-summary) | Chief of Staff | 1st of month |
| 4 | [Hourly Issue Triage](#-4-hourly-issue-triage) | Engineering | Every hour |
| 5 | [Nightly Staging Deploy](#-5-nightly-staging-deploy) | DevOps | Daily 2 AM |
| 6 | [Weekly Security Scan](#-6-weekly-security-scan) | DevOps | Sunday 3 AM |
| 7 | [Visual Regression Check](#-7-visual-regression-check) | DevOps | Daily 6 AM |
| 8 | [Multi-Site Uptime Monitor](#-8-multi-site-uptime-monitor) | DevOps | Every 6 hours |
| 9 | [Notion Backup to Workspace](#-9-notion-backup-to-workspace) | Chief of Staff | Sunday 4 AM |
| 10 | [Sprint Velocity Tracker](#-10-sprint-velocity-tracker) | Management | Friday 5 PM |
| 11 | [Content Performance Review](#-11-content-performance-review) | Marketing | Monday 10 AM |
| 12 | [Workspace Cleanup](#-12-workspace-cleanup) | Chief of Staff | Sunday 5 AM |
| 13 | [Event-Driven Deploy Smoke Test](#-13-event-driven-deploy-smoke-test) | DevOps | On wake event |
| 14 | [Cron Health Audit](#-14-cron-health-audit-meta-cron) | Chief of Staff | Daily 8:45 AM |
| 15 | [Adaptive Cost Monitoring](#-15-adaptive-cost-monitoring) | Finance | Every 4 hours |
| 16 | [Quarterly OKR Review](#-16-quarterly-okr-review) | Management | Quarterly |
| 17 | [Incident Auto-Escalation](#-17-incident-auto-escalation) | DevOps | On wake event |
| 18 | [Cross-Department Audit](#-18-cross-department-audit) | Chief of Staff | Biweekly |

---

## 📋 1. Daily Standup Report

**Agent:** Chief of Staff  
**Schedule:** Every day at 9:00 AM  
**Output:** Discord `#standup` + Notion Daily Reports

```bash
clawdbot cron add \
  --agent main \
  --cron "0 9 * * *" --tz "America/New_York" \
  --text "Run daily standup. Ask each department for status. Post a summary to #standup. Archive to Notion Daily Reports database."
```

**Expected output:**
```
Chief of Staff: 📋 Daily Standup — March 7, 2026

Engineering: Auth API v2 shipped. Starting payment gateway.
Finance: Monthly spend at $312. Under budget by 15%.
Marketing: Blog post published. 2.4k views in first hour.
DevOps: All systems green. SSL certs renewed.
Management: Sprint 14 on track. 3 issues remain.
Legal: ToS update reviewed. No action needed.

→ Archived to Notion ✅
```

**Integration notes:**
- Chief of Staff spawns sub-agents to collect each department's status
- Results aggregated into a single summary
- Notion page created with structured fields: Date, Summary, per-department status

---

## 💰 2. Weekly Cost Review

**Agent:** Finance  
**Schedule:** Every Monday at 9:00 AM  
**Output:** Discord `#billing-alerts` + Notion Financial Records

```bash
clawdbot cron add \
  --agent finance \
  --cron "0 9 * * 1" --tz "America/New_York" \
  --text "Run weekly cost review. Check LLM API spend, compute costs, and third-party service bills. Compare to last week. Post summary to #billing-alerts. Archive to Notion Financial Records."
```

**Expected output:**
```
Finance: 💰 Weekly Cost Review — Week of March 3

LLM API:      $47.23 (↓12% from last week)
Compute:      $18.40 (flat)
Third-party:  $5.99 (Stripe processing)
────────────
Total:        $71.62

📊 Trend: Costs down 8% WoW. Strong model usage dropped
   after Engineering switched code review to fast model.

Recommendations:
  1. Keep current model allocation — savings are significant
  2. Consider caching repeated browser scrapes to reduce API calls

→ Archived to Notion ✅
```

---

## 📊 3. Monthly Executive Summary

**Agent:** Management  
**Schedule:** 1st of every month at 10:00 AM  
**Output:** Discord `#monthly-reports` + Notion Monthly Reports

```bash
clawdbot cron add \
  --agent management \
  --cron "0 10 1 * *" --tz "America/New_York" \
  --text "Generate monthly executive summary. Pull data from all Notion databases: Daily Reports (highlights), Financial Records (monthly totals), Engineering Wiki (major ADRs), Marketing Hub (content performance), Incident Log (uptime stats). Create comprehensive report. Post to #monthly-reports. Archive to Notion Monthly Reports."
```

**Integration notes:**
- Management queries all 6+ Notion databases
- Cross-references GitHub metrics: PRs merged, issues closed, CI pass rate
- Generates trend charts description (text-based) for each KPI
- Archives to Notion with linked relations to source records

---

## 🔍 4. Hourly Issue Triage

**Agent:** Engineering  
**Schedule:** Every hour  
**Output:** Discord `#bugs` (only when new issues found)

```bash
clawdbot cron add \
  --agent engineering \
  --cron "0 * * * *" \
  --text "Check GitHub for new untriaged issues across all repos (gh issue list --state open --label '' --limit 10). Label, assign priority, and post a summary to #bugs. Skip if no new issues."
```

**Integration notes:**
- Only posts to Discord when new issues are found (avoids noise)
- Applies labels: `bug`, `feature`, `documentation`, `priority:high/medium/low`
- Auto-assigns based on labels: `infra` → DevOps, `billing` → Finance

---

## 🚀 5. Nightly Staging Deploy

**Agent:** DevOps  
**Schedule:** Every night at midnight  
**Output:** Discord `#deployments`

```bash
clawdbot cron add \
  --agent devops \
  --cron "0 0 * * *" --tz "America/New_York" \
  --text "Deploy main branch to staging. Check CI status first — if red, skip and alert #deployments. If green, trigger deploy, run smoke tests, report results."
```

**Safety notes:**
- Always checks CI status before deploying
- Never deploys to production automatically (requires human approval)
- Posts deploy hash, duration, and smoke test results

---

## 🔒 6. Weekly Security Scan

**Agent:** DevOps  
**Schedule:** Every Monday at 8:00 AM  
**Output:** Discord `#security` + Notion Incident Log (if findings)

```bash
clawdbot cron add \
  --agent devops \
  --cron "0 8 * * 1" --tz "America/New_York" \
  --text "Run weekly security audit across all repos. Check: dependency vulnerabilities (gh api repos/{owner}/{repo}/dependabot/alerts), secret scanning alerts, license compliance. Post summary to #security. Log critical findings to Notion Incident Log."
```

---

## 📸 7. Visual Regression Check

**Agent:** DevOps  
**Schedule:** Every day at 6:00 AM  
**Output:** Discord `#deployments` (only on failures)

```bash
clawdbot cron add \
  --agent devops \
  --cron "0 6 * * *" --tz "America/New_York" \
  --text "Screenshot production pages (homepage, dashboard, pricing) across mobile/tablet/desktop viewports. Compare against yesterday's screenshots. Report any visual regressions to #deployments. If everything looks good, stay silent."
```

---

## 🌐 8. Multi-Site Uptime Monitor

**Agent:** DevOps  
**Schedule:** Every 6 hours  
**Output:** Discord `#deployments` (only on failures)

```bash
clawdbot cron add \
  --agent devops \
  --cron "0 */6 * * *" \
  --text "Health check all production endpoints: main app, API, docs site, status page. Check HTTP status, response time, SSL expiry. Only alert #deployments if something is down or SSL expires within 7 days."
```

**Integration notes:**
- Silent when everything is healthy (no noise)
- Escalates to Engineering if API returns errors
- Logs uptime stats to Notion for monthly SLA reporting

---

## 💾 9. Notion Backup to Workspace

**Agent:** Chief of Staff  
**Schedule:** Every Sunday at 3:00 AM  
**Output:** Local files in `memory/notion-backup/`

```bash
clawdbot cron add \
  --agent main \
  --cron "0 3 * * 0" --tz "America/New_York" \
  --text "Export critical Notion databases to local workspace for backup. Query Daily Reports (last 7 days), Financial Records (last 30 days), Engineering Wiki (all), Incident Log (last 30 days). Save as markdown to memory/notion-backup/ with timestamps."
```

---

## 📈 10. Sprint Velocity Tracker

**Agent:** Management  
**Schedule:** Every Friday at 4:00 PM  
**Output:** Discord `#general` + Notion Project Archives

```bash
clawdbot cron add \
  --agent management \
  --cron "0 16 * * 5" --tz "America/New_York" \
  --text "Calculate sprint velocity: count issues closed this week, PRs merged, story points completed. Compare to last 4 sprints. Post velocity chart (text-based) and forecast for next sprint. Archive to Notion Project Archives."
```

---

## 📰 11. Content Performance Review

**Agent:** Marketing  
**Schedule:** Every Wednesday at 10:00 AM  
**Output:** Discord `#marketing` + Notion Marketing Hub

```bash
clawdbot cron add \
  --agent marketing \
  --cron "0 10 * * 3" --tz "America/New_York" \
  --text "Review content performance. Use browser to check analytics for blog posts, social media engagement, and landing page conversion rates. Compare to last week. Identify top 3 and bottom 3 performers. Post insights to #marketing. Update Notion Marketing Hub with metrics."
```

---

## 🧹 12. Workspace Cleanup

**Agent:** Chief of Staff  
**Schedule:** 1st of every month at 2:00 AM  
**Output:** Local workspace cleanup

```bash
clawdbot cron add \
  --agent main \
  --cron "0 2 1 * *" --tz "America/New_York" \
  --text "Workspace maintenance: clean up temp files older than 30 days, compress old log files, check disk usage, verify all cron jobs are still relevant. Post maintenance summary to #general."
```

---

## 📜 Cron Expression Quick Reference

| Expression | Meaning |
|---|---|
| `0 9 * * *` | Every day at 9:00 AM |
| `0 9 * * 1` | Every Monday at 9:00 AM |
| `0 */6 * * *` | Every 6 hours |
| `0 * * * *` | Every hour |
| `*/30 * * * *` | Every 30 minutes |
| `0 0 * * *` | Every midnight |
| `0 10 1 * *` | 1st of every month at 10:00 AM |
| `0 16 * * 5` | Every Friday at 4:00 PM |
| `0 3 * * 0` | Every Sunday at 3:00 AM |
| `0 9 * * 1-5` | Weekdays at 9:00 AM |

---

## 🔧 Management Tips

**List all active cron jobs:**
```bash
clawdbot cron list
```

**Disable a job temporarily:**
```bash
clawdbot cron disable <job-id>
```

**Run a job immediately (testing):**
```bash
clawdbot cron run <job-id>
```

**Update a job's schedule:**
```bash
clawdbot cron update <job-id> --cron "0 10 * * *"
```

**View job run history:**
```bash
clawdbot cron runs <job-id>
```

---

## 🔔 13. Event-Driven Deploy Smoke Test

**Agent:** DevOps  
**Schedule:** Event-driven (no fixed schedule)  
**Trigger:** `clawdbot cron wake <job-id>` from CI webhook  
**Output:** Discord `#deployments`

```bash
clawdbot cron add \
  --agent devops \
  --text "Production deploy detected. Run smoke tests: check all 
         critical endpoints (homepage, API /health, dashboard login).
         If any test fails, post failure details to #deployments and
         recommend rollback. If all pass, confirm deploy success."
```

**Integration notes:**
- No `--cron` flag — this job only runs when woken by an event
- Wire your CI/CD pipeline to call `clawdbot cron wake <job-id>` after deploy
- Combines with the nightly staging deploy for full coverage

---

## 🩺 14. Cron Health Audit (Meta-Cron)

**Agent:** Chief of Staff  
**Schedule:** Every day at 8:00 AM  
**Output:** Discord `#general` (only on failures)

```bash
clawdbot cron add \
  --agent main \
  --cron "0 8 * * *" --tz "America/New_York" \
  --text "Audit all cron jobs. Run 'clawdbot cron list' and check 
         'clawdbot cron runs <id>' for each. Report: jobs that failed 
         in the last 24h, jobs that didn't run when expected, jobs 
         taking abnormally long. If all healthy, stay silent."
```

**Integration notes:**
- This is the "who watches the watchers" job
- Should run before the daily standup so failures appear in the morning
- Detects stale gate files, disabled jobs, and silent failures

---

## 📉 15. Adaptive Cost Monitoring

**Agent:** Finance  
**Schedule:** Every 4 hours (self-adjusting)  
**Output:** Discord `#billing-alerts` (only when thresholds exceeded)

```bash
clawdbot cron add \
  --agent finance \
  --cron "0 */4 * * *" \
  --text "Check LLM API spend. If over threshold, alert #billing-alerts.
         If spend has been under 50% of threshold for 3 consecutive 
         checks, update this cron to every 8 hours. If spend exceeds 
         75% of threshold, increase to every 2 hours. Log any schedule 
         changes to memory/cron-adjustments.log."
```

**Integration notes:**
- Agent self-adjusts frequency based on spend patterns
- Saves costs during quiet periods, increases vigilance during spikes
- Logs all schedule changes for auditing

---

## 📋 16. Quarterly OKR Review

**Agent:** Management  
**Schedule:** 1st of Jan, Apr, Jul, Oct at 10:00 AM  
**Output:** Discord `#general` + Notion Monthly Reports

```bash
clawdbot cron add \
  --agent management \
  --model "$LLM_PROVIDER/$MODEL_STRONG" \
  --cron "0 10 1 1,4,7,10 *" --tz "America/New_York" \
  --text "Quarterly OKR review. Query Notion for:
         - Last 3 Monthly Reports (trend data)
         - Financial Records (quarterly totals)
         - Project Archives (completed vs planned)
         - Sprint Velocity (average over quarter)
         Grade each OKR (On Track / At Risk / Missed).
         Propose next quarter's OKRs based on trends.
         Post executive summary to #general.
         Archive full report to Notion Monthly Reports 
         with tag 'Quarterly Review'."
```

**Integration notes:**
- Uses strong model for deep analysis across multiple Notion databases
- Cross-references GitHub metrics (PRs merged, issues closed per quarter)
- Generates quarter-over-quarter comparison trends
- Proposes realistic OKRs based on actual team velocity data

---

## 🚨 17. Incident Auto-Escalation

**Agent:** DevOps  
**Schedule:** Event-driven (triggered by uptime monitor failure)  
**Trigger:** Chain from uptime monitor or `clawdbot cron wake <job-id>`  
**Output:** Discord `#security` + Notion Incident Log

```bash
clawdbot cron add \
  --agent devops \
  --text "Incident detected. Execute escalation protocol:
         1. Collect diagnostics: which endpoints are down, since when,
            error codes, last successful deploy hash
         2. Post initial incident report to #security with severity 
            (P1/P2/P3) based on: P1=full outage, P2=degraded, P3=single endpoint
         3. If P1: spawn Engineering sub-agent for immediate diagnosis,
            spawn Finance sub-agent to estimate revenue impact
         4. If P1 or P2: create GitHub Issue with label 'incident' 
            and assign to Engineering
         5. Create Notion Incident Log entry with: timestamp, severity,
            affected services, initial diagnostics, assigned team
         6. If not resolved within 30 minutes, re-alert with update"
```

**Integration notes:**
- Event-driven: no fixed schedule, triggered by other monitoring cron jobs
- P1 incidents spawn parallel sub-agents (Engineering + Finance simultaneously)
- Creates artifacts in both GitHub (actionable issue) and Notion (historical record)
- Follow-up alert ensures incidents don't silently stall

---

## 📊 18. Cross-Department Audit

**Agent:** Chief of Staff  
**Schedule:** Every 2 weeks, Wednesday at 2:00 PM  
**Output:** Discord `#general` + Notion Daily Reports

```bash
clawdbot cron add \
  --agent main \
  --cron "0 14 1,15 * *" --tz "America/New_York" \
  --text "Run cross-department audit. Spawn sub-agents to check:
         - Engineering: open PR count, stale branches, CI pass rate
         - Finance: budget burn rate, forecast vs actual
         - Marketing: content pipeline status, engagement trends
         - DevOps: infrastructure health, pending security patches
         - Legal: expiring contracts, compliance checklist
         - Management: project milestone status, blocked items
         Cross-reference findings: flag misalignments (e.g., Engineering 
         velocity dropping while Marketing plans a big launch).
         Post audit summary to #general with action items.
         Archive to Notion."
```

**Integration notes:**
- Biweekly cadence balances thoroughness with cost
- Cross-references data across departments to catch misalignments
- Produces actionable recommendations, not just status updates
- Chief of Staff is the right agent: has delegation permissions to all departments

---

## 🏗️ Building Your Own Recipes

When designing a new cron job, follow this structure:

1. **Who** — which agent should handle it?
2. **When** — what schedule makes sense? (consider timezone)
3. **What** — describe the task in plain English (be specific)
4. **Where** — where should the output go? (Discord channel, Notion database, local file)
5. **When to stay silent** — define "no news is good news" conditions to avoid noise

**Template:**
```bash
clawdbot cron add \
  --agent <agent-id> \
  --cron "<cron-expression>" --tz "<timezone>" \
  --text "<plain English task description with output destination>"
```

**Best practices:**
- Use `--tz` to ensure consistent timing regardless of server timezone
- Include "only alert if..." conditions to reduce notification noise
- Specify output format: Discord channel, Notion database, or local file
- Set appropriate agent: cheap tasks → fast model agents, complex analysis → strong model agents
- Test with `clawdbot cron run <job-id>` before relying on the schedule
