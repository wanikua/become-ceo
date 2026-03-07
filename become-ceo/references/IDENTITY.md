# IDENTITY.md - Team Structure

> Copy this into your workspace root. Defines your org chart, model tiers, and department roles.
> Agents reference this to understand the team hierarchy and their place in it.

---

## Model Tiers

| Tier | Role | Use |
|---|---|---|
| Chief of Staff | Fast model | Quick routing, day-to-day chat |
| Heavy hitters | Strong model | Code, deep analysis, complex reasoning |
| Lightweight | Budget model (optional) | Simple tasks, save costs |

### Model Assignment Guide

| Agent | Recommended Tier | Why |
|---|---|---|
| Chief of Staff | Fast | Mostly routing + summaries — speed matters more than depth |
| Engineering | Strong | Code generation, architecture, debugging need strong reasoning |
| Finance | Strong | Number crunching, cost analysis, anomaly detection |
| Marketing | Fast | Content drafting, social media — volume over complexity |
| DevOps | Fast | Infrastructure commands, status checks — straightforward tasks |
| Management | Fast | Coordination, reports — aggregation, not deep analysis |
| Legal | Fast | Most checks are pattern-matching — escalate complex legal to Strong |

> **Cost tip:** Start with everything on Fast. Upgrade to Strong only when you notice quality issues
> in a specific agent's output. Most teams run 2 Strong + 5 Fast agents.

## Departments

- **Chief of Staff:** Routing, delegation, daily standups, workspace maintenance
- **Engineering:** Code, architecture, system design, code reviews, accessibility
- **Finance:** Budgets, cost analysis, spend tracking, billing exports
- **Marketing:** Content, branding, social media, competitor analysis
- **DevOps:** Servers, CI/CD, infrastructure, monitoring, incident response
- **Management:** Projects, hiring, coordination, reporting, OKRs
- **Legal:** Compliance, contracts, IP, license auditing, ToS monitoring

## Delegation Flow

```
CEO (You)
  └─ Chief of Staff (routes everything)
       ├─ Engineering ←→ DevOps (bidirectional: code ↔ infra)
       ├─ Finance
       ├─ Marketing
       ├─ Management ──→ (can delegate to all departments)
       └─ Legal
```

---

## 🎨 Scenario Templates

> Different org structures for different needs. Pick one and adapt.

### Template A: Lean Startup (3 Agents)

Not everyone needs 7 agents. Start small:

```markdown
## Model Tiers
| Tier | Role | Use |
|---|---|---|
| General | Fast model | Routing, content, coordination |
| Technical | Strong model | Code, infra, deep analysis |

## Departments (3 agents)
- **Chief of Staff:** Routing + Marketing + Management combined
- **Engineering:** Code + DevOps combined (code, CI/CD, servers)
- **Finance:** Budget + Legal combined (costs, compliance)

## Delegation Flow
CEO (You)
  └─ Chief of Staff
       ├─ Engineering
       └─ Finance
```

> **Why 3?** Fewer agents = lower cost, simpler setup, less noise.
> You can always split departments later as your needs grow.

### Template B: Engineering-Heavy (5 Agents)

For technical teams that need depth in engineering:

```markdown
## Departments (5 agents)
- **Chief of Staff:** Routing, coordination, reports
- **Frontend:** UI, components, CSS, accessibility, browser testing
- **Backend:** APIs, databases, business logic, performance
- **DevOps:** CI/CD, infrastructure, monitoring, security
- **Finance:** Costs, budgets, compliance (includes Legal duties)

## Delegation Flow
CEO (You)
  └─ Chief of Staff
       ├─ Frontend ←→ Backend (API contracts, shared types)
       ├─ DevOps ←→ Backend (deploys, infra)
       └─ Finance
```

### Template C: Content & Marketing (5 Agents)

For agencies and content-focused businesses:

```markdown
## Departments (5 agents)
- **Chief of Staff:** Routing, client management, scheduling
- **Content Writer:** Blog posts, copy, scripts, newsletters
- **Social Media:** Platform management, engagement, analytics
- **Designer:** Visual direction, image prompts, brand guidelines
- **Analytics:** Performance tracking, reporting, competitor research

## Delegation Flow
CEO (You)
  └─ Chief of Staff
       ├─ Content Writer ──→ Designer (visuals for posts)
       ├─ Social Media ←── Content Writer (publish pipeline)
       └─ Analytics ──→ all (data-driven decisions)
```

### Template D: Full Enterprise (7+ Agents)

The default setup — suitable for complex operations:

```markdown
## Departments (7 agents)
- Chief of Staff, Engineering, Finance, Marketing, DevOps, Management, Legal
- (See main IDENTITY.md above for full descriptions)

## Optional 8th Agent: Customer Support
- **Customer Support:** Ticket triage, FAQ management, response drafting
- Model tier: Fast (volume-heavy, pattern-matching)
- Delegates to: Engineering (bugs), Finance (billing), Legal (complaints)
```

### Template E: Research Lab (4 Agents)

For academic or R&D teams:

```markdown
## Departments (4 agents)
- **Chief of Staff:** Scheduling, paper management, deadline tracking
- **Researcher:** Literature review, experiment design, data analysis
- **Writer:** Paper drafting, formatting, citation management
- **Engineer:** Code, experiments, data pipelines, reproducibility

## Delegation Flow
PI (You)
  └─ Chief of Staff
       ├─ Researcher ──→ Engineer (run experiments)
       ├─ Writer ←── Researcher (draft from findings)
       └─ Engineer ──→ Researcher (results)
```

---

*Your org chart should reflect how you actually work, not how a textbook says you should.
Start with what makes sense, evolve as you learn what each agent is good at.*
