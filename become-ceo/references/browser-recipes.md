# Browser Automation Recipes

Ready-to-use workflow templates for common browser automation scenarios. These can be used as-is or adapted for your specific needs.

## Quick Index

| # | Recipe | Agent | Use Case |
|---|--------|-------|----------|
| 1 | [SEO Audit](#-seo-audit) | Marketing / Engineering | Weekly site health |
| 2 | [Price Monitoring](#-price-monitoring) | Marketing | Competitor tracking |
| 3 | [Content Publishing Pipeline](#-content-publishing-pipeline) | Marketing | Multi-platform posting |
| 4 | [Report Extraction](#-report-extraction) | Finance | Dashboard data export |
| 5 | [Multi-Site Health Check](#-multi-site-health-check) | DevOps | Uptime verification |
| 6 | [Social Media Scheduler](#-social-media-scheduler) | Marketing | Cross-platform scheduling |
| 7 | [Accessibility Audit](#-accessibility-audit) | Engineering | WCAG compliance |
| 8 | [PDF Report Generation](#-pdf-report-generation) | Finance | Billing & analytics export |

---

## 🔍 SEO Audit

**Agent:** Marketing or Engineering  
**Frequency:** Weekly (via cron) or on-demand  
**Description:** Crawl your site's key pages and check SEO health metrics.

### What It Checks
- Page title and meta description (length, presence, uniqueness)
- H1/H2 heading structure (missing, duplicate, hierarchy)
- Image alt text (missing or generic)
- Broken links (404s, redirects)
- Open Graph / Twitter Card meta tags
- Canonical URL correctness
- Mobile viewport meta tag

### Cron Setup
```bash
openclaw cron add \
  --name "seo-audit-weekly" --agent marketing \
  --cron "0 9 * * 1" \
  --message "Run a full SEO audit on our website. Check the homepage, pricing, docs landing, blog index, and about page. For each: verify title tag (50-60 chars), meta description (150-160 chars), H1 presence, image alt text, and Open Graph tags. Report issues only — skip pages that pass all checks. Save the full report to Marketing Hub on Notion." \
  --session isolated
```

### Expected Output
```
📋 SEO Audit — example.com (March 3, 2026)

✅ Homepage — all checks pass
⚠️ Pricing Page:
   • Meta description too long (178 chars, recommended: 150-160)
   • 2 images missing alt text
⚠️ Blog Index:
   • Missing Open Graph image
   • H1 tag contains generic text ("Blog")
✅ Docs Landing — all checks pass
✅ About Page — all checks pass

2 pages need attention. Full report → Notion: Marketing Hub
```

---

## 💰 Price Monitoring

**Agent:** Marketing  
**Frequency:** Daily (via cron)  
**Description:** Track competitor pricing and alert on changes.

### Workflow
1. Navigate to each competitor's pricing page
2. Extract plan names, prices, and feature lists
3. Compare against last known values (stored in Notion)
4. Alert if any price changed by >5% or features were added/removed

### Cron Setup
```bash
openclaw cron add \
  --name "price-monitor" --agent marketing \
  --cron "0 8 * * *" \
  --message "Check competitor pricing pages: [competitor-a.com/pricing], [competitor-b.com/pricing], [competitor-c.com/pricing]. Extract all plan names, prices, and key features. Compare against the last entry in the Competitive Pricing table on Notion. If any price changed or features were added/removed, alert in #marketing with a comparison table. Save today's snapshot to Notion regardless." \
  --session isolated
```

### Notion Database Schema — Competitive Pricing
| Property | Type | Description |
|----------|------|-------------|
| Date | Date | Snapshot date |
| Competitor | Select | Company name |
| Plan | Text | Plan tier name |
| Price | Number | Monthly price (USD) |
| Features | Text | Key feature list |
| Changed | Checkbox | Whether this entry differs from previous |

---

## 📝 Content Publishing Pipeline

**Agent:** Marketing (with Chief of Staff coordination)  
**Frequency:** On-demand  
**Description:** Publish content across multiple platforms from a single command.

### Workflow
```
CEO: "Publish our product update announcement"
         ↓
Chief of Staff orchestrates:
         ↓
┌──────────────────────────────────────┐
│  1. Marketing: draft post variants   │
│     • LinkedIn (professional tone)   │
│     • Twitter/X (concise, punchy)    │
│     • Blog (detailed, with images)   │
│                                      │
│  2. CEO reviews drafts in Discord    │
│                                      │
│  3. Marketing: publish via browser   │
│     • LinkedIn → browser post        │
│     • Twitter/X → browser post       │
│     • Blog → CMS browser publish     │
│                                      │
│  4. Log all URLs to Notion           │
└──────────────────────────────────────┘
```

### Post-Publish Verification
```
Marketing:       Published to 3 platforms. Verifying...

                 ✅ LinkedIn — post live, 0 errors
                    → linkedin.com/posts/...
                 ✅ Twitter/X — tweet live, 0 errors
                    → x.com/ourcompany/status/...
                 ✅ Blog — article live, images loading
                    → blog.example.com/product-update-v2

                 All posts verified and logged to Notion.
```

---

## 📊 Report Extraction

**Agent:** Finance or Marketing  
**Frequency:** Weekly or monthly (via cron)  
**Description:** Extract data from web dashboards that don't offer API exports.

### Workflow
1. Navigate to the dashboard (using `chrome` profile if authenticated)
2. Set the date range
3. Extract key metrics via snapshot
4. Format into a structured report
5. Archive to Notion

### Cron Setup
```bash
openclaw cron add \
  --name "analytics-extract" --agent marketing \
  --cron "0 9 * * 1" \
  --message "Using the Chrome browser profile, navigate to our analytics dashboard. Set date range to last 7 days. Extract: total visitors, page views, bounce rate, top 5 pages, top 5 referrers, and conversion rate. Format as a weekly traffic report and save to Marketing Hub on Notion. Post a summary to #marketing." \
  --session isolated
```

### Multi-Dashboard Extraction
```
You:             @Finance pull reports from all our SaaS dashboards

Finance:         Extracting from 4 dashboards...

                 1. Hosting — $47.20 this month (within budget)
                 2. Email service — $12.00, 4,200 emails sent
                 3. CDN — $8.50, 120GB transferred
                 4. Monitoring — $0 (free tier, 89% quota used)

                 Total SaaS spend: $67.70 / $100 budget
                 → Logged to Financial Records on Notion
```

---

## 🔄 Multi-Site Health Check

**Agent:** DevOps  
**Frequency:** Every 6 hours (via cron)  
**Description:** Batch-check multiple websites and status pages.

### Cron Setup
```bash
openclaw cron add \
  --name "site-health-check" --agent devops \
  --cron "0 */6 * * *" \
  --message "Check these URLs and verify they load correctly: [app.example.com] (expect login page), [api.example.com/health] (expect JSON with status:ok), [docs.example.com] (expect docs homepage), [status.example.com] (check for any incidents). Take a screenshot of any page that looks wrong. Only alert in #devops if something is broken — stay silent if everything is fine." \
  --session isolated
```

### Health Check Output (alert only)
```
DevOps:          ⚠️ Site Health Alert — 1 issue found

                 ✅ app.example.com — login page loads (2.1s)
                 ✅ api.example.com/health — {"status":"ok"} (0.3s)
                 ❌ docs.example.com — 502 Bad Gateway
                    → Screenshot attached
                 ✅ status.example.com — no active incidents

                 docs.example.com is down. Investigating...
                 → Incident logged to Notion Incident Log
```

---

## 📱 Social Media Scheduler

**Agent:** Marketing  
**Frequency:** Daily (via cron) + on-demand  
**Description:** Queue posts and publish at optimal times.

### Workflow
```
┌─────────────────────────────────────────────────────────────┐
│  Social Media Scheduler                                     │
│                                                             │
│  1. CEO/Marketing drafts posts → saved to Notion queue      │
│  2. Cron runs daily at optimal posting times                │
│  3. Agent checks Notion queue for scheduled posts           │
│  4. Browser publishes to each platform                      │
│  5. Post URLs logged back to Notion                         │
│  6. Next-day: check engagement metrics, log to Notion       │
│                                                             │
│  Optimal posting times (configurable):                      │
│  • LinkedIn: Tuesday–Thursday, 9 AM                         │
│  • Twitter/X: Monday–Friday, 12 PM                          │
│  • Instagram: Monday/Wednesday/Friday, 6 PM                 │
└─────────────────────────────────────────────────────────────┘
```

### Cron Setup — Post Publisher
```bash
openclaw cron add \
  --name "social-publish" --agent marketing \
  --cron "0 9 * * 2-4" \
  --message "Check the Social Media Queue in Notion for any posts scheduled for today on LinkedIn. If found, publish via browser and update the Notion entry with the live URL and status='Published'. Post confirmation to #marketing." \
  --session isolated
```

### Cron Setup — Engagement Tracker
```bash
openclaw cron add \
  --name "social-engagement" --agent marketing \
  --cron "0 10 * * *" \
  --message "Check yesterday's social media posts in the Marketing Hub on Notion. For each post marked 'Published' in the last 48 hours, use the browser to visit the post URL and extract engagement metrics (likes, comments, shares, impressions if visible). Update the Notion entry with these metrics. Only post to #marketing if any post exceeded 100 engagements." \
  --session isolated
```

---

## ♿ Accessibility Audit

**Agent:** Engineering  
**Frequency:** Monthly (via cron) or on-demand  
**Description:** Audit key pages for WCAG 2.1 compliance and track regressions.

### What It Checks
- Image alt text (missing, generic, or decorative not marked)
- Form input labels (associated `<label>` or aria-label)
- Color contrast ratios (text, buttons, links)
- Heading hierarchy (proper h1→h2→h3 nesting)
- Keyboard navigation (tab order, focus visibility, skip links)
- ARIA attributes (roles, labels, live regions)
- Semantic HTML (landmarks, lists, tables)
- Focus management (modals, dynamic content)

### Cron Setup
```bash
openclaw cron add \
  --name "a11y-monthly-audit" --agent engineering \
  --cron "0 10 1 * *" \
  --message "Run an accessibility audit on these pages: homepage, login, dashboard, pricing, docs landing. For each page: check image alt text, form labels, color contrast (min 4.5:1 for text, 3:1 for large text), heading hierarchy, keyboard navigation, ARIA attributes, and focus management. Score each page out of 100. Compare with last month's audit in the Engineering Wiki. Flag any regressions (score dropped or new critical issues). Save the full report to Notion and post a summary to #engineering. If any page scores below 70, create a GitHub Issue with the specific fixes needed." \
  --session isolated
```

### Expected Output
```
♿ Accessibility Audit — example.com (March 2026)

Page Scores:
┌─────────────────┬───────┬────────────┬──────────┐
│ Page            │ Score │ Last Month │ Change   │
├─────────────────┼───────┼────────────┼──────────┤
│ Homepage        │ 92    │ 88         │ +4 ✅    │
│ Login           │ 85    │ 85         │ — ✅     │
│ Dashboard       │ 67    │ 72         │ -5 ⚠️    │
│ Pricing         │ 91    │ 91         │ — ✅     │
│ Docs Landing    │ 78    │ 75         │ +3 ✅    │
└─────────────────┴───────┴────────────┴──────────┘

⚠️ Dashboard regression — 2 new issues:
  • Color contrast on sidebar nav links dropped to 3.2:1
  • New modal missing focus trap (keyboard users can tab behind it)

→ Created GitHub Issue #156: "Dashboard a11y regression — contrast + focus trap"
→ Full report saved to Engineering Wiki on Notion
```

### Cross-Integration
- **GitHub:** Auto-create issues for critical a11y failures
- **Notion:** Track scores over time in Engineering Wiki
- **Discord:** Post summary to #engineering, alert on regressions
- **Cron:** Monthly automated checks prevent silent degradation

---

## 📄 PDF Report Generation

**Agent:** Finance or Management  
**Frequency:** Weekly/Monthly (via cron) or on-demand  
**Description:** Capture web dashboards and reports as archival PDFs.

### Workflow
1. Navigate to the target dashboard or report page
2. Authenticate if needed (Chrome profile for logged-in sessions)
3. Set date ranges and filters
4. Generate PDF with browser print-to-PDF
5. Archive to Notion and share on Discord

### Cron Setup — Monthly Billing PDF
```bash
openclaw cron add \
  --name "billing-pdf-monthly" --agent finance \
  --cron "0 9 1 * *" \
  --message "Using the Chrome browser profile, navigate to our billing dashboard. Set the date range to last month. Generate a PDF of the full billing summary page (letter size, include background graphics). Attach the PDF to this month's Financial Records entry on Notion. Post the total spend and PDF to #finance." \
  --session isolated
```

### Cron Setup — Weekly Analytics PDF
```bash
openclaw cron add \
  --name "analytics-pdf-weekly" --agent marketing \
  --cron "0 9 * * 1" \
  --message "Using the Chrome browser profile, navigate to our analytics dashboard. Set date range to last 7 days. Generate a PDF of the traffic overview page. Also generate a PDF of the conversion funnel page. Attach both PDFs to this week's entry in the Marketing Hub on Notion. Post key metrics (visitors, conversions, top pages) to #marketing." \
  --session isolated
```

### PDF Options
Agents can customize PDF output:
- **Page size:** Letter, A4, Legal, or custom dimensions
- **Orientation:** Portrait or landscape
- **Margins:** Custom top/bottom/left/right margins
- **Headers/footers:** Page numbers, dates, titles
- **Background:** Include or exclude background colors/images
- **Page ranges:** Export specific pages from multi-page views

### Expected Output
```
Finance:         📄 Monthly Billing Report — February 2026

                 Generated from billing.example.com
                 • Date range: Feb 1–28, 2026
                 • Total spend: $312.40
                 • Largest item: API usage ($187.20)
                 • vs. January: +12% ($278.90)

                 📎 billing-feb-2026.pdf (3 pages, 245 KB)
                 → Attached to Notion: Financial Records
                 → Posted to #finance
```

---

## Tips for Writing Browser Recipes

1. **Be specific about what to look for** — "check the pricing page" is vague; "extract plan names, prices, and feature counts from the pricing table" is actionable
2. **Tell agents what to do on failure** — "if the page doesn't load, retry once, then report the error"
3. **Use the right profile** — `clawd` for public scraping, `chrome` for authenticated dashboards
4. **Set reasonable timeouts** — web pages can be slow; give agents 30-60 seconds for complex pages
5. **Cache when possible** — "only re-scrape if the last check was >24 hours ago"
6. **Respect rate limits** — "add 3-second delays between page loads" for batch scraping
7. **Store results in Notion** — always archive extracted data for historical comparison
