#!/bin/bash
# ============================================
# AI Team — One-click setup
# Ubuntu 22.04/24.04 (Oracle Cloud ARM recommended)
# ============================================
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}AI Team Setup${NC}"
echo "================================"
echo ""

# ---- 1. System update ----
echo -e "${YELLOW}[1/7] Updating system...${NC}"
sudo apt-get update -qq

# ---- 2. Firewall (Oracle Cloud) ----
echo -e "${YELLOW}[2/7] Configuring firewall...${NC}"
sudo iptables -D INPUT -j REJECT --reject-with icmp-host-prohibited 2>/dev/null || true
sudo iptables -D FORWARD -j REJECT --reject-with icmp-host-prohibited 2>/dev/null || true
sudo netfilter-persistent save 2>/dev/null || true
echo -e "  ${GREEN}✓ Firewall configured${NC}"

# ---- 3. Swap ----
echo -e "${YELLOW}[3/7] Setting up swap...${NC}"
if [ ! -f /swapfile ]; then
    sudo fallocate -l 4G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab > /dev/null
    echo -e "  ${GREEN}✓ 4GB swap created${NC}"
else
    echo -e "  ${GREEN}✓ Swap already exists${NC}"
fi

# ---- 4. Node.js ----
echo -e "${YELLOW}[4/7] Installing Node.js 22...${NC}"
if command -v node &>/dev/null && [[ "$(node -v)" == v22* ]]; then
    echo -e "  ${GREEN}✓ Node.js $(node -v) already installed${NC}"
else
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - > /dev/null 2>&1
    sudo apt-get install -y nodejs -qq
    echo -e "  ${GREEN}✓ Node.js $(node -v) installed${NC}"
fi

# ---- 5. GitHub CLI ----
echo -e "${YELLOW}[5/7] Installing GitHub CLI...${NC}"
if command -v gh &>/dev/null; then
    echo -e "  ${GREEN}✓ gh already installed${NC}"
else
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg 2>/dev/null
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt-get update -qq && sudo apt-get install gh -y -qq
    echo -e "  ${GREEN}✓ gh CLI installed${NC}"
fi

# ---- 6. Clawdbot ----
echo -e "${YELLOW}[6/7] Installing Clawdbot...${NC}"
sudo npm install -g clawdbot --loglevel=error
echo -e "  ${GREEN}✓ Clawdbot $(clawdbot --version 2>/dev/null) installed${NC}"

# ---- 7. Workspace ----
echo -e "${YELLOW}[7/7] Setting up workspace...${NC}"
WORKSPACE="$HOME/clawd"
CONFIG_DIR="$HOME/.clawdbot"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$WORKSPACE/memory"
mkdir -p "$CONFIG_DIR"

for f in SOUL.md IDENTITY.md USER.md AGENTS.md; do
    if [ ! -f "$WORKSPACE/$f" ] && [ -f "$SCRIPT_DIR/../references/$f" ]; then
        cp "$SCRIPT_DIR/../references/$f" "$WORKSPACE/$f"
        echo -e "  ${GREEN}✓ $f created${NC}"
    fi
done

if [ ! -f "$CONFIG_DIR/clawdbot.json" ]; then
    cp "$SCRIPT_DIR/../references/clawdbot-template.json" "$CONFIG_DIR/clawdbot.json"
    sed -i "s|\$HOME|$HOME|g" "$CONFIG_DIR/clawdbot.json"
    echo -e "  ${GREEN}✓ clawdbot.json template created${NC}"
fi

echo -e "${YELLOW}Installing gateway service...${NC}"
clawdbot gateway install 2>/dev/null \
    && echo -e "  ${GREEN}✓ Gateway service installed (auto-starts on boot)${NC}" \
    || echo -e "  ${YELLOW}⚠ Run 'clawdbot gateway install' after filling in config${NC}"

echo ""
echo "================================"
echo -e "${GREEN}Setup complete!${NC}"
echo "================================"
echo ""
echo "Next steps:"
echo ""
echo -e "  ${YELLOW}1.${NC} Edit ~/.clawdbot/clawdbot.json"
echo "     Add your Anthropic API Key + Discord Bot Tokens"
echo ""
echo -e "  ${YELLOW}2.${NC} Each Discord bot: enable Message Content Intent + Server Members Intent"
echo ""
echo -e "  ${YELLOW}3.${NC} systemctl --user start clawdbot-gateway"
echo ""
echo -e "  Docs: ${BLUE}https://github.com/wanikua/ai-team-skill${NC}"
echo ""
