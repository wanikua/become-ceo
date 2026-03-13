#!/bin/bash
# ============================================
# Become CEO — Lite Setup (already have OpenClaw/Clawdbot)
# Skips system dependencies, only initializes workspace + config
#
# Usage:
#   bash install-lite.sh              # Interactive setup
#   bash install-lite.sh --no-gui     # Skip Dashboard Web UI
#   bash install-lite.sh --with-gui   # Include Dashboard Web UI
# ============================================
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ---- Parse command-line arguments ----
INSTALL_GUI=""
for arg in "$@"; do
    case "$arg" in
        --no-gui)  INSTALL_GUI="no" ;;
        --with-gui) INSTALL_GUI="yes" ;;
    esac
done

echo ""
echo -e "${BLUE}🏢 Become CEO — Lite Setup${NC}"
echo "================================"
echo -e "For users who already have OpenClaw or Clawdbot installed"
echo ""

# ---- Check if OpenClaw is installed ----
if command -v openclaw &>/dev/null; then
    CLI_CMD="openclaw"
    echo -e "  ${GREEN}✓ OpenClaw $(openclaw --version 2>/dev/null) detected${NC}"
elif command -v clawdbot &>/dev/null; then
    CLI_CMD="clawdbot"
    echo -e "  ${GREEN}✓ Clawdbot $(clawdbot --version 2>/dev/null) detected${NC}"
else
    echo -e "  ${RED}✗ OpenClaw or Clawdbot not found${NC}"
    echo ""
    echo "Install first:"
    echo "  npm install -g openclaw@latest"
    echo ""
    echo "Or use the full setup script:"
    echo "  bash <(curl -fsSL https://raw.githubusercontent.com/wanikua/become-ceo/main/setup.sh)"
    exit 1
fi

# ---- Choose mode ----
echo ""
echo -e "${CYAN}Choose deployment mode:${NC}"
echo "  1) Discord Multi-Bot (full C-Suite team, requires Discord Bots)"
echo "  2) Feishu / Lark Single-Bot (1 app, sessions_spawn for background dispatch)"
echo "  3) WebUI Only (no Discord/Feishu needed, browser-based)"
echo ""
read -p "Choose [1/2/3] (default 1): " MODE_CHOICE
MODE_CHOICE=${MODE_CHOICE:-1}

# ---- Dashboard Web UI option ----
if [ -z "$INSTALL_GUI" ]; then
    echo ""
    echo -e "${CYAN}Install the Dashboard Web UI (visual management panel)?${NC}"
    echo "  The Dashboard provides session management, token stats, and system monitoring."
    echo "  If you only need CLI / Discord interaction, you can skip it."
    echo ""
    read -p "Install Dashboard? [y/N]: " GUI_CHOICE
    case "$GUI_CHOICE" in
        [yY]|[yY][eE][sS]) INSTALL_GUI="yes" ;;
        *) INSTALL_GUI="no" ;;
    esac
fi

echo ""

# ---- Initialize workspace ----
echo -e "${YELLOW}[1/4] Initializing workspace...${NC}"
WORKSPACE="$HOME/clawd"
if [ "$CLI_CMD" = "openclaw" ]; then
    CONFIG_DIR="$HOME/.openclaw"
    CONFIG_FILE="openclaw.json"
else
    CONFIG_DIR="$HOME/.clawdbot"
    CONFIG_FILE="clawdbot.json"
fi
mkdir -p "$WORKSPACE"
mkdir -p "$CONFIG_DIR"
cd "$WORKSPACE"

# SOUL.md
if [ ! -f SOUL.md ]; then
cat > SOUL.md << 'SOUL_EOF'
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

## Model Tiers
| Tier | Model | Usage |
|---|---|---|
| Coordination | Fast Model | Daily chat, quick responses |
| Heavy Lifting | Strong Model | Coding, deep analysis |
| Budget (optional) | Economy Model | Lightweight tasks |
SOUL_EOF
echo -e "  ${GREEN}✓ SOUL.md created${NC}"
else
echo -e "  ${GREEN}✓ SOUL.md exists, skipping${NC}"
fi

# IDENTITY.md
if [ ! -f IDENTITY.md ]; then
cat > IDENTITY.md << 'ID_EOF'
# IDENTITY.md — Identity

- **Name:** CEO Agent
- **Creature:** AI C-Suite Agent Cluster
- **Vibe:** Loyal, efficient, each role well-defined
- **Emoji:** 🏢
ID_EOF
echo -e "  ${GREEN}✓ IDENTITY.md created${NC}"
else
echo -e "  ${GREEN}✓ IDENTITY.md exists, skipping${NC}"
fi

# USER.md
if [ ! -f USER.md ]; then
cat > USER.md << 'USER_EOF'
# USER.md — About You

- **Name:** (your name)
- **Language:** English
- **Style:** Concise and efficient
USER_EOF
echo -e "  ${GREEN}✓ USER.md created${NC}"
else
echo -e "  ${GREEN}✓ USER.md exists, skipping${NC}"
fi

# memory directory
mkdir -p memory

# ---- Generate config ----
echo -e "${YELLOW}[2/4] Generating config...${NC}"

# Note: Consider using CLI commands (openclaw agents add / openclaw channels add)
# rather than editing JSON directly. This template is for quick-start reference.
# See: https://github.com/openclaw/openclaw#configuration

if [ -f "$CONFIG_DIR/$CONFIG_FILE" ]; then
    echo -e "  ${YELLOW}⚠ Config file already exists, skipping generation (to avoid overwriting your changes)${NC}"
    echo -e "  ${CYAN}↳ To regenerate, backup and delete first: mv $CONFIG_DIR/$CONFIG_FILE $CONFIG_DIR/${CONFIG_FILE}.bak${NC}"
    SKIP_CONFIG=true
else
    SKIP_CONFIG=false
fi

if $SKIP_CONFIG; then
    true  # Skip config generation

elif [ "$MODE_CHOICE" = "3" ]; then
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

elif [ "$MODE_CHOICE" = "2" ]; then
# ==================== Feishu/Lark Single-Bot Mode ====================
# Feishu Bots can't @-trigger each other (unlike Discord), so single-bot + sessions_spawn is best.
# Architecture: 1 Bot (Chief of Staff) + sessions_spawn for background dispatch
# - User only needs 1 Feishu app (Chief of Staff)
# - All agents are retained, collaborating via sessions_spawn in the background
# - User sees only one Bot; the entire C-Suite works behind the scenes
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
        "identity": { "theme": "You are the Chief of Staff for the CEO's AI C-Suite. Your role is to PLAN and DISPATCH — not execute directly. Be concise and decisive.\n\n[Core Principle] Beyond casual chat and simple Q&A, ALL work tasks (coding, research, analysis, writing, ops, etc.) must be dispatched via sessions_spawn to the appropriate department. You are the commander, not the grunt.\n\n[Department Roles] strategy=Strategic decisions, audit=Code review & QA, engineering=Development, finance=Financial analysis, marketing=Branding & content, operations=DevOps & infrastructure, hr=Project management, legal=Compliance & IP, research=Research & documentation.\n\n[Delegation Pattern] Use sessions_spawn to dispatch tasks with: [Role] + [Task] + [Context] + [Requirements] + [Output format]. Report results proactively.\n\n[Approval Flow] Code commits → spawn audit for review. Major decisions (budget, architecture, direction changes) → spawn strategy for review. Audit can reject with reasons. Strategy has veto power.\n\n[When to answer yourself] Only: casual chat, confirming info, progress updates, asking clarifying questions. Everything else gets delegated." },
        "sandbox": { "mode": "off" },
        "subagents": {
          "allowAgents": ["strategy", "audit", "engineering", "finance", "marketing", "operations", "hr", "legal", "research"]
        }
      },
      { "id": "strategy", "name": "Strategy Board", "model": { "primary": "your-provider/strong-model" }, "identity": { "theme": "You are the Chief Strategy Officer. Strategic decisions, planning, high-level reviews. Answer in English." }, "sandbox": { "mode": "off" } },
      { "id": "audit", "name": "Audit Office", "model": { "primary": "your-provider/strong-model" }, "identity": { "theme": "You are the Chief Audit Officer. Code review, QA, security assessment. Answer in English." }, "sandbox": { "mode": "all", "scope": "agent" } },
      { "id": "engineering", "name": "Engineering", "model": { "primary": "your-provider/strong-model" }, "identity": { "theme": "You are the VP of Engineering. Software dev, system architecture. Answer in English." }, "sandbox": { "mode": "all", "scope": "agent" } },
      { "id": "finance", "name": "Finance", "model": { "primary": "your-provider/strong-model" }, "identity": { "theme": "You are the CFO. Financial analysis, cost management. Answer in English." }, "sandbox": { "mode": "off" } },
      { "id": "marketing", "name": "Marketing", "model": { "primary": "your-provider/fast-model" }, "identity": { "theme": "You are the CMO. Brand strategy, content creation. Answer in English." }, "sandbox": { "mode": "off" } },
      { "id": "operations", "name": "Operations", "model": { "primary": "your-provider/fast-model" }, "identity": { "theme": "You are the COO. DevOps, server infrastructure, CI/CD. Answer in English." }, "sandbox": { "mode": "off" } },
      { "id": "hr", "name": "HR", "model": { "primary": "your-provider/fast-model" }, "identity": { "theme": "You are the VP of HR. Project management, team coordination. Answer in English." }, "sandbox": { "mode": "off" } },
      { "id": "legal", "name": "Legal", "model": { "primary": "your-provider/fast-model" }, "identity": { "theme": "You are the General Counsel. Compliance, contracts, IP. Answer in English." }, "sandbox": { "mode": "off" } },
      { "id": "research", "name": "Research", "model": { "primary": "your-provider/strong-model" }, "identity": { "theme": "You are the Chief Research Officer. Academic research, documentation, tech surveys. Answer in English." }, "sandbox": { "mode": "off" } }
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
        "identity": { "theme": "You are the Chief of Staff for the CEO's AI C-Suite. Your role is to PLAN and DISPATCH — not execute directly. Be concise and decisive.\n\n[Core Principle] Beyond casual chat and simple Q&A, ALL work tasks (coding, research, analysis, writing, ops, etc.) must be dispatched by @mentioning the appropriate department bot in the current channel, keeping all workflow visible. You are the commander, not the grunt.\n\n[Department Roles] strategy=Strategic decisions, audit=Code review & QA, engineering=Development, finance=Financial analysis, marketing=Branding & content, operations=DevOps & infrastructure, hr=Project management, legal=Compliance & IP, research=Research & documentation.\n\n[Delegation Pattern] Use the message tool to send messages in the current Discord channel, @mentioning the department bot with: [Role] + [Task] + [Context] + [Requirements] + [Output format]. Do NOT use sessions_spawn secretly — all work must be visible in the channel.\n\n[Approval Flow] Code commits → @audit for review. Major decisions (budget, architecture, direction changes) → @strategy for review. Audit can reject with reasons. Strategy has veto power.\n\n[When to answer yourself] Only: casual chat, confirming info, progress updates, asking clarifying questions. Everything else gets delegated." },
        "sandbox": { "mode": "off" },
        "subagents": {
          "allowAgents": ["strategy", "audit", "engineering", "finance", "marketing", "operations", "hr", "legal", "research"]
        }
      },
      {
        "id": "strategy",
        "name": "Strategy Board",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the Chief Strategy Officer. Strategic decisions, planning, high-level reviews. Analyze pros and cons from multiple angles and give clear recommendations. Break complex problems into actionable steps. [Review Mandate] When major decisions (budget, architecture changes, strategic direction) are submitted for review, independently assess feasibility, risks, and alternatives. Give clear approve/reject/modify recommendations. You have veto power over unreasonable proposals. Report decisions and execution paths proactively." },
        "sandbox": { "mode": "off" }
      },
      {
        "id": "audit",
        "name": "Audit Office",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the Chief Audit Officer. Code review, QA, security assessment. When reviewing code, focus on security vulnerabilities, performance issues, and best practices. When auditing projects, check for schedule deviations, resource waste, and risk factors. Be direct about problems and give specific improvement suggestions. [Auto-Review] When other departments submit code/PRs for review, check each one and give pass/reject conclusions. Rejections must include specific reasons and fix suggestions." },
        "sandbox": { "mode": "all", "scope": "agent" }
      },
      {
        "id": "engineering",
        "name": "Engineering",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the VP of Engineering. Software development, system architecture, code review. Direct solutions, not lectures. Report results proactively. If you need other departments, use sessions_send to notify them." },
        "sandbox": { "mode": "all", "scope": "agent" }
      },
      {
        "id": "finance",
        "name": "Finance",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the CFO. Financial analysis, cost management, e-commerce operations. Numbers first, opinions second. Report data summaries and key findings proactively. Alert on unusual spending." },
        "sandbox": { "mode": "off" }
      },
      {
        "id": "marketing",
        "name": "Marketing",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the CMO. Brand strategy, social media, content creation. Creative but practical. Report content summaries proactively." },
        "sandbox": { "mode": "off" }
      },
      {
        "id": "operations",
        "name": "Operations",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the COO. DevOps, server infrastructure, CI/CD. Hands-on and practical. Report execution results and system status proactively. Alert on service anomalies." },
        "sandbox": { "mode": "off" }
      },
      {
        "id": "hr",
        "name": "HR",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the VP of HR. Project management, team coordination. Well-organized and clear. Report progress and action items proactively." },
        "sandbox": { "mode": "off" }
      },
      {
        "id": "legal",
        "name": "Legal",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the General Counsel. Compliance, contracts, IP, legal review. Precise and professional. Report review conclusions and risk items proactively. Alert on compliance issues." },
        "sandbox": { "mode": "off" }
      },
      {
        "id": "research",
        "name": "Research",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the Chief Research Officer. Academic research, knowledge management, documentation, technical surveys. Academically rigorous yet accessible. Break complex concepts into clear knowledge frameworks. Write tutorials and technical docs. Report research findings and key takeaways proactively." },
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
echo -e "  ${GREEN}✓ Discord Multi-Bot config generated${NC}"
fi

# ---- Optional: Install Dashboard Web UI ----
echo -e "${YELLOW}[3/4] Dashboard Web UI...${NC}"
if [ "$INSTALL_GUI" = "yes" ]; then
    REPO_URL="https://github.com/wanikua/become-ceo"
    GUI_DIR="$WORKSPACE/gui"
    if [ -d "$GUI_DIR" ]; then
        echo -e "  ${GREEN}✓ gui/ directory already exists, skipping clone${NC}"
    else
        echo -e "  ${CYAN}Downloading Dashboard...${NC}"
        # Use mktemp for safe temp directory (avoids symlink race conditions)
        CEO_GUI_TMP=$(mktemp -d /tmp/ceo_gui_XXXXXX)
        git clone --depth 1 --filter=blob:none --sparse "$REPO_URL" "$CEO_GUI_TMP" 2>/dev/null || true
        cd "$CEO_GUI_TMP" && git sparse-checkout set gui 2>/dev/null || true
        if [ -d "$CEO_GUI_TMP/gui" ]; then
            cp -r "$CEO_GUI_TMP/gui" "$GUI_DIR"
            rm -rf "$CEO_GUI_TMP"
            echo -e "  ${GREEN}✓ Dashboard downloaded to $GUI_DIR${NC}"
        else
            rm -rf "$CEO_GUI_TMP"
            echo -e "  ${YELLOW}⚠ Dashboard download failed, can be installed manually later${NC}"
        fi
    fi
    # Install dependencies
    if [ -d "$GUI_DIR" ] && [ -f "$GUI_DIR/package.json" ]; then
        cd "$GUI_DIR"
        if command -v npm &>/dev/null; then
            npm install --silent 2>/dev/null && echo -e "  ${GREEN}✓ Dashboard dependencies installed${NC}" || echo -e "  ${YELLOW}⚠ npm install failed, please run manually: cd $GUI_DIR && npm install${NC}"
        fi
        cd "$WORKSPACE"
    fi
else
    echo -e "  ${CYAN}Skipping Dashboard install (use --with-gui to include it)${NC}"
fi

# ---- Done ----
echo -e "${YELLOW}[4/4] Setup complete!${NC}"
echo ""
echo "================================"
echo -e "${GREEN}🎉 Workspace initialized!${NC}"
echo "================================"
echo ""
echo -e "  Workspace:  ${CYAN}$WORKSPACE${NC}"
echo -e "  Config:     ${CYAN}$CONFIG_DIR/$CONFIG_FILE${NC}"
echo ""

if [ "$MODE_CHOICE" = "3" ]; then
echo -e "  ${YELLOW}Next steps (3):${NC}"
echo ""
echo "  1. Edit config, add your LLM API Key:"
echo "     nano $CONFIG_DIR/$CONFIG_FILE"
echo ""
echo "  2. Start the Gateway:"
echo "     $CLI_CMD gateway --verbose"
echo ""
echo "  3. Open WebUI in your browser:"
echo "     http://localhost:18789"
echo ""
elif [ "$MODE_CHOICE" = "2" ]; then
echo -e "  ${YELLOW}Next steps (3):${NC}"
echo ""
echo "  1. Edit config, add your LLM API Key:"
echo "     nano $CONFIG_DIR/$CONFIG_FILE"
echo ""
echo "  2. Create a Feishu/Lark app (just 1: Chief of Staff):"
echo "     a) Go to https://open.feishu.cn/app"
echo "     b) Create app (e.g. 'CEO-Chief-of-Staff') → copy App ID and App Secret"
echo "     c) Permissions → add im:message and other required permissions"
echo "     d) Enable bot capability, add im.message.receive_v1 event"
echo "     e) Event delivery: choose WebSocket long connection"
echo "     f) Paste appId/appSecret into the config file under 'main'"
echo "     g) Create version and publish the app"
echo ""
echo "  3. Start the Gateway:"
echo "     $CLI_CMD gateway --verbose"
echo ""
else
echo -e "  ${YELLOW}Next steps (3):${NC}"
echo ""
echo "  1. Edit config, add your LLM API Key:"
echo "     nano $CONFIG_DIR/$CONFIG_FILE"
echo ""
echo "  2. Create Discord Bots (one per agent):"
echo "     a) Go to https://discord.com/developers/applications"
echo "     b) New Application → Bot → copy Token"
echo "     c) Repeat for each department (or start with just Chief of Staff)"
echo "     d) Paste each token into $CONFIG_FILE under accounts"
echo "     e) Enable Message Content Intent on each bot"
echo "     f) Invite all bots to your Discord server"
echo ""
echo "  3. Start the Gateway:"
echo "     $CLI_CMD gateway --verbose"
echo ""
fi

echo -e "${CYAN}💡 Troubleshooting:${NC}"
echo "  Config errors? Run: $CLI_CMD doctor --fix"
echo ""
echo -e "Full guide: ${BLUE}https://github.com/wanikua/become-ceo${NC}"
echo ""
