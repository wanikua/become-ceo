# Notion Database Templates

Ready-to-use database schemas for your AI company. Copy these property configurations when creating Notion databases.

---

## 📅 Daily Reports

| Property | Type | Options / Notes |
|----------|------|-----------------|
| Title | Title | Auto-format: `YYYY-MM-DD Daily Report` |
| Date | Date | Calendar view key |
| Status | Select | Draft, Published |
| Departments | Multi-select | Engineering, Finance, Marketing, DevOps, Management, Legal |
| Highlights | Rich text | Key achievements — bullet list |
| Blockers | Rich text | Issues needing attention |
| API Cost | Number (USD) | Total spend for the day |
| Action Items | Rich text | Tomorrow's priorities |

**Cron trigger:** Chief of Staff, daily at 10 PM

---

## 📊 Weekly Reports

| Property | Type | Options / Notes |
|----------|------|-----------------|
| Title | Title | Auto-format: `Week N — YYYY` |
| Week Start | Date | Monday of the week |
| Week End | Date | Sunday of the week |
| Status | Select | Draft, Published |
| Summary | Rich text | Executive summary (3-5 sentences) |
| Engineering Highlights | Rich text | PRs merged, features shipped |
| Financial Summary | Rich text | Spend vs budget, trends |
| Marketing Metrics | Rich text | Content published, engagement |
| Infrastructure Status | Rich text | Uptime, incidents, changes |
| Total Cost | Number (USD) | Week's total API + infra spend |
| vs Last Week | Select | Up, Down, Flat |

**Cron trigger:** Chief of Staff, every Monday at 9 AM

---

## 🌙 Monthly Reports

| Property | Type | Options / Notes |
|----------|------|-----------------|
| Title | Title | Auto-format: `Month YYYY Review` |
| Period | Date | First day of month |
| Executive Summary | Rich text | Month in 5 sentences |
| Goals Met | Multi-select | List of completed objectives |
| Goals Missed | Multi-select | List of missed objectives |
| Total Spend | Number (USD) | Month total |
| Budget Variance | Number (%) | Over/under budget |
| Key Decisions | Rich text | ADRs, policy changes, pivots |
| Next Month Priorities | Rich text | Top 3-5 goals |

**Cron trigger:** Chief of Staff, 1st of each month at 9 AM

---

## 💰 Financial Records

| Property | Type | Options / Notes |
|----------|------|-----------------|
| Title | Title | Period label (e.g., `March 2026`) |
| Period | Date | Date range |
| Total Spend | Number (USD) | Total cost |
| Strong Model Cost | Number (USD) | Heavy model usage |
| Fast Model Cost | Number (USD) | Light model usage |
| Infrastructure Cost | Number (USD) | Server, DNS, etc. |
| Trend | Select | Up, Down, Flat |
| Top Spender | Select | Which agent/task consumed most |
| Anomalies | Rich text | Unusual spikes or drops |
| Recommendations | Rich text | Cost-saving suggestions |

**Owner:** Finance agent

---

## 🖥️ Engineering Wiki (ADRs)

Architecture Decision Records — capture every technical choice.

| Property | Type | Options / Notes |
|----------|------|-----------------|
| Title | Title | Auto-format: `ADR-NNN: Decision Title` |
| Date | Date | Decision date |
| Status | Select | Proposed, Accepted, Deprecated, Superseded |
| Category | Select | Architecture, Database, API, Security, Performance, Tooling |
| Context | Rich text | Why this decision was needed |
| Decision | Rich text | What was decided |
| Alternatives | Rich text | Other options considered |
| Consequences | Rich text | Trade-offs and implications |
| Related PR | URL | Link to implementation PR |
| Superseded By | Relation | Points to newer ADR if deprecated |

**Owner:** Engineering agent

---

## 📢 Marketing Hub

| Property | Type | Options / Notes |
|----------|------|-----------------|
| Title | Title | Content piece title |
| Type | Select | Blog Post, Social Post, Newsletter, Video Script, Case Study |
| Status | Select | Idea, Drafting, Review, Published, Archived |
| Platform | Multi-select | Blog, Twitter/X, LinkedIn, YouTube, Newsletter |
| Publish Date | Date | Scheduled or actual |
| Author | Select | Marketing, Guest, CEO |
| SEO Keywords | Rich text | Target keywords |
| Performance | Rich text | Views, clicks, engagement (filled post-publish) |
| Link | URL | Published URL |

**Owner:** Marketing agent

---

## 🗂️ Project Archives

| Property | Type | Options / Notes |
|----------|------|-----------------|
| Title | Title | Project name |
| Status | Select | Planning, Active, Paused, Completed, Cancelled |
| Owner | Select | Engineering, Marketing, DevOps, etc. |
| Start Date | Date | Project kickoff |
| End Date | Date | Completion or target date |
| Objective | Rich text | What this project achieves |
| Key Results | Rich text | Measurable outcomes |
| Decision Log | Rich text | Major decisions made |
| Lessons Learned | Rich text | Retrospective notes |
| Repository | URL | GitHub repo link |

**Owner:** Management agent

---

## 🔒 Incident Log

| Property | Type | Options / Notes |
|----------|------|-----------------|
| Title | Title | Auto-format: `INC-NNN: Brief description` |
| Date | Date | Incident start time |
| Severity | Select | P0 (Critical), P1 (Major), P2 (Minor), P3 (Low) |
| Status | Select | Investigating, Mitigating, Resolved, Post-mortem Done |
| Affected Systems | Multi-select | API, Database, Frontend, Auth, Payments |
| Root Cause | Rich text | What went wrong |
| Resolution | Rich text | How it was fixed |
| Duration | Number (minutes) | Time to resolution |
| Action Items | Rich text | Preventive measures |
| Post-mortem Link | URL | Detailed write-up |

**Owner:** DevOps agent

---

## Tips

- **Create views in Notion UI** — Calendar view for reports, Board view for projects, Table for everything else
- **Use relations** — link Daily Reports to their Weekly Report, link ADRs to Projects
- **Template buttons** — create Notion template buttons so agents fill in consistent formats
- **Filters** — set up filtered views per department so each agent sees only their data by default
