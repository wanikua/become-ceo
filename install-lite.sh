#!/bin/bash
# ============================================
# Become CEO — Lite Setup (already have OpenClaw/Clawdbot)
# Skips system dependencies, only initializes workspace + config
# ============================================
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

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
echo "  1) Discord Multi-Bot (full 7-agent team, requires Discord Bots)"
echo "  2) WebUI Only (no Discord needed, browser-based)"
echo ""
read -p "Choose [1/2] (default 1): " MODE_CHOICE
MODE_CHOICE=${MODE_CHOICE:-1}

echo ""

# ---- Initialize workspace ----
echo -e "${YELLOW}[1/3] Initializing workspace...${NC}"
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
# SOUL.md — Team Behavioral Norms

## Core Rules
1. Be concise — lead with conclusions
2. Report proactively — don't wait to be asked
3. Think before acting — plan, then execute

## Communication Style
- English, professional but not stuffy
- Direct answers first, details on request
SOUL_EOF
echo -e "  ${GREEN}✓ SOUL.md created${NC}"
else
echo -e "  ${GREEN}✓ SOUL.md exists, skipping${NC}"
fi

# IDENTITY.md
if [ ! -f IDENTITY.md ]; then
cat > IDENTITY.md << 'ID_EOF'
# IDENTITY.md — Organization Chart

## Model Tiers
| Tier | Model | Usage |
|---|---|---|
| Coordination | Fast Model | Daily chat, quick responses |
| Heavy Lifting | Strong Model | Coding, deep analysis |
| Budget (optional) | Economy Model | Lightweight tasks |

## Team
- Engineering: Software architecture, code review
- Finance: Budget analysis, cost tracking
- Marketing: Brand, content, social media
- DevOps: Infrastructure, CI/CD, servers
- Management: Project coordination, team ops
- Legal: Compliance, contracts, IP
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
echo -e "${YELLOW}[2/3] Generating config...${NC}"

if [ -f "$CONFIG_DIR/$CONFIG_FILE" ]; then
    echo -e "  ${YELLOW}⚠ Config exists, backing up to ${CONFIG_FILE}.bak${NC}"
    cp "$CONFIG_DIR/$CONFIG_FILE" "$CONFIG_DIR/${CONFIG_FILE}.bak"
fi

if [ "$MODE_CHOICE" = "2" ]; then
# ==================== WebUI Only Mode ====================
cat > "$CONFIG_DIR/$CONFIG_FILE" << CONFIG_EOF
{
  "models": {
    "providers": {
      "your-provider": {
        "baseUrl": "https://your-llm-provider-api-url",
        "apiKey": "YOUR_LLM_API_KEY",
        "api": "your-api-format",
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
        "identity": { "theme": "You are the Chief of Staff. Handle daily tasks, delegate to specialists. Be concise and decisive." }
      }
    ]
  }
}
CONFIG_EOF
echo -e "  ${GREEN}✓ WebUI mode config generated${NC}"

else
# ==================== Discord Multi-Bot Mode ====================
cat > "$CONFIG_DIR/$CONFIG_FILE" << CONFIG_EOF
{
  "models": {
    "providers": {
      "your-provider": {
        "baseUrl": "https://your-llm-provider-api-url",
        "apiKey": "YOUR_LLM_API_KEY",
        "api": "your-api-format",
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
        "identity": { "theme": "You are the Chief of Staff. Route tasks to specialists using sessions_spawn. Delegate pattern: [Role] + [Task] + [Context] + [Requirements] + [Output format]. Report results proactively." },
        "sandbox": { "mode": "off" },
        "subagents": {
          "allowAgents": ["engineering", "finance", "marketing", "devops", "management", "legal"],
          "maxConcurrent": 8
        },
        "runTimeoutSeconds": 600
      },
      {
        "id": "engineering",
        "name": "Engineering",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the Engineering lead. Software architecture, code review, system design. Direct solutions, not lectures." },
        "sandbox": { "mode": "all", "scope": "agent" },
        "subagents": { "allowAgents": ["devops"] },
        "runTimeoutSeconds": 300
      },
      {
        "id": "finance",
        "name": "Finance",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the Finance lead. Budgets, cost analysis, spend tracking. Numbers first, opinions second." },
        "sandbox": { "mode": "all", "scope": "agent" },
        "runTimeoutSeconds": 300
      },
      {
        "id": "marketing",
        "name": "Marketing",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the Marketing lead. Branding, content, social media. Creative but practical." },
        "sandbox": { "mode": "all", "scope": "agent" },
        "runTimeoutSeconds": 300
      },
      {
        "id": "devops",
        "name": "DevOps",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the DevOps lead. Servers, CI/CD, infrastructure, deployments. Automate everything." },
        "sandbox": { "mode": "all", "scope": "agent" },
        "subagents": { "allowAgents": ["engineering"] },
        "runTimeoutSeconds": 300
      },
      {
        "id": "management",
        "name": "Management",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the Management lead. Project coordination, hiring, team ops. Keep things organized." },
        "sandbox": { "mode": "all", "scope": "agent" },
        "subagents": { "allowAgents": ["engineering", "finance", "marketing", "devops", "legal"] },
        "runTimeoutSeconds": 300
      },
      {
        "id": "legal",
        "name": "Legal",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the Legal lead. Compliance, contracts, IP. Precise, flag real risks." },
        "sandbox": { "mode": "all", "scope": "agent" },
        "runTimeoutSeconds": 300
      }
    ]
  },
  "channels": {
    "discord": {
      "enabled": true,
      "groupPolicy": "open",
      "allowBots": true,
      "accounts": {
        "main":        { "name": "Chief of Staff", "token": "YOUR_MAIN_BOT_TOKEN",        "groupPolicy": "open" },
        "engineering": { "name": "Engineering",    "token": "YOUR_ENGINEERING_BOT_TOKEN",  "groupPolicy": "open" },
        "finance":     { "name": "Finance",        "token": "YOUR_FINANCE_BOT_TOKEN",      "groupPolicy": "open" },
        "marketing":   { "name": "Marketing",      "token": "YOUR_MARKETING_BOT_TOKEN",    "groupPolicy": "open" },
        "devops":      { "name": "DevOps",         "token": "YOUR_DEVOPS_BOT_TOKEN",       "groupPolicy": "open" },
        "management":  { "name": "Management",     "token": "YOUR_MANAGEMENT_BOT_TOKEN",   "groupPolicy": "open" },
        "legal":       { "name": "Legal",          "token": "YOUR_LEGAL_BOT_TOKEN",        "groupPolicy": "open" }
      }
    }
  },
  "bindings": [
    { "agentId": "main",        "match": { "channel": "discord", "accountId": "main" } },
    { "agentId": "engineering", "match": { "channel": "discord", "accountId": "engineering" } },
    { "agentId": "finance",     "match": { "channel": "discord", "accountId": "finance" } },
    { "agentId": "marketing",   "match": { "channel": "discord", "accountId": "marketing" } },
    { "agentId": "devops",      "match": { "channel": "discord", "accountId": "devops" } },
    { "agentId": "management",  "match": { "channel": "discord", "accountId": "management" } },
    { "agentId": "legal",       "match": { "channel": "discord", "accountId": "legal" } }
  ]
}
CONFIG_EOF
echo -e "  ${GREEN}✓ Discord Multi-Bot config generated${NC}"
fi

# ---- Done ----
echo -e "${YELLOW}[3/3] Setup complete!${NC}"
echo ""
echo "================================"
echo -e "${GREEN}🎉 Workspace initialized!${NC}"
echo "================================"
echo ""
echo -e "  Workspace:  ${CYAN}$WORKSPACE${NC}"
echo -e "  Config:     ${CYAN}$CONFIG_DIR/$CONFIG_FILE${NC}"
echo ""

if [ "$MODE_CHOICE" = "2" ]; then
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
else
echo -e "  ${YELLOW}Next steps (3):${NC}"
echo ""
echo "  1. Edit config, add your LLM API Key:"
echo "     nano $CONFIG_DIR/$CONFIG_FILE"
echo ""
echo "  2. Create Discord Bots (one per agent):"
echo "     a) Go to https://discord.com/developers/applications"
echo "     b) New Application → Bot → copy Token"
echo "     c) Paste each token into $CONFIG_FILE under accounts"
echo "     d) Enable Message Content Intent on each bot"
echo "     e) Invite all bots to your Discord server"
echo ""
echo "  3. Start the Gateway:"
echo "     $CLI_CMD gateway --verbose"
echo ""
fi
echo -e "Full guide: ${BLUE}https://github.com/wanikua/become-ceo${NC}"
echo -e "OpenClaw:   ${BLUE}https://github.com/openclaw/openclaw${NC}"
echo ""
