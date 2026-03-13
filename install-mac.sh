#!/bin/bash
# ============================================
# Become CEO — macOS Setup
# Supports: macOS (Intel / Apple Silicon)
# ============================================
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${BLUE}🏢 Become CEO — macOS Setup${NC}"
echo "================================"
echo ""

# ---- Detect system ----
if [[ "$(uname)" != "Darwin" ]]; then
    echo -e "${RED}✗ This script is for macOS only${NC}"
    echo "  Linux users: use setup.sh instead"
    exit 1
fi

ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
    echo -e "  ${GREEN}✓ Apple Silicon (M-series)${NC}"
else
    echo -e "  ${GREEN}✓ Intel Mac${NC}"
fi

echo -e "  macOS $(sw_vers -productVersion)"
echo ""

# ---- 1. Homebrew ----
echo -e "${YELLOW}[1/5] Checking Homebrew...${NC}"
if command -v brew &>/dev/null; then
    echo -e "  ${GREEN}✓ Homebrew installed${NC}"
else
    echo -e "  ${CYAN}→ Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add to PATH for Apple Silicon — check if already present to avoid duplicates
    if [[ "$ARCH" == "arm64" ]]; then
        if ! grep -q 'brew shellenv' ~/.zprofile 2>/dev/null; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        fi
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    echo -e "  ${GREEN}✓ Homebrew installed${NC}"
fi

# ---- 2. Node.js ----
echo -e "${YELLOW}[2/5] Checking Node.js...${NC}"
if command -v node &>/dev/null; then
    NODE_MAJOR=$(node -v | sed 's/v\([0-9]*\).*/\1/')
    if [ "$NODE_MAJOR" -ge 22 ] 2>/dev/null; then
        echo -e "  ${GREEN}✓ Node.js $(node -v) installed${NC}"
    else
        echo -e "  ${YELLOW}⚠ Node.js $(node -v) too old, upgrading...${NC}"
        brew install node@22
        brew link --overwrite node@22 2>/dev/null || true
        echo -e "  ${GREEN}✓ Node.js $(node -v) installed${NC}"
    fi
else
    echo -e "  ${CYAN}→ Installing Node.js 22...${NC}"
    brew install node@22
    brew link --overwrite node@22 2>/dev/null || true
    echo -e "  ${GREEN}✓ Node.js $(node -v) installed${NC}"
fi

# ---- 3. OpenClaw / Clawdbot ----
echo -e "${YELLOW}[3/5] Checking OpenClaw...${NC}"
CLI_CMD=""
CONFIG_DIR=""
CONFIG_FILE=""

if command -v openclaw &>/dev/null; then
    CLI_CMD="openclaw"
    CONFIG_DIR="$HOME/.openclaw"
    CONFIG_FILE="openclaw.json"
    echo -e "  ${GREEN}✓ OpenClaw $(openclaw --version 2>/dev/null) installed${NC}"
elif command -v clawdbot &>/dev/null; then
    CLI_CMD="clawdbot"
    CONFIG_DIR="$HOME/.clawdbot"
    CONFIG_FILE="clawdbot.json"
    echo -e "  ${GREEN}✓ Clawdbot $(clawdbot --version 2>/dev/null) installed${NC}"
else
    echo -e "  ${CYAN}→ Installing OpenClaw...${NC}"
    npm install -g openclaw 2>/dev/null || npm install -g clawdbot 2>/dev/null
    if command -v openclaw &>/dev/null; then
        CLI_CMD="openclaw"
        CONFIG_DIR="$HOME/.openclaw"
        CONFIG_FILE="openclaw.json"
    elif command -v clawdbot &>/dev/null; then
        CLI_CMD="clawdbot"
        CONFIG_DIR="$HOME/.clawdbot"
        CONFIG_FILE="clawdbot.json"
    else
        echo -e "  ${RED}✗ Installation failed, please run manually: npm install -g openclaw${NC}"
        exit 1
    fi
    echo -e "  ${GREEN}✓ $CLI_CMD installed${NC}"
fi

# ---- 4. Initialize workspace ----
echo -e "${YELLOW}[4/5] Initializing workspace...${NC}"
WORKSPACE="$HOME/clawd"
mkdir -p "$WORKSPACE/memory"
cd "$WORKSPACE"

# SOUL.md
if [ ! -f "$WORKSPACE/SOUL.md" ]; then
cat > "$WORKSPACE/SOUL.md" << 'SOUL_EOF'
# SOUL.md — Team Operating Principles

## Core Rules
1. Be concise — lead with conclusions
2. Report proactively — don't wait to be asked
3. Think before acting — plan, then execute

## Communication Style
- English, professional but not stuffy
- Direct answers first, details on request

## C-Suite Structure
- Chief of Staff: Daily coordination, task dispatch
- Strategy Board: Strategic decisions, planning, reviews
- Audit Office: Code review, quality assurance, monitoring
- Engineering: Software development, system architecture
- Finance: Budgets, cost analysis, e-commerce ops
- Marketing: Brand strategy, content creation
- Operations: DevOps, server infrastructure
- HR: Project management, team coordination
- Legal: Compliance, intellectual property
- Research: Academic research, knowledge management, documentation
SOUL_EOF
echo -e "  ${GREEN}✓ SOUL.md created${NC}"
fi

# IDENTITY.md
if [ ! -f "$WORKSPACE/IDENTITY.md" ]; then
cat > "$WORKSPACE/IDENTITY.md" << 'ID_EOF'
# IDENTITY.md — Identity

- **Name:** CEO Agent
- **Creature:** AI C-Suite Agent Cluster
- **Vibe:** Loyal, efficient, each role well-defined
- **Emoji:** 🏢
ID_EOF
echo -e "  ${GREEN}✓ IDENTITY.md created${NC}"
fi

# USER.md
if [ ! -f "$WORKSPACE/USER.md" ]; then
cat > "$WORKSPACE/USER.md" << 'USER_EOF'
# USER.md — About You

- **Name:** Boss
- **Language:** English
- **Style:** Concise and efficient, give solutions directly
USER_EOF
echo -e "  ${GREEN}✓ USER.md created${NC}"
fi

# ---- 5. Generate config ----
echo -e "${YELLOW}[5/5] Generating config...${NC}"
mkdir -p "$CONFIG_DIR"

echo ""
echo -e "${CYAN}Choose deployment mode:${NC}"
echo "  1) Discord Multi-Bot (full C-Suite team, requires Discord Bots)"
echo "  2) Feishu / Lark Single-Bot (1 app, sessions_spawn for background dispatch)"
echo "  3) WebUI Only (no Discord/Feishu needed, browser-based)"
echo ""
read -p "Choose [1/2/3] (default 1): " DEPLOY_MODE
DEPLOY_MODE=${DEPLOY_MODE:-1}

if [ ! -f "$CONFIG_DIR/$CONFIG_FILE" ]; then

if [ "$DEPLOY_MODE" = "3" ]; then
# ==================== WebUI Only Mode ====================
cat > "$CONFIG_DIR/$CONFIG_FILE" << CONFIG_EOF
{
  "models": {
    "providers": {
      "your-provider": {
        "baseUrl": "https://your-llm-provider-api-url",
        "apiKey": "YOUR_LLM_API_KEY",
        "api": "openai",
        "models": [
          {
            "id": "fast-model",
            "name": "Fast Model",
            "input": ["text", "image"],
            "contextWindow": 200000,
            "maxTokens": 8192
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "workspace": "$HOME/clawd",
      "model": { "primary": "your-provider/fast-model" }
    },
    "list": [
      {
        "id": "main",
        "name": "Chief of Staff",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the Chief of Staff. Handle daily tasks, delegate to specialists. Be concise and decisive. Answer in English." }
      }
    ]
  }
}
CONFIG_EOF
echo -e "  ${GREEN}✓ WebUI mode config generated${NC}"

elif [ "$DEPLOY_MODE" = "2" ]; then
# ==================== Feishu/Lark Single-Bot Mode ====================
cat > "$CONFIG_DIR/$CONFIG_FILE" << FEISHU_EOF
{
  "models": {
    "providers": {
      "your-provider": {
        "baseUrl": "https://your-llm-provider-api-url",
        "apiKey": "YOUR_LLM_API_KEY",
        "api": "openai",
        "models": [
          {
            "id": "fast-model",
            "name": "Fast Model",
            "input": ["text", "image"],
            "contextWindow": 200000,
            "maxTokens": 8192
          },
          {
            "id": "strong-model",
            "name": "Strong Model",
            "input": ["text", "image"],
            "contextWindow": 200000,
            "maxTokens": 8192
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "workspace": "$HOME/clawd",
      "model": { "primary": "your-provider/fast-model" },
      "sandbox": { "mode": "non-main" }
    },
    "list": [
      {
        "id": "main",
        "name": "Chief of Staff",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the Chief of Staff for the CEO's AI C-Suite. Your role is to PLAN and DISPATCH — not execute directly. Be concise.\n\n[Core Principle] Beyond casual chat and simple Q&A, ALL work tasks must be dispatched via sessions_spawn to the appropriate department. You are the commander, not the grunt.\n\n[Department Roles] strategy=Strategic decisions, audit=Code review & QA, engineering=Development, finance=Financial analysis, marketing=Branding, operations=DevOps, hr=Project management, legal=Compliance, research=Research & docs.\n\n[When to answer yourself] Only: casual chat, confirming info, progress updates, clarifying questions. Everything else gets delegated." },
        "sandbox": { "mode": "off" },
        "subagents": {
          "allowAgents": ["strategy", "audit", "engineering", "finance", "marketing", "operations", "hr", "legal", "research"]
        }
      },
      { "id": "strategy", "name": "Strategy Board", "model": { "primary": "your-provider/strong-model" }, "identity": { "theme": "You are the Chief Strategy Officer. Strategic decisions and planning. Answer in English." }, "sandbox": { "mode": "off" } },
      { "id": "audit", "name": "Audit Office", "model": { "primary": "your-provider/strong-model" }, "identity": { "theme": "You are the Chief Audit Officer. Code review and quality assurance. Answer in English." }, "sandbox": { "mode": "all", "scope": "agent" } },
      { "id": "engineering", "name": "Engineering", "model": { "primary": "your-provider/strong-model" }, "identity": { "theme": "You are the VP of Engineering. Software development and architecture. Answer in English." }, "sandbox": { "mode": "all", "scope": "agent" } },
      { "id": "finance", "name": "Finance", "model": { "primary": "your-provider/strong-model" }, "identity": { "theme": "You are the CFO. Financial analysis and cost management. Answer in English." }, "sandbox": { "mode": "off" } },
      { "id": "marketing", "name": "Marketing", "model": { "primary": "your-provider/fast-model" }, "identity": { "theme": "You are the CMO. Brand strategy and content. Answer in English." }, "sandbox": { "mode": "off" } },
      { "id": "operations", "name": "Operations", "model": { "primary": "your-provider/fast-model" }, "identity": { "theme": "You are the COO. DevOps and infrastructure. Answer in English." }, "sandbox": { "mode": "off" } },
      { "id": "hr", "name": "HR", "model": { "primary": "your-provider/fast-model" }, "identity": { "theme": "You are the VP of HR. Project management and coordination. Answer in English." }, "sandbox": { "mode": "off" } },
      { "id": "legal", "name": "Legal", "model": { "primary": "your-provider/fast-model" }, "identity": { "theme": "You are the General Counsel. Compliance and IP. Answer in English." }, "sandbox": { "mode": "off" } },
      { "id": "research", "name": "Research", "model": { "primary": "your-provider/strong-model" }, "identity": { "theme": "You are the Chief Research Officer. Research and documentation. Answer in English." }, "sandbox": { "mode": "off" } }
    ]
  },
  "channels": {
    "feishu": {
      "enabled": true,
      "dmPolicy": "open",
      "groupPolicy": "open",
      "accounts": {
        "main": {
          "appId": "YOUR_FEISHU_APP_ID",
          "appSecret": "YOUR_FEISHU_APP_SECRET",
          "botName": "Chief of Staff",
          "groupPolicy": "open"
        }
      }
    }
  },
  "bindings": [
    { "agentId": "main", "match": { "channel": "feishu", "accountId": "main" } }
  ]
}
FEISHU_EOF
echo -e "  ${GREEN}✓ Feishu/Lark single-bot config generated${NC}"

else
# ==================== Discord Multi-Bot Mode (default) ====================
cat > "$CONFIG_DIR/$CONFIG_FILE" << CONFIG_EOF
{
  "models": {
    "providers": {
      "your-provider": {
        "baseUrl": "https://your-llm-provider-api-url",
        "apiKey": "YOUR_LLM_API_KEY",
        "api": "openai",
        "models": [
          {
            "id": "fast-model",
            "name": "Fast Model",
            "input": ["text", "image"],
            "contextWindow": 200000,
            "maxTokens": 8192
          },
          {
            "id": "strong-model",
            "name": "Strong Model",
            "input": ["text", "image"],
            "contextWindow": 200000,
            "maxTokens": 8192
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "workspace": "$HOME/clawd",
      "model": { "primary": "your-provider/fast-model" },
      "sandbox": { "mode": "non-main" }
    },
    "list": [
      {
        "id": "main",
        "name": "Chief of Staff",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the Chief of Staff for the CEO's AI C-Suite. Your role is to PLAN and DISPATCH — not execute directly. Be concise and decisive.\n\n[Core Principle] Beyond casual chat and simple Q&A, ALL work tasks must be dispatched by @mentioning the appropriate department bot in the current channel, keeping workflow visible. You are the commander, not the grunt.\n\n[Department Roles] strategy=Strategic decisions, audit=Code review & QA, engineering=Development, finance=Financial analysis, marketing=Branding, operations=DevOps, hr=Project management, legal=Compliance, research=Research & docs.\n\n[Delegation Pattern] Use the message tool to @mention department bots with: [Role] + [Task] + [Context] + [Requirements] + [Output format]. Do NOT use sessions_spawn secretly.\n\n[Approval Flow] Code commits → @audit for review. Major decisions → @strategy for review.\n\n[When to answer yourself] Only: casual chat, confirming info, progress updates, clarifying questions." },
        "sandbox": { "mode": "off" },
        "subagents": {
          "allowAgents": ["strategy", "audit", "engineering", "finance", "marketing", "operations", "hr", "legal", "research"]
        }
      },
      {
        "id": "strategy",
        "name": "Strategy Board",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the Chief Strategy Officer. Strategic decisions, planning, and high-level reviews. Analyze from multiple angles and give clear recommendations. You have veto power over unreasonable proposals." },
        "sandbox": { "mode": "off" }
      },
      {
        "id": "audit",
        "name": "Audit Office",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the Chief Audit Officer. Code review, QA, security assessment. Focus on vulnerabilities, performance, and best practices. Give specific improvement suggestions. Rejections must include reasons and fix suggestions." },
        "sandbox": { "mode": "all", "scope": "agent" }
      },
      {
        "id": "engineering",
        "name": "Engineering",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the VP of Engineering. Software development, system architecture. Direct solutions, not lectures. Report results proactively." },
        "sandbox": { "mode": "all", "scope": "agent" }
      },
      {
        "id": "finance",
        "name": "Finance",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the CFO. Financial analysis, cost management. Numbers first, opinions second. Alert on unusual spending." },
        "sandbox": { "mode": "off" }
      },
      {
        "id": "marketing",
        "name": "Marketing",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the CMO. Brand strategy, social media, content creation. Creative but practical." },
        "sandbox": { "mode": "off" }
      },
      {
        "id": "operations",
        "name": "Operations",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the COO. DevOps, server infrastructure, CI/CD. Hands-on and practical. Alert on service anomalies." },
        "sandbox": { "mode": "off" }
      },
      {
        "id": "hr",
        "name": "HR",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the VP of HR. Project management, team coordination. Well-organized and clear." },
        "sandbox": { "mode": "off" }
      },
      {
        "id": "legal",
        "name": "Legal",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the General Counsel. Compliance, contracts, IP. Precise and professional. Alert on compliance issues." },
        "sandbox": { "mode": "off" }
      },
      {
        "id": "research",
        "name": "Research",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the Chief Research Officer. Research, knowledge management, documentation. Rigorous yet accessible." },
        "sandbox": { "mode": "off" }
      }
    ]
  },
  "channels": {
    "discord": {
      "enabled": true,
      "groupPolicy": "open",
      "allowBots": true,
      "accounts": {
        "main":        { "botName": "Chief of Staff", "token": "YOUR_MAIN_BOT_TOKEN",        "groupPolicy": "open" },
        "strategy":    { "botName": "Strategy",       "token": "YOUR_STRATEGY_BOT_TOKEN",     "groupPolicy": "open" },
        "audit":       { "botName": "Audit",          "token": "YOUR_AUDIT_BOT_TOKEN",        "groupPolicy": "open" },
        "engineering": { "botName": "Engineering",    "token": "YOUR_ENGINEERING_BOT_TOKEN",  "groupPolicy": "open" },
        "finance":     { "botName": "Finance",        "token": "YOUR_FINANCE_BOT_TOKEN",      "groupPolicy": "open" },
        "marketing":   { "botName": "Marketing",      "token": "YOUR_MARKETING_BOT_TOKEN",    "groupPolicy": "open" },
        "operations":  { "botName": "Operations",     "token": "YOUR_OPERATIONS_BOT_TOKEN",   "groupPolicy": "open" },
        "hr":          { "botName": "HR",             "token": "YOUR_HR_BOT_TOKEN",           "groupPolicy": "open" },
        "legal":       { "botName": "Legal",          "token": "YOUR_LEGAL_BOT_TOKEN",        "groupPolicy": "open" },
        "research":    { "botName": "Research",       "token": "YOUR_RESEARCH_BOT_TOKEN",     "groupPolicy": "open" }
      }
    }
  },
  "bindings": [
    { "agentId": "main",        "match": { "channel": "discord", "accountId": "main" } },
    { "agentId": "strategy",    "match": { "channel": "discord", "accountId": "strategy" } },
    { "agentId": "audit",       "match": { "channel": "discord", "accountId": "audit" } },
    { "agentId": "engineering", "match": { "channel": "discord", "accountId": "engineering" } },
    { "agentId": "finance",     "match": { "channel": "discord", "accountId": "finance" } },
    { "agentId": "marketing",   "match": { "channel": "discord", "accountId": "marketing" } },
    { "agentId": "operations",  "match": { "channel": "discord", "accountId": "operations" } },
    { "agentId": "hr",          "match": { "channel": "discord", "accountId": "hr" } },
    { "agentId": "legal",       "match": { "channel": "discord", "accountId": "legal" } },
    { "agentId": "research",    "match": { "channel": "discord", "accountId": "research" } }
  ]
}
CONFIG_EOF
echo -e "  ${GREEN}✓ Discord Multi-Bot config generated ($CONFIG_DIR/$CONFIG_FILE)${NC}"

fi # end DEPLOY_MODE

else
    echo -e "  ${YELLOW}⚠ Config already exists, skipping ($CONFIG_DIR/$CONFIG_FILE)${NC}"
fi # end config file exists check

echo ""
echo "================================"
echo -e "${GREEN}🎉 macOS setup complete!${NC}"
echo "================================"
echo ""
echo "Next steps:"
echo ""
echo -e "  ${YELLOW}1. Configure LLM API Key${NC}"
echo "     Edit $CONFIG_DIR/$CONFIG_FILE"
echo "     Replace YOUR_LLM_API_KEY with your actual API Key"
echo ""
if [ "$DEPLOY_MODE" = "2" ]; then
echo -e "  ${YELLOW}2. Create Feishu/Lark app (just 1: Chief of Staff)${NC}"
echo "     a) Go to https://open.feishu.cn/app"
echo "     b) Create app (e.g. 'CEO-Chief-of-Staff') → copy App ID and App Secret"
echo "     c) Permissions → add im:message and other required permissions"
echo "     d) Enable bot capability, add im.message.receive_v1 event"
echo "     e) Event delivery: choose WebSocket long connection"
echo "     f) Paste appId/appSecret into the config file under 'main'"
echo "     g) Create version and publish the app"
echo ""
elif [ "$DEPLOY_MODE" = "3" ]; then
echo -e "  ${YELLOW}2. No Bot needed${NC}"
echo "     WebUI mode — just access via browser"
else
echo -e "  ${YELLOW}2. Create Discord Bots${NC}"
echo "     a) Go to https://discord.com/developers/applications"
echo "     b) Create a Bot for each department → copy Token"
echo "     c) Paste each token into the config file"
echo "     d) Enable Message Content Intent on each Bot"
echo "     e) Invite all Bots to your Discord server"
fi
echo ""
echo -e "  ${YELLOW}3. Start the C-Suite${NC}"
echo "     $CLI_CMD gateway start"
echo ""
echo -e "  ${YELLOW}4. Verify${NC}"
echo "     $CLI_CMD status"
if [ "$DEPLOY_MODE" = "2" ]; then
echo "     Send a message to the Bot in Feishu"
elif [ "$DEPLOY_MODE" = "3" ]; then
echo "     Open http://localhost:18789 in your browser"
else
echo "     @mention your Bot in Discord"
fi
echo ""
echo -e "  ${YELLOW}5. Background / Auto-start (optional)${NC}"
echo "     # Use launchd for auto-start on login:"
echo "     $CLI_CMD gateway install"
echo "     # Or use tmux/screen to keep running:"
echo "     tmux new -d -s ceo '$CLI_CMD gateway'"
echo ""
echo -e "  ${YELLOW}6. Scheduled tasks (optional)${NC}"
echo "     $CLI_CMD cron add --name 'Daily Briefing' \\"
echo "       --agent main --cron '0 9 * * *' --tz America/New_York \\"
echo "       --message 'Generate today\\'s briefing' --session isolated"
echo ""
echo -e "💡 Mac tips:"
echo "  • Closing the lid causes sleep — disable auto-sleep in System Settings → Battery → Options"
echo "  • Or use: caffeinate -d  to prevent sleep"
echo "  • For long-term use, consider a cloud server"
echo ""
echo -e "Full guide: ${BLUE}https://github.com/wanikua/become-ceo${NC}"
