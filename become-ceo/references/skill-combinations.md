# Skill Combination Recipes

Ready-to-use multi-skill workflows for your AI executive team. Each recipe combines 2+ skills for compound value.

## Quick Index

| # | Recipe | Agent | Skills Combined |
|---|--------|-------|----------------|
| 1 | [Morning Brief](#1-the-morning-brief) | Chief of Staff | email + calendar + weather + RSS + HN |
| 2 | [Full Monitoring Stack](#2-the-full-monitoring-stack) | DevOps | system-monitor + docker + screenshot-diff |
| 3 | [Content Pipeline](#3-the-content-pipeline) | Marketing | RSS + HN + ai-image + automation + slack |
| 4 | [Executive Dashboard](#4-the-executive-dashboard) | Chief of Staff | email + calendar + system-monitor + docker |
| 5 | [Incident Response Stack](#5-the-incident-response-stack) | DevOps + Engineering | system-monitor + docker + screenshot + slack |
| 6 | [Competitive Intelligence](#6-the-competitive-intelligence-stack) | Marketing + Engineering | RSS + HN + screenshot-diff + automation |
| 7 | [Onboarding Accelerator](#7-the-onboarding-accelerator) | Chief of Staff + Mgmt | email + calendar + automation + slack |
| 8 | [Cost Optimization](#8-the-cost-optimization-stack) | Finance + DevOps | system-monitor + docker + automation |

---

## 1. The Morning Brief

**Skills:** `email-daily-summary` + `gcalcli-calendar` + `weather` + `rss-feeds` + `hacker-news`  
**Agent:** Chief of Staff  
**Schedule:** `0 8 * * * (daily at 8 AM)`

```
Cron text:
  Morning briefing — combine all sources:
  1. Weather forecast and commute advisory
  2. Today's calendar with conflict alerts
  3. Email triage (urgent → actionable → noise)
  4. RSS feed highlights from overnight
  5. Top 3 relevant Hacker News stories
  Format as one clean digest. Post to CEO DM.
```

**Output:** Single unified morning digest covering weather, schedule, email, news.

---

## 2. The Full Monitoring Stack

**Skills:** `system-resource-monitor` + `docker-essentials` + `screenshot-diff`  
**Agent:** DevOps  
**Schedule:** `0 */2 * * * (every 2 hours)`

```
Cron text:
  Full monitoring sweep:
  1. System resources (CPU/mem/disk/network)
  2. Docker container health and resource usage
  3. Visual regression on production URLs
  Alert ONLY on: container unhealthy, resource threshold breach,
  or visual diff > 5%. Silent when healthy.
```

**Output:** Alert only when something breaks. Zero noise when healthy.

---

## 3. The Content Pipeline

**Skills:** `rss-feeds` + `hacker-news` + `ai-image-gen` + `automation-workflows` + `slack-bridge`  
**Agent:** Marketing (with sub-agents)  
**Schedule:** Weekly cycle (Monday research → Friday publish)

```
Monday cron (research):
  Scan RSS feeds and Hacker News for trending topics relevant to 
  our industry. Create a shortlist of 5 potential blog topics with 
  supporting links. Post to #marketing for CEO review.

Thursday cron (visual):
  Generate a hero image for the approved blog post topic.
  Style: modern, professional, matches brand colors.
  Post 3 options to #marketing for selection.

Friday cron (distribute):
  Publish the final blog post. Share to Discord #announcements 
  and Slack community channel. Track initial engagement after 2h.
```

**Output:** End-to-end content from research to distribution.

---

## 4. The Executive Dashboard

**Skills:** `email-daily-summary` + `gcalcli-calendar` + `system-resource-monitor` + `docker-essentials`  
**Agent:** Chief of Staff  
**Trigger:** On-demand (`@Chief of Staff full status`)

```
Combine all data sources into a single executive summary:
- Email: count by urgency, oldest unanswered
- Calendar: remaining events today + tomorrow preview
- Systems: container health, resource usage, uptime
- GitHub: open PRs, CI status, recent merges
- Cloud spend: MTD vs budget
Flag anything that needs human attention.
```

**Output:** Complete business snapshot in one message.

---

## 5. The Incident Response Stack

**Skills:** `system-resource-monitor` + `docker-essentials` + `screenshot-diff` + `slack-bridge`  
**Agent:** DevOps + Engineering (escalation)  
**Trigger:** Monitoring cron detects anomaly

```
When alert fires:
1. DevOps captures system state (resources, containers, screenshots)
2. DevOps runs initial diagnostics (logs, recent deploys, network)
3. If code-related → spawn Engineering sub-agent for investigation
4. Post incident timeline to Discord #incidents
5. Bridge alert to Slack #ops if external team needs visibility
6. After resolution → generate post-mortem, archive to Notion
```

**Output:** Automated triage with cross-team coordination.

---

## 6. The Competitive Intelligence Stack

**Skills:** `rss-feeds` + `hacker-news` + `screenshot-diff` + `automation-workflows`  
**Agent:** Marketing + Engineering  
**Schedule:** `0 10 * * 1 (weekly, Monday 10 AM)`

```
Marketing cron:
  Competitive analysis sweep:
  1. Check RSS feeds from competitor blogs for new posts
  2. Search Hacker News for competitor mentions
  3. Screenshot competitor pricing/feature pages
  4. Compare screenshots to last week's baseline for changes
  Summarize: new features launched, pricing changes, content themes.
  Post to #marketing with Notion archive.
```

**Output:** Weekly competitive intelligence report with visual change tracking.

---

## 7. The Onboarding Accelerator

**Skills:** `email-daily-summary` + `gcalcli-calendar` + `automation-workflows` + `slack-bridge`  
**Agent:** Chief of Staff + Management  
**Trigger:** New team member event

```
Day 1:
  1. Send welcome email with credentials and links
  2. Create calendar events: onboarding sessions, 1-on-1s
  3. Post intro to Discord #general and Slack #team
  4. Set up workspace access and tool permissions

Week 1 (daily check):
  Monitor new hire's first week — check calendar attendance,
  Slack activity, and any blocked requests. Surface issues to 
  Management. Post daily onboarding status to #management.

Day 30:
  Send 30-day check-in survey. Compile onboarding metrics
  (time to first commit, meetings attended, tools activated).
  Archive to Notion Project Archives.
```

**Output:** Structured onboarding with zero manual coordination.

---

## 8. The Cost Optimization Stack

**Skills:** `system-resource-monitor` + `docker-essentials` + `automation-workflows`  
**Agent:** Finance + DevOps  
**Schedule:** `0 9 * * 5 (weekly, Friday 9 AM)`

```
Finance cron:
  Weekly cost optimization review:
  1. Pull system resource utilization averages (7-day)
  2. Map Docker container resource allocation vs actual usage
  3. Identify over-provisioned resources (< 20% avg utilization)
  4. Calculate potential savings from right-sizing
  5. Compare cloud bill to resource metrics
  Post recommendations to #finance with cost projections.
  Archive to Notion Financial Records.
```

**Output:** Data-driven infrastructure cost recommendations.

---

## Combination Principles

1. **Morning = aggregation.** Combine all "read" skills into one digest.
2. **Monitoring = silent unless broken.** Stack monitoring skills but alert only on thresholds.
3. **Content = pipeline.** Chain skills sequentially (research → create → review → publish).
4. **Incidents = escalation.** Layer skills with severity-based triggers.
5. **Analysis = cross-reference.** Combine data from different sources for insights no single skill provides.

> **Rule of thumb:** If you're running 3+ cron jobs that fire at the same time, combine them into one. Fewer API calls, richer context, better output.
