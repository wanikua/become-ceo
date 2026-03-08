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
    if [[ "$ARCH" == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    echo -e "  ${GREEN}✓ Homebrew installed${NC}"
fi

# ---- 2. Node.js ----
echo -e "${YELLOW}[2/5] Checking Node.js...${NC}"
if command -v node &>/dev/null && [[ "$(node -v | cut -d. -f1)" == "v22" || "$(node -v | cut -d. -f1)" == "v20" ]]; then
    echo -e "  ${GREEN}✓ Node.js $(node -v) installed${NC}"
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
    npm install -g openclaw@latest 2>/dev/null || npm install -g clawdbot@latest
    if command -v openclaw &>/dev/null; then
        CLI_CMD="openclaw"
        CONFIG_DIR="$HOME/.openclaw"
        CONFIG_FILE="openclaw.json"
    else
        CLI_CMD="clawdbot"
        CONFIG_DIR="$HOME/.clawdbot"
        CONFIG_FILE="clawdbot.json"
    fi
    echo -e "  ${GREEN}✓ $CLI_CMD installed${NC}"
fi

# ---- 4. Optional tools ----
echo -e "${YELLOW}[4/5] Checking optional tools...${NC}"

# GitHub CLI
if command -v gh &>/dev/null; then
    echo -e "  ${GREEN}✓ GitHub CLI $(gh --version | head -1 | awk '{print $3}') installed${NC}"
else
    echo -e "  ${CYAN}→ Installing GitHub CLI...${NC}"
    brew install gh
    echo -e "  ${GREEN}✓ GitHub CLI installed${NC}"
fi

# Chromium (for browser automation)
if command -v chromium &>/dev/null || command -v "/Applications/Chromium.app/Contents/MacOS/Chromium" &>/dev/null || command -v "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" &>/dev/null; then
    echo -e "  ${GREEN}✓ Browser available for automation${NC}"
else
    echo -e "  ${CYAN}→ Installing Chromium...${NC}"
    brew install --cask chromium 2>/dev/null || echo -e "  ${YELLOW}⚠ Chromium cask not available — Chrome works too${NC}"
fi

# ---- 5. Workspace + Config ----
echo -e "${YELLOW}[5/5] Setting up workspace...${NC}"
WORKSPACE="$HOME/clawd"
mkdir -p "$WORKSPACE"
mkdir -p "$CONFIG_DIR"
cd "$WORKSPACE"

# Create workspace files if missing
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
echo -e "  ${GREEN}✓ SOUL.md exists${NC}"
fi

if [ ! -f IDENTITY.md ]; then
cat > IDENTITY.md << 'ID_EOF'
# IDENTITY.md — Organization Chart

## Team
- Chief of Staff (main): Task routing, daily standups
- Engineering: Software architecture, code review
- Finance: Budget analysis, cost tracking
- Marketing: Brand, content, social media
- DevOps: Infrastructure, CI/CD
- Management: Project coordination
- Legal: Compliance, contracts
ID_EOF
echo -e "  ${GREEN}✓ IDENTITY.md created${NC}"
else
echo -e "  ${GREEN}✓ IDENTITY.md exists${NC}"
fi

if [ ! -f USER.md ]; then
cat > USER.md << 'USER_EOF'
# USER.md — About You

- **Name:** (your name)
- **Language:** English
- **Timezone:** (your timezone)
USER_EOF
echo -e "  ${GREEN}✓ USER.md created${NC}"
else
echo -e "  ${GREEN}✓ USER.md exists${NC}"
fi

mkdir -p memory

# Generate config
if [ -f "$CONFIG_DIR/$CONFIG_FILE" ]; then
    echo -e "  ${YELLOW}⚠ Config exists, backing up to ${CONFIG_FILE}.bak${NC}"
    cp "$CONFIG_DIR/$CONFIG_FILE" "$CONFIG_DIR/${CONFIG_FILE}.bak"
fi

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
        "identity": { "theme": "You are the Chief of Staff. Route tasks to specialists. Be concise and decisive." },
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
        "identity": { "theme": "You are the Engineering lead. Direct solutions, not lectures." },
        "subagents": { "allowAgents": ["devops"] },
        "runTimeoutSeconds": 300
      },
      {
        "id": "finance",
        "name": "Finance",
        "model": { "primary": "your-provider/strong-model" },
        "identity": { "theme": "You are the Finance lead. Numbers first, opinions second." },
        "runTimeoutSeconds": 300
      },
      {
        "id": "marketing",
        "name": "Marketing",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the Marketing lead. Creative but practical." },
        "runTimeoutSeconds": 300
      },
      {
        "id": "devops",
        "name": "DevOps",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the DevOps lead. Automate everything." },
        "subagents": { "allowAgents": ["engineering"] },
        "runTimeoutSeconds": 300
      },
      {
        "id": "management",
        "name": "Management",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the Management lead. Keep things organized." },
        "subagents": { "allowAgents": ["engineering", "finance", "marketing", "devops", "legal"] },
        "runTimeoutSeconds": 300
      },
      {
        "id": "legal",
        "name": "Legal",
        "model": { "primary": "your-provider/fast-model" },
        "identity": { "theme": "You are the Legal lead. Precise, flag real risks." },
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

echo -e "  ${GREEN}✓ Config generated${NC}"

# ---- Done ----
echo ""
echo "================================"
echo -e "${GREEN}🎉 Become CEO — macOS setup complete!${NC}"
echo "================================"
echo ""
echo -e "  Workspace:  ${CYAN}$WORKSPACE${NC}"
echo -e "  Config:     ${CYAN}$CONFIG_DIR/$CONFIG_FILE${NC}"
echo ""
echo -e "  ${YELLOW}Next steps:${NC}"
echo ""
echo "  1. Edit config, add your LLM API Key:"
echo "     nano $CONFIG_DIR/$CONFIG_FILE"
echo ""
echo "  2. Create Discord Bots (one per agent):"
echo "     https://discord.com/developers/applications"
echo "     → Enable Message Content Intent on each bot"
echo ""
echo "  3. Start the Gateway:"
echo "     $CLI_CMD gateway --verbose"
echo ""
echo -e "Full guide: ${BLUE}https://github.com/wanikua/become-ceo${NC}"
echo -e "OpenClaw:   ${BLUE}https://github.com/openclaw/openclaw${NC}"
echo ""
