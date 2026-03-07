# GitHub Workflow Templates

Ready-to-use GitHub Actions workflow templates for your AI team. DevOps can deploy these to any repo with one command.

---

## CI — Node.js

```yaml
# .github/workflows/ci.yml
name: CI
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [18, 20, 22]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: npm
      - run: npm ci
      - run: npm run lint
      - run: npm test -- --coverage
      - uses: actions/upload-artifact@v4
        if: matrix.node-version == 22
        with:
          name: coverage
          path: coverage/
```

---

## CI — Python

```yaml
# .github/workflows/ci.yml
name: CI
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.10", "3.11", "3.12"]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}
          cache: pip
      - run: pip install -r requirements.txt -r requirements-dev.txt
      - run: mypy src/
      - run: pytest --cov=src --cov-report=xml
      - uses: actions/upload-artifact@v4
        if: matrix.python-version == '3.12'
        with:
          name: coverage
          path: coverage.xml
```

---

## Deploy to Staging (auto on merge)

```yaml
# .github/workflows/deploy-staging.yml
name: Deploy Staging
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: npm
      - run: npm ci
      - run: npm test
      - run: npm run build
      - name: Deploy
        env:
          DEPLOY_KEY: ${{ secrets.STAGING_DEPLOY_KEY }}
        run: |
          # Replace with your deploy command
          echo "Deploying to staging..."
          # Examples:
          # rsync -avz dist/ user@staging:/var/www/app/
          # vercel --prod --token $VERCEL_TOKEN
          # aws s3 sync dist/ s3://staging-bucket/
```

---

## Deploy to Production (manual approval)

```yaml
# .github/workflows/deploy-production.yml
name: Deploy Production
on:
  workflow_dispatch:
    inputs:
      version:
        description: "Version tag to deploy (e.g., v2.1.0)"
        required: true

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
      # Requires manual approval in GitHub Settings → Environments
    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ github.event.inputs.version }}
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: npm
      - run: npm ci
      - run: npm test
      - run: npm run build
      - name: Deploy to Production
        env:
          DEPLOY_KEY: ${{ secrets.PRODUCTION_DEPLOY_KEY }}
        run: |
          echo "Deploying ${{ github.event.inputs.version }} to production..."
          # Your production deploy command here
```

---

## Release Drafter (auto-changelog from PR labels)

```yaml
# .github/workflows/release-drafter.yml
name: Release Drafter
on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: write
  pull-requests: read

jobs:
  draft:
    runs-on: ubuntu-latest
    steps:
      - uses: release-drafter/release-drafter@v6
        with:
          config-name: release-drafter.yml
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Required config** — `.github/release-drafter.yml`:

```yaml
categories:
  - title: "✨ Features"
    labels: [feature, enhancement]
  - title: "🐛 Bug Fixes"
    labels: [bug, fix]
  - title: "📝 Documentation"
    labels: [docs, documentation]
  - title: "🔧 Maintenance"
    labels: [chore, maintenance, deps]

change-template: "- $TITLE (#$NUMBER) — @$AUTHOR"
version-resolver:
  major:
    labels: [breaking]
  minor:
    labels: [feature, enhancement]
  default: patch
template: |
  ## What's Changed
  $CHANGES

  **Full Changelog**: https://github.com/$OWNER/$REPOSITORY/compare/$PREVIOUS_TAG...v$RESOLVED_VERSION
```

---

## Dependency Audit (weekly security scan)

```yaml
# .github/workflows/dependency-audit.yml
name: Dependency Audit
on:
  schedule:
    - cron: "0 9 * * 1"  # Every Monday at 9 AM UTC
  workflow_dispatch:

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: npm
      - run: npm ci
      - name: Security audit
        run: |
          npm audit --audit-level=moderate 2>&1 | tee audit-report.txt
          if [ ${PIPESTATUS[0]} -ne 0 ]; then
            echo "::warning::Security vulnerabilities found"
          fi
      - name: Check for outdated packages
        run: npm outdated || true
      - uses: actions/upload-artifact@v4
        with:
          name: audit-report
          path: audit-report.txt
```

---

## Stale Issue Cleanup (auto-close inactive issues)

```yaml
# .github/workflows/stale.yml
name: Stale Issue Cleanup
on:
  schedule:
    - cron: "0 0 * * *"  # Daily at midnight UTC

permissions:
  issues: write
  pull-requests: write

jobs:
  stale:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/stale@v9
        with:
          days-before-stale: 30
          days-before-close: 7
          stale-issue-label: stale
          stale-issue-message: >
            This issue has been inactive for 30 days. It will be
            closed in 7 days unless there's new activity. If this
            is still relevant, please comment to keep it open.
          close-issue-message: >
            Closed due to inactivity. Feel free to reopen if
            this is still needed.
          exempt-issue-labels: pinned,priority-high,priority-critical
          stale-pr-label: stale
          days-before-pr-stale: 14
          days-before-pr-close: 7
```

---

## Tips for Your AI Team

- **DevOps owns workflow files** — when you ask "set up CI for repo X," DevOps picks the right template, customizes it, and commits the workflow YAML.
- **Label your PRs** — the Release Drafter workflow uses labels to auto-categorize changelog entries. Ask Engineering to add labels like `feature`, `bug`, `docs` when creating PRs.
- **Start with CI + Deploy Staging** — these two cover 80% of automation needs. Add the rest as your workflow matures.
- **Use environments** — GitHub Environments with required reviewers add a manual approval gate for production deploys. Configure in Settings → Environments.
- **Secrets management** — store deploy keys and tokens in GitHub Secrets (Settings → Secrets → Actions). Never hardcode credentials in workflow files.
