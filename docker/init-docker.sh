#!/bin/bash
set -e

# ============================================
# 🏢 Become CEO — Docker Initialization Script
# ============================================
# Usage:
#   docker compose exec ceo /init-docker.sh
#   docker compose run --rm ceo /init-docker.sh
# ============================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

CONFIG_DIR="${OPENCLAW_CONFIG_DIR:-$HOME/.openclaw}"
CONFIG_FILE="$CONFIG_DIR/openclaw.json"
WORKSPACE="${OPENCLAW_WORKSPACE:-$HOME/clawd}"

echo ""
echo -e "${CYAN}🏢 Become CEO — Docker Setup Wizard${NC}"
echo "================================"
echo ""

# ---- Step 1: Choose deployment mode ----
echo -e "${YELLOW}📋 Step 1/4: Choose deployment mode${NC}"
echo ""
echo "  1) Single Agent (Chief of Staff) — simplest mode, one Bot handles everything"
echo "  2) Full C-Suite (10 Agents) — Chief of Staff dispatches, each department executes"
echo ""
read -p "Choose [1/2, default 1]: " MODE
MODE=${MODE:-1}

# ---- Step 2: Choose platform ----
echo ""
echo -e "${YELLOW}📋 Step 2/4: Choose platform${NC}"
echo ""
echo "  1) Discord (recommended)"
echo "  2) Feishu / Lark (China)"
echo "  3) WebUI only (no Bot needed)"
echo ""
read -p "Choose [1/2/3, default 1]: " PLATFORM
PLATFORM=${PLATFORM:-1}

# ---- Step 3: Configure model ----
echo ""
echo -e "${YELLOW}📋 Step 3/4: Configure AI model${NC}"
echo ""
echo "  Popular API providers:"
echo "  - Anthropic Claude: https://console.anthropic.com"
echo "  - OpenAI: https://platform.openai.com"
echo "  - DeepSeek: https://platform.deepseek.com"
echo "  - OpenRouter: https://openrouter.ai"
echo ""
read -p "API Base URL (e.g. https://api.deepseek.com/v1): " API_URL
read -p "API Key: " API_KEY
read -p "Model ID (e.g. deepseek-chat, gpt-4o, claude-sonnet-4-20250514): " MODEL_ID

if [ -z "$API_URL" ] || [ -z "$API_KEY" ] || [ -z "$MODEL_ID" ]; then
    echo -e "${RED}✗ API configuration cannot be empty${NC}"
    exit 1
fi

# Auto-detect API format
API_FORMAT="openai"
if echo "$API_URL" | grep -qi "anthropic"; then
    API_FORMAT="anthropic-messages"
fi

# ---- Step 4: Configure platform ----
echo ""
echo -e "${YELLOW}📋 Step 4/4: Configure platform credentials${NC}"
echo ""

CHANNEL_CONFIG=""
BINDINGS=""

if [ "$PLATFORM" = "1" ]; then
    echo "Discord Bot setup:"
    echo "  1. Go to https://discord.com/developers/applications and create a Bot"
    echo "  2. Enable Message Content Intent + Server Members Intent"
    echo "  3. Invite the Bot to your server"
    echo ""
    read -p "Discord Bot Token: " BOT_TOKEN
    if [ -z "$BOT_TOKEN" ]; then
        echo -e "${RED}✗ Bot Token cannot be empty${NC}"
        exit 1
    fi
    APP_ID=""
    APP_SECRET=""

elif [ "$PLATFORM" = "2" ]; then
    echo "Feishu / Lark setup:"
    echo "  1. Go to https://open.feishu.cn/app and create an app"
    echo "  2. Add the Bot capability"
    echo "  3. Set event callback URL: http://YOUR_IP:18789/webhooks/feishu"
    echo ""
    read -p "App ID: " APP_ID
    read -p "App Secret: " APP_SECRET
    if [ -z "$APP_ID" ] || [ -z "$APP_SECRET" ]; then
        echo -e "${RED}✗ App ID and App Secret cannot be empty${NC}"
        exit 1
    fi
    BOT_TOKEN=""

elif [ "$PLATFORM" = "3" ]; then
    echo -e "${GREEN}WebUI mode needs no extra config. After startup, visit http://localhost:18789${NC}"
    BOT_TOKEN=""
    APP_ID=""
    APP_SECRET=""
fi

# ---- Generate config ----
echo ""
echo -e "${CYAN}⚙️ Generating config file...${NC}"

mkdir -p "$CONFIG_DIR"

# Use Python to generate valid JSON (avoids heredoc escaping and comma issues)
python3 << PYEOF
import json, sys

config = {
    "models": {
        "providers": {
            "provider": {
                "baseUrl": "$API_URL",
                "apiKey": "$API_KEY",
                "api": "$API_FORMAT",
                "models": [{
                    "id": "$MODEL_ID", "name": "$MODEL_ID",
                    "input": ["text", "image"], "contextWindow": 200000, "maxTokens": 8192
                }]
            }
        }
    },
    "agents": {
        "defaults": {
            "workspace": "$WORKSPACE",
            "model": {"primary": "provider/$MODEL_ID"},
            "sandbox": {"mode": "non-main"}
        },
        "list": [{
            "id": "chief-of-staff",
            "name": "Chief of Staff",
            "model": {"primary": "provider/$MODEL_ID"},
            "identity": {"theme": ""},
            "sandbox": {"mode": "off"}
        }]
    },
    "bindings": []
}

# Set identity based on mode
mode = "$MODE"
if mode == "2":
    config["agents"]["list"][0]["identity"]["theme"] = "You are the Chief of Staff for the CEO's AI C-Suite. Your role is to plan and dispatch — not execute directly. Use sessions_spawn to delegate tasks to the appropriate department."
    config["agents"]["list"][0]["subagents"] = {
        "allowAgents": ["strategy","audit","engineering","finance","marketing","operations","hr","legal","research"]
    }
    departments = [
        ("strategy", "Strategy Board", "You are the Chief Strategy Officer. You specialize in strategic decisions, planning, and high-level reviews. Answer in English.", "off"),
        ("audit", "Audit Office", "You are the Chief Audit Officer. You specialize in monitoring, code review, and quality assurance. Answer in English.", "all"),
        ("engineering", "Engineering", "You are the VP of Engineering. You specialize in software development and system architecture. Answer in English.", "all"),
        ("finance", "Finance", "You are the CFO. You specialize in financial analysis and cost management. Answer in English.", "off"),
        ("marketing", "Marketing", "You are the CMO. You specialize in brand strategy and content creation. Answer in English.", "off"),
        ("operations", "Operations", "You are the COO. You specialize in DevOps and server infrastructure. Answer in English.", "off"),
        ("hr", "HR", "You are the VP of HR. You specialize in project management and team coordination. Answer in English.", "off"),
        ("legal", "Legal", "You are the General Counsel. You specialize in compliance and intellectual property. Answer in English.", "off"),
        ("research", "Research", "You are the Chief Research Officer. You specialize in academic research, knowledge management, and documentation. Answer in English.", "off"),
    ]
    for did, dname, dtheme, smode in departments:
        agent = {"id": did, "name": dname, "identity": {"theme": dtheme}, "sandbox": {"mode": smode}}
        if smode == "all":
            agent["sandbox"]["scope"] = "agent"
        config["agents"]["list"].append(agent)
else:
    config["agents"]["list"][0]["identity"]["theme"] = "You are the Chief of Staff for the CEO's AI C-Suite. You are loyal, efficient, and direct. Answer in English."

# Platform config
platform = "$PLATFORM"
if platform == "1":
    config["channels"] = {"discord": {
        "enabled": True, "groupPolicy": "open", "allowBots": True,
        "accounts": {"chief-of-staff": {"botName": "Chief of Staff", "token": "$BOT_TOKEN", "groupPolicy": "open"}}
    }}
    config["bindings"] = [{"agentId": "chief-of-staff", "match": {"channel": "discord", "accountId": "chief-of-staff"}}]
elif platform == "2":
    config["channels"] = {"feishu": {
        "enabled": True,
        "accounts": {"chief-of-staff": {"botName": "Chief of Staff", "appId": "$APP_ID", "appSecret": "$APP_SECRET"}}
    }}
    config["bindings"] = [{"agentId": "chief-of-staff", "match": {"channel": "feishu", "accountId": "chief-of-staff"}}]
else:
    config["bindings"] = [{"agentId": "chief-of-staff", "match": {}}]

with open("$CONFIG_FILE", "w") as f:
    json.dump(config, f, indent=2, ensure_ascii=False)
PYEOF

echo -e "${GREEN}✓ Config file generated: $CONFIG_FILE${NC}"

# ---- Initialize workspace ----
mkdir -p "$WORKSPACE/memory" "$WORKSPACE/skills"

if [ ! -f "$WORKSPACE/SOUL.md" ]; then
cat > "$WORKSPACE/SOUL.md" << 'EOF'
# SOUL.md - CEO Operating Principles

## Core Rules
1. Cut the fluff — get to the point
2. Report promptly — done means communicated
3. Be reliable — think first, then act

## Communication Style
- English by default
- Lead with conclusions, expand on details when needed
EOF
echo -e "${GREEN}✓ SOUL.md created${NC}"
fi

if [ ! -f "$WORKSPACE/USER.md" ]; then
    read -p "What should the AI call you? (default: Boss): " NICKNAME
    NICKNAME=${NICKNAME:-Boss}
    cat > "$WORKSPACE/USER.md" << EOF
# USER.md - About You

- **Name:** $NICKNAME
- **Language:** English
- **Style:** Concise and efficient
EOF
    echo -e "${GREEN}✓ USER.md created${NC}"
fi

# ---- Done ----
echo ""
echo "================================"
echo -e "${GREEN}🎉 Setup complete!${NC}"
echo "================================"
echo ""
echo "  Config file: $CONFIG_FILE"
echo "  Workspace:   $WORKSPACE"
echo ""
if [ "$PLATFORM" = "1" ]; then
    echo "  Next step: @mention your Bot in Discord"
elif [ "$PLATFORM" = "2" ]; then
    echo "  Next step: Send a message to the Bot in Feishu"
else
    echo "  Next step: Open http://localhost:18789"
fi
echo ""
echo "  Restart the container to apply config:"
echo "    docker compose restart"
echo ""
