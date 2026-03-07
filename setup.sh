#!/bin/bash
# ============================================================
# Become CEO — One-Click Setup
# Supports: Ubuntu 22.04/24.04, Debian 12+, Amazon Linux 2023
# Architecture: amd64, arm64
# ============================================================

# ---- Strict mode ----
set -euo pipefail
trap 'on_error $LINENO' ERR

# ---- Colors & formatting ----
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# ---- Globals ----
REPO_RAW="https://raw.githubusercontent.com/wanikua/become-ceo/main/become-ceo/references"
WORKSPACE="${CLAWD_WORKSPACE:-$HOME/clawd}"
CONFIG_DIR="$HOME/.clawdbot"
LOG_FILE="/tmp/become-ceo-setup-$(date +%Y%m%d-%H%M%S).log"
STEP_CURRENT=0
STEP_TOTAL=0
ERRORS=()
WARNINGS=()
SKIP_INTERACTIVE="${SKIP_INTERACTIVE:-}"
DRY_RUN="${DRY_RUN:-}"
CHECK_ONLY="${CHECK_ONLY:-}"

# ---- Logging ----
log() { echo "[$(date '+%H:%M:%S')] $*" >> "$LOG_FILE"; }
log_cmd() { "$@" >> "$LOG_FILE" 2>&1; }

# ---- Error handler ----
on_error() {
    local line=$1
    echo ""
    echo -e "${RED}✗ Error on line $line${NC}"
    echo -e "  Log file: ${DIM}$LOG_FILE${NC}"
    echo -e "  Last 5 lines:"
    tail -5 "$LOG_FILE" 2>/dev/null | sed 's/^/    /'
    echo ""
    echo -e "${YELLOW}Need help? Open an issue:${NC}"
    echo -e "  ${BLUE}https://github.com/wanikua/become-ceo/issues${NC}"
    exit 1
}

# ---- Progress helpers ----
step() {
    STEP_CURRENT=$((STEP_CURRENT + 1))
    echo ""
    echo -e "${CYAN}[$STEP_CURRENT/$STEP_TOTAL]${NC} ${BOLD}$1${NC}"
    log "=== Step $STEP_CURRENT/$STEP_TOTAL: $1 ==="
}
ok()   { echo -e "  ${GREEN}✓${NC} $1"; log "  OK: $1"; }
warn() { echo -e "  ${YELLOW}⚠${NC} $1"; log "  WARN: $1"; WARNINGS+=("$1"); }
skip() { echo -e "  ${DIM}→ $1 (skipped)${NC}"; log "  SKIP: $1"; }
info() { echo -e "  ${DIM}$1${NC}"; }

# ---- Dry-run wrapper ----
# Use: run_cmd <description> <command...>
# In dry-run mode, prints what would happen instead of executing.
run_cmd() {
    local desc="$1"; shift
    if [ -n "$DRY_RUN" ]; then
        echo -e "  ${DIM}[dry-run] would run: $*${NC}"
        log "[dry-run] $desc: $*"
        return 0
    fi
    "$@"
}

# ---- Network connectivity check ----
check_network() {
    local urls=("https://deb.nodesource.com" "https://github.com" "https://registry.npmjs.org")
    local failed=()

    for url in "${urls[@]}"; do
        if ! curl -fsSL --connect-timeout 5 --max-time 10 "$url" -o /dev/null 2>/dev/null; then
            failed+=("$url")
        fi
    done

    if [ ${#failed[@]} -gt 0 ]; then
        warn "Cannot reach: ${failed[*]}"
        warn "Some downloads may fail. Check firewall/proxy settings."
        return 1
    fi
    return 0
}

# ---- API key format validation ----
validate_api_key() {
    local key="$1" provider="$2"
    [ -z "$key" ] && return 0  # Empty is OK (user skipped)

    case "$provider" in
        anthropic)
            if [[ ! "$key" =~ ^sk-ant- ]]; then
                echo -e "  ${YELLOW}⚠ Key doesn't look like an Anthropic key (expected sk-ant-...).${NC}"
                echo -e "  ${DIM}  Continuing anyway — double-check in your provider dashboard.${NC}"
                return 1
            fi
            ;;
        openai)
            if [[ ! "$key" =~ ^sk- ]]; then
                echo -e "  ${YELLOW}⚠ Key doesn't look like an OpenAI key (expected sk-...).${NC}"
                echo -e "  ${DIM}  Continuing anyway — double-check in your provider dashboard.${NC}"
                return 1
            fi
            ;;
    esac
    return 0
}

# ---- Notion token format validation ----
validate_notion_token() {
    local token="$1"
    [ -z "$token" ] && return 0
    if [[ ! "$token" =~ ^(ntn_|secret_) ]]; then
        echo -e "  ${YELLOW}⚠ Token doesn't look like a Notion token (expected ntn_... or secret_...).${NC}"
        echo -e "  ${DIM}  Continuing anyway — check notion.so/my-integrations.${NC}"
        return 1
    fi
    return 0
}

# ---- Dependency checks ----
require_cmd() {
    command -v "$1" &>/dev/null || return 1
}

require_root_or_sudo() {
    if [ "$EUID" -eq 0 ]; then
        SUDO=""
    elif require_cmd sudo; then
        SUDO="sudo"
    else
        echo -e "${RED}Error: This script needs root or sudo access.${NC}"
        exit 1
    fi
}

# ============================================================
# Pre-flight checks
# ============================================================

preflight() {
    echo ""
    echo -e "${BLUE}${BOLD}╔══════════════════════════════════════╗${NC}"
    echo -e "${BLUE}${BOLD}║     🏢 Become CEO — Setup v2.1      ║${NC}"
    echo -e "${BLUE}${BOLD}╚══════════════════════════════════════╝${NC}"
    [ -n "$DRY_RUN" ] && echo -e "${YELLOW}${BOLD}  ⚡ DRY-RUN MODE — no changes will be made${NC}"
    echo ""
    log "=== Setup started at $(date) ==="

    # Detect OS
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS_NAME="${ID:-unknown}"
        OS_VERSION="${VERSION_ID:-unknown}"
        OS_PRETTY="${PRETTY_NAME:-$OS_NAME $OS_VERSION}"
    else
        OS_NAME="unknown"
        OS_VERSION="unknown"
        OS_PRETTY="Unknown OS"
    fi

    # Detect architecture
    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64)  ARCH_LABEL="amd64" ;;
        aarch64) ARCH_LABEL="arm64" ;;
        armv7l)  ARCH_LABEL="armv7" ;;
        *)       ARCH_LABEL="$ARCH" ;;
    esac

    # Detect package manager
    if require_cmd apt-get; then
        PKG_MGR="apt"
    elif require_cmd dnf; then
        PKG_MGR="dnf"
    elif require_cmd yum; then
        PKG_MGR="yum"
    else
        PKG_MGR="unknown"
    fi

    # Detect RAM
    TOTAL_RAM_MB=$(free -m 2>/dev/null | awk '/^Mem:/{print $2}' || echo "0")
    TOTAL_RAM_GB=$(awk "BEGIN{printf \"%.1f\", $TOTAL_RAM_MB/1024}")

    # Detect disk space
    FREE_DISK_MB=$(df -m "$HOME" 2>/dev/null | awk 'NR==2{print $4}' || echo "0")
    FREE_DISK_GB=$(awk "BEGIN{printf \"%.1f\", $FREE_DISK_MB/1024}")

    # Detect existing installations
    HAS_NODE=$(require_cmd node && echo "yes" || echo "no")
    HAS_GH=$(require_cmd gh && echo "yes" || echo "no")
    HAS_CHROMIUM=$(require_cmd chromium-browser || require_cmd chromium && echo "yes" || echo "no")
    HAS_CLAWDBOT=$(require_cmd clawdbot && echo "yes" || echo "no")
    HAS_SWAP=$(swapon --show 2>/dev/null | grep -q . && echo "yes" || echo "no")

    echo -e "${BOLD}Environment Detected:${NC}"
    echo -e "  OS:       $OS_PRETTY ($ARCH_LABEL)"
    echo -e "  RAM:      ${TOTAL_RAM_GB}GB  |  Disk free: ${FREE_DISK_GB}GB"
    echo -e "  Package:  $PKG_MGR"
    echo ""

    # Existing software
    echo -e "${BOLD}Existing Software:${NC}"
    [ "$HAS_NODE" = "yes" ]     && echo -e "  Node.js:    ${GREEN}$(node -v)${NC}" || echo -e "  Node.js:    ${DIM}not found${NC}"
    [ "$HAS_GH" = "yes" ]       && echo -e "  GitHub CLI: ${GREEN}$(gh --version 2>/dev/null | head -1)${NC}" || echo -e "  GitHub CLI: ${DIM}not found${NC}"
    [ "$HAS_CHROMIUM" = "yes" ] && echo -e "  Chromium:   ${GREEN}installed${NC}" || echo -e "  Chromium:   ${DIM}not found${NC}"
    [ "$HAS_CLAWDBOT" = "yes" ] && echo -e "  Clawdbot:   ${GREEN}$(clawdbot --version 2>/dev/null || echo 'installed')${NC}" || echo -e "  Clawdbot:   ${DIM}not found${NC}"
    [ "$HAS_SWAP" = "yes" ]     && echo -e "  Swap:       ${GREEN}active${NC}" || echo -e "  Swap:       ${DIM}none${NC}"
    echo ""

    log "OS=$OS_PRETTY ARCH=$ARCH_LABEL RAM=${TOTAL_RAM_GB}GB DISK=${FREE_DISK_GB}GB PKG=$PKG_MGR"
    log "Node=$HAS_NODE GH=$HAS_GH Chromium=$HAS_CHROMIUM Clawdbot=$HAS_CLAWDBOT Swap=$HAS_SWAP"

    # Validate environment
    if [ "$PKG_MGR" = "unknown" ]; then
        echo -e "${RED}Error: No supported package manager found (apt/dnf/yum).${NC}"
        echo -e "Supported distros: Ubuntu 22.04+, Debian 12+, Amazon Linux 2023, Fedora 38+"
        exit 1
    fi

    if [ "$TOTAL_RAM_MB" -lt 512 ]; then
        echo -e "${RED}Error: At least 512MB RAM required (found ${TOTAL_RAM_GB}GB).${NC}"
        exit 1
    fi

    if [ "$FREE_DISK_MB" -lt 2048 ]; then
        echo -e "${RED}Error: At least 2GB free disk space required (found ${FREE_DISK_GB}GB).${NC}"
        exit 1
    fi

    if [ "$TOTAL_RAM_MB" -lt 2048 ]; then
        warn "Low RAM (${TOTAL_RAM_GB}GB). Setup will create swap, but consider Oracle Cloud free tier (24GB)."
    fi

    # Network connectivity check
    echo -e "${BOLD}Network:${NC}"
    if check_network; then
        echo -e "  ${GREEN}✓${NC} All required endpoints reachable"
    else
        echo -e "  ${YELLOW}⚠${NC} Some endpoints unreachable (see warnings above)"
    fi
    echo ""

    # Count steps based on what needs installation
    STEP_TOTAL=4  # Always: system update, workspace, config wizard, gateway
    [ "$HAS_SWAP" = "no" ] && [ "$TOTAL_RAM_MB" -lt 8192 ] && STEP_TOTAL=$((STEP_TOTAL + 1))
    [ "$HAS_NODE" = "no" ] || ! node -v 2>/dev/null | grep -q "^v2[2-9]" && STEP_TOTAL=$((STEP_TOTAL + 1))
    [ "$HAS_GH" = "no" ] && STEP_TOTAL=$((STEP_TOTAL + 1))
    [ "$HAS_CHROMIUM" = "no" ] && STEP_TOTAL=$((STEP_TOTAL + 1))
    [ "$HAS_CLAWDBOT" = "no" ] && STEP_TOTAL=$((STEP_TOTAL + 1))

    # --check mode: exit after showing environment info
    if [ -n "$CHECK_ONLY" ]; then
        echo -e "${GREEN}${BOLD}Pre-flight check complete.${NC}"
        if [ ${#WARNINGS[@]} -gt 0 ]; then
            echo -e "${YELLOW}Warnings: ${#WARNINGS[@]}${NC}"
            for w in "${WARNINGS[@]}"; do echo -e "  ${YELLOW}⚠${NC} $w"; done
        else
            echo -e "${GREEN}✓ No issues found. Ready to install.${NC}"
        fi
        exit 0
    fi

    require_root_or_sudo

    # Confirmation
    if [ -z "$SKIP_INTERACTIVE" ]; then
        echo -e "${BOLD}Ready to install ($STEP_TOTAL steps). Continue? [Y/n]${NC} "
        read -r confirm
        if [[ "${confirm:-Y}" =~ ^[Nn] ]]; then
            echo "Setup cancelled."
            exit 0
        fi
    fi
}

# ============================================================
# Package installation helpers (multi-distro)
# ============================================================

pkg_update() {
    case "$PKG_MGR" in
        apt) $SUDO apt-get update -qq 2>> "$LOG_FILE" ;;
        dnf) $SUDO dnf check-update -q 2>> "$LOG_FILE" || true ;;
        yum) $SUDO yum check-update -q 2>> "$LOG_FILE" || true ;;
    esac
}

pkg_install() {
    case "$PKG_MGR" in
        apt) $SUDO apt-get install -y -qq "$@" >> "$LOG_FILE" 2>&1 ;;
        dnf) $SUDO dnf install -y -q "$@" >> "$LOG_FILE" 2>&1 ;;
        yum) $SUDO yum install -y -q "$@" >> "$LOG_FILE" 2>&1 ;;
    esac
}

# ============================================================
# Installation steps
# ============================================================

install_system_update() {
    step "System update & firewall"
    run_cmd "package update" pkg_update
    ok "Package lists updated"

    # Cloud-specific firewall rules (Oracle Cloud, etc.)
    if $SUDO iptables -L INPUT 2>/dev/null | grep -q "REJECT"; then
        run_cmd "remove REJECT rule (INPUT)" $SUDO iptables -D INPUT -j REJECT --reject-with icmp-host-prohibited 2>/dev/null || true
        run_cmd "remove REJECT rule (FORWARD)" $SUDO iptables -D FORWARD -j REJECT --reject-with icmp-host-prohibited 2>/dev/null || true
        if require_cmd netfilter-persistent; then
            run_cmd "save firewall rules" $SUDO netfilter-persistent save >> "$LOG_FILE" 2>&1
        fi
        ok "Cloud firewall rules cleaned"
    else
        skip "No restrictive firewall rules found"
    fi
}

install_swap() {
    if [ "$HAS_SWAP" = "yes" ]; then
        return
    fi
    if [ "$TOTAL_RAM_MB" -ge 8192 ]; then
        return
    fi

    step "Swap space"

    # Calculate swap size based on RAM
    if [ "$TOTAL_RAM_MB" -lt 2048 ]; then
        SWAP_SIZE="4G"
    elif [ "$TOTAL_RAM_MB" -lt 4096 ]; then
        SWAP_SIZE="2G"
    else
        SWAP_SIZE="1G"
    fi

    if [ ! -f /swapfile ]; then
        $SUDO fallocate -l "$SWAP_SIZE" /swapfile 2>/dev/null || $SUDO dd if=/dev/zero of=/swapfile bs=1M count=$((${SWAP_SIZE%G} * 1024)) >> "$LOG_FILE" 2>&1
        $SUDO chmod 600 /swapfile
        $SUDO mkswap /swapfile >> "$LOG_FILE" 2>&1
        $SUDO swapon /swapfile
        if ! grep -q '/swapfile' /etc/fstab; then
            echo '/swapfile none swap sw 0 0' | $SUDO tee -a /etc/fstab > /dev/null
        fi
        ok "${SWAP_SIZE} swap created (RAM: ${TOTAL_RAM_GB}GB)"
    else
        $SUDO swapon /swapfile 2>/dev/null || true
        ok "Existing swapfile activated"
    fi
}

install_node() {
    local need_install="no"

    if [ "$HAS_NODE" = "no" ]; then
        need_install="yes"
    elif ! node -v 2>/dev/null | grep -q "^v2[2-9]"; then
        need_install="yes"
        warn "Node.js $(node -v) found but v22+ required"
    fi

    if [ "$need_install" = "no" ]; then
        return
    fi

    step "Node.js 22"

    if [ "$PKG_MGR" = "apt" ]; then
        curl -fsSL https://deb.nodesource.com/setup_22.x | $SUDO -E bash - >> "$LOG_FILE" 2>&1
        pkg_install nodejs
    elif [ "$PKG_MGR" = "dnf" ] || [ "$PKG_MGR" = "yum" ]; then
        curl -fsSL https://rpm.nodesource.com/setup_22.x | $SUDO bash - >> "$LOG_FILE" 2>&1
        pkg_install nodejs
    fi

    if require_cmd node && node -v | grep -q "^v2[2-9]"; then
        ok "Node.js $(node -v) installed"
    else
        echo -e "${RED}✗ Node.js installation failed. Check $LOG_FILE${NC}"
        exit 1
    fi
}

install_gh() {
    [ "$HAS_GH" = "yes" ] && return

    step "GitHub CLI"

    if [ "$PKG_MGR" = "apt" ]; then
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
            | $SUDO dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg 2>/dev/null
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
            | $SUDO tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        $SUDO apt-get update -qq >> "$LOG_FILE" 2>&1
        pkg_install gh
    elif [ "$PKG_MGR" = "dnf" ]; then
        $SUDO dnf install -y 'dnf-command(config-manager)' >> "$LOG_FILE" 2>&1 || true
        $SUDO dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo >> "$LOG_FILE" 2>&1
        pkg_install gh
    fi

    if require_cmd gh; then
        ok "GitHub CLI installed"
    else
        warn "GitHub CLI installation failed (optional — you can install later)"
    fi
}

install_chromium() {
    [ "$HAS_CHROMIUM" = "yes" ] && return

    step "Chromium browser"

    if [ "$PKG_MGR" = "apt" ]; then
        # Try snap first (Ubuntu), fall back to apt
        if require_cmd snap; then
            $SUDO snap install chromium >> "$LOG_FILE" 2>&1 && ok "Chromium installed (snap)" && return
        fi
        pkg_install chromium-browser && ok "Chromium installed (apt)" && return
    elif [ "$PKG_MGR" = "dnf" ] || [ "$PKG_MGR" = "yum" ]; then
        pkg_install chromium && ok "Chromium installed" && return
    fi

    warn "Chromium installation failed (optional — browser automation won't work without it)"
}

setup_chromium_env() {
    # Set Puppeteer path for headless browser
    local chrome_bin=""
    if [ -f "/snap/chromium/current/usr/lib/chromium-browser/chrome" ]; then
        chrome_bin="/snap/chromium/current/usr/lib/chromium-browser/chrome"
    elif require_cmd chromium-browser; then
        chrome_bin=$(which chromium-browser)
    elif require_cmd chromium; then
        chrome_bin=$(which chromium)
    fi

    if [ -n "$chrome_bin" ]; then
        if ! grep -q PUPPETEER_EXECUTABLE_PATH ~/.bashrc 2>/dev/null; then
            echo "export PUPPETEER_EXECUTABLE_PATH=\"$chrome_bin\"" >> ~/.bashrc
        fi
    fi
}

install_clawdbot() {
    [ "$HAS_CLAWDBOT" = "yes" ] && return

    step "Clawdbot"
    $SUDO npm install -g clawdbot --loglevel=error >> "$LOG_FILE" 2>&1

    if require_cmd clawdbot; then
        ok "Clawdbot $(clawdbot --version 2>/dev/null || echo '') installed"
    else
        echo -e "${RED}✗ Clawdbot installation failed. Check $LOG_FILE${NC}"
        exit 1
    fi
}

setup_workspace() {
    step "Workspace & templates"

    mkdir -p "$WORKSPACE/memory"
    mkdir -p "$CONFIG_DIR"

    # Try local references first (git clone), fall back to GitHub download
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd 2>/dev/null || echo "")"
    LOCAL_REF="${SCRIPT_DIR:+$SCRIPT_DIR/../references}"
    [ -n "$LOCAL_REF" ] && [ ! -d "$LOCAL_REF" ] && LOCAL_REF=""

    download_ref() {
        local file="$1" dest="$2"
        [ -f "$dest" ] && { skip "$file (already exists)"; return 0; }
        if [ -n "${LOCAL_REF:-}" ] && [ -f "$LOCAL_REF/$file" ]; then
            cp "$LOCAL_REF/$file" "$dest"
        else
            if ! curl -fsSL "$REPO_RAW/$file" -o "$dest" 2>> "$LOG_FILE"; then
                warn "Failed to download $file"
                return 1
            fi
        fi
        ok "$file created"
    }

    for f in SOUL.md IDENTITY.md USER.md AGENTS.md; do
        download_ref "$f" "$WORKSPACE/$f"
    done

    if [ ! -f "$CONFIG_DIR/clawdbot.json" ]; then
        download_ref "clawdbot-template.json" "$CONFIG_DIR/clawdbot.json"
        sed -i "s|\$HOME|$HOME|g" "$CONFIG_DIR/clawdbot.json"
        ok "Config template created at $CONFIG_DIR/clawdbot.json"
    else
        skip "Config already exists at $CONFIG_DIR/clawdbot.json"
    fi
}

# ============================================================
# Interactive configuration wizard
# ============================================================

config_wizard() {
    step "Configuration wizard"

    local config_file="$CONFIG_DIR/clawdbot.json"

    # Skip if not interactive or config already customized
    if [ -n "$SKIP_INTERACTIVE" ]; then
        info "Non-interactive mode — skipping wizard"
        info "Edit $config_file manually to add your keys"
        return
    fi

    # Check if config still has placeholder values
    if ! grep -q '\$LLM_API_KEY' "$config_file" 2>/dev/null; then
        skip "Config already customized"
        return
    fi

    echo ""
    echo -e "  ${BOLD}Let's configure your AI team.${NC}"
    echo -e "  ${DIM}(Press Enter to skip any step — you can edit later)${NC}"
    echo ""

    # --- LLM Provider ---
    echo -e "  ${BOLD}LLM Provider${NC}"
    echo -e "  ${DIM}Which AI provider? (1=Anthropic, 2=OpenAI, 3=Other)${NC}"
    read -r -p "  Choice [1]: " provider_choice
    provider_choice="${provider_choice:-1}"

    local provider_name="" base_url="" api_format=""
    case "$provider_choice" in
        1)
            provider_name="anthropic"
            base_url="https://api.anthropic.com/v1"
            api_format="anthropic"
            ;;
        2)
            provider_name="openai"
            base_url="https://api.openai.com/v1"
            api_format="openai"
            ;;
        3)
            read -r -p "  Provider name: " provider_name
            read -r -p "  Base URL: " base_url
            read -r -p "  API format (openai/anthropic): " api_format
            ;;
    esac

    if [ -n "$provider_name" ]; then
        # Replace provider placeholders
        sed -i "s|\\\$LLM_PROVIDER|$provider_name|g" "$config_file"
        sed -i "s|\\\$LLM_BASE_URL|$base_url|g" "$config_file"
        sed -i "s|\\\$LLM_API_FORMAT|$api_format|g" "$config_file"
        ok "Provider: $provider_name"
    fi

    # --- API Key ---
    echo ""
    echo -e "  ${BOLD}API Key${NC}"
    echo -e "  ${DIM}Paste your LLM API key (input hidden):${NC}"
    read -r -s -p "  API Key: " api_key
    echo ""

    if [ -n "$api_key" ]; then
        validate_api_key "$api_key" "${provider_name:-}" || true
        # Escape special characters for sed
        local escaped_key
        escaped_key=$(printf '%s\n' "$api_key" | sed 's/[&/\]/\\&/g')
        sed -i "s|\\\$LLM_API_KEY|$escaped_key|g" "$config_file"
        ok "API key saved"
    else
        info "Skipped — add it later in $config_file"
    fi

    # --- Discord Guild ID ---
    echo ""
    echo -e "  ${BOLD}Discord Server ID${NC}"
    echo -e "  ${DIM}Right-click your server → Copy Server ID (enable Developer Mode in Discord settings)${NC}"
    read -r -p "  Guild ID: " guild_id

    if [ -n "$guild_id" ]; then
        sed -i "s|\\\$DISCORD_GUILD_ID|$guild_id|g" "$config_file"
        ok "Guild ID: $guild_id"
    else
        info "Skipped — add it later in $config_file"
    fi

    # --- Discord Bot Tokens ---
    local agents=("chief-of-staff" "engineering" "marketing" "finance" "devops" "legal" "management")
    local agent_names=("Chief of Staff" "Engineering" "Marketing" "Finance" "DevOps" "Legal" "Management")

    echo ""
    echo -e "  ${BOLD}Discord Bot Tokens${NC}"
    echo -e "  ${DIM}Paste each bot token (Enter to skip). You need 7 bots from discord.com/developers.${NC}"
    echo ""

    local tokens_set=0
    for i in "${!agents[@]}"; do
        read -r -s -p "  ${agent_names[$i]} token: " token
        echo ""
        if [ -n "$token" ]; then
            local escaped_token
            escaped_token=$(printf '%s\n' "$token" | sed 's/[&/\]/\\&/g')
            sed -i "s|\\\$DISCORD_TOKEN_${agents[$i]^^}|$escaped_token|g" "$config_file" 2>/dev/null || true
            # Also handle the simpler placeholder pattern
            sed -i "s|\"token\": \"\\\$DISCORD_BOT_TOKEN_$((i+1))\"|\"token\": \"$escaped_token\"|" "$config_file" 2>/dev/null || true
            tokens_set=$((tokens_set + 1))
        fi
    done

    if [ "$tokens_set" -gt 0 ]; then
        ok "$tokens_set of 7 bot tokens configured"
    else
        info "No tokens entered — add them in $config_file"
    fi

    # --- Notion Token (optional) ---
    echo ""
    echo -e "  ${BOLD}Notion Integration (optional)${NC}"
    echo -e "  ${DIM}Create at notion.so/my-integrations. Enables auto-reports, knowledge base.${NC}"
    read -r -s -p "  Notion token: " notion_token
    echo ""

    if [ -n "$notion_token" ]; then
        validate_notion_token "$notion_token" || true
        # Store in workspace env file for agents to pick up
        local env_file="$WORKSPACE/.env"
        if [ -n "$DRY_RUN" ]; then
            echo -e "  ${DIM}[dry-run] would write NOTION_TOKEN to $env_file${NC}"
        else
            mkdir -p "$WORKSPACE"
            # Append or update NOTION_TOKEN
            if grep -q '^NOTION_TOKEN=' "$env_file" 2>/dev/null; then
                sed -i "s|^NOTION_TOKEN=.*|NOTION_TOKEN=$notion_token|" "$env_file"
            else
                echo "NOTION_TOKEN=$notion_token" >> "$env_file"
            fi
            chmod 600 "$env_file"
            ok "Notion token saved to $env_file"
        fi
    else
        info "Skipped — add NOTION_TOKEN to $WORKSPACE/.env later"
    fi

    # --- GitHub CLI Auth (optional) ---
    echo ""
    echo -e "  ${BOLD}GitHub CLI (optional)${NC}"
    echo -e "  ${DIM}Authenticate gh CLI for Issues, PRs, CI/CD automation.${NC}"
    if require_cmd gh; then
        if gh auth status &>/dev/null; then
            ok "GitHub CLI already authenticated"
        else
            echo -e "  ${DIM}Run 'gh auth login' after setup to authenticate (requires browser or token).${NC}"
            info "Skipping — authenticate with: gh auth login"
        fi
    else
        info "gh CLI not installed yet — will be available after setup"
    fi

    echo ""
    info "Config saved to: $config_file"
    info "You can always edit it later: nano $config_file"
}

# ============================================================
# Gateway service
# ============================================================

install_gateway() {
    step "Gateway service"

    if require_cmd clawdbot; then
        if run_cmd "install gateway service" clawdbot gateway install >> "$LOG_FILE" 2>&1; then
            ok "Gateway service installed (auto-starts on boot)"
            info "Start: systemctl --user start clawdbot-gateway"
            info "Logs:  journalctl --user -u clawdbot-gateway -f"
        else
            warn "Gateway service install failed — run 'clawdbot gateway install' after filling in config"
        fi
    else
        warn "Clawdbot not found — install it first, then run 'clawdbot gateway install'"
    fi
}

# ============================================================
# Summary
# ============================================================

print_summary() {
    echo ""
    if [ -n "$DRY_RUN" ]; then
        echo -e "${YELLOW}${BOLD}╔══════════════════════════════════════╗${NC}"
        echo -e "${YELLOW}${BOLD}║     ⚡ Dry-Run Complete (v2.1)       ║${NC}"
        echo -e "${YELLOW}${BOLD}╚══════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${DIM}No changes were made. Run without --dry-run to install.${NC}"
        return
    fi

    echo -e "${GREEN}${BOLD}╔══════════════════════════════════════╗${NC}"
    echo -e "${GREEN}${BOLD}║      ✅ Setup Complete! (v2.1)       ║${NC}"
    echo -e "${GREEN}${BOLD}╚══════════════════════════════════════╝${NC}"
    echo ""

    # Show any warnings
    if [ ${#WARNINGS[@]} -gt 0 ]; then
        echo -e "${YELLOW}${BOLD}Warnings:${NC}"
        for w in "${WARNINGS[@]}"; do
            echo -e "  ${YELLOW}⚠${NC} $w"
        done
        echo ""
    fi

    echo -e "${BOLD}What was installed:${NC}"
    require_cmd node     && echo -e "  ${GREEN}✓${NC} Node.js $(node -v)"
    require_cmd gh       && echo -e "  ${GREEN}✓${NC} GitHub CLI"
    (require_cmd chromium-browser || require_cmd chromium) && echo -e "  ${GREEN}✓${NC} Chromium"
    require_cmd clawdbot && echo -e "  ${GREEN}✓${NC} Clawdbot $(clawdbot --version 2>/dev/null || echo '')"
    swapon --show 2>/dev/null | grep -q . && echo -e "  ${GREEN}✓${NC} Swap active"
    echo ""

    echo -e "${BOLD}Files:${NC}"
    echo -e "  Config:    ${CYAN}$CONFIG_DIR/clawdbot.json${NC}"
    echo -e "  Workspace: ${CYAN}$WORKSPACE/${NC}"
    echo -e "  Log:       ${DIM}$LOG_FILE${NC}"
    echo ""

    echo -e "${BOLD}Next steps:${NC}"
    echo ""

    # Check if config still has placeholders
    if grep -q '\$LLM_API_KEY\|\$LLM_PROVIDER\|\$DISCORD' "$CONFIG_DIR/clawdbot.json" 2>/dev/null; then
        echo -e "  ${YELLOW}1.${NC} Fill in your keys:"
        echo -e "     ${CYAN}nano $CONFIG_DIR/clawdbot.json${NC}"
        echo ""
        echo -e "  ${YELLOW}2.${NC} Enable Discord bot intents:"
        echo -e "     Developer Portal → Bot → ${BOLD}Message Content Intent${NC} ✓"
        echo -e "                            ${BOLD}Server Members Intent${NC} ✓"
        echo ""
        echo -e "  ${YELLOW}3.${NC} Start your team:"
        echo -e "     ${CYAN}systemctl --user start clawdbot-gateway${NC}"
    else
        echo -e "  ${YELLOW}1.${NC} Enable Discord bot intents (if not done):"
        echo -e "     Developer Portal → Bot → ${BOLD}Message Content Intent${NC} ✓"
        echo ""
        echo -e "  ${YELLOW}2.${NC} Start your team:"
        echo -e "     ${CYAN}systemctl --user start clawdbot-gateway${NC}"
    fi

    echo ""
    echo -e "  ${YELLOW}Verify:${NC} systemctl --user status clawdbot-gateway"
    echo -e "  ${YELLOW}Logs:${NC}   journalctl --user -u clawdbot-gateway -f"
    echo ""
    echo -e "  Docs: ${BLUE}https://github.com/wanikua/become-ceo${NC}"
    echo ""
}

# ============================================================
# Main
# ============================================================

main() {
    preflight
    install_system_update
    install_swap
    install_node
    install_gh
    install_chromium
    setup_chromium_env
    install_clawdbot
    setup_workspace
    config_wizard
    install_gateway
    print_summary
}

# ============================================================
# Argument parsing
# ============================================================

show_help() {
    echo "Usage: bash setup.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --non-interactive    Skip confirmation prompts and config wizard"
    echo "  --workspace PATH     Set workspace directory (default: ~/clawd)"
    echo "  --dry-run            Show what would happen without making changes"
    echo "  --check              Run pre-flight checks only (no install)"
    echo "  -h, --help           Show this help message"
    echo ""
    echo "Environment variables:"
    echo "  SKIP_INTERACTIVE=1   Same as --non-interactive"
    echo "  CLAWD_WORKSPACE=     Same as --workspace"
    echo "  DRY_RUN=1            Same as --dry-run"
    echo "  CHECK_ONLY=1         Same as --check"
    echo ""
    echo "Examples:"
    echo "  bash setup.sh                          # Interactive install"
    echo "  bash setup.sh --check                  # Check environment only"
    echo "  bash setup.sh --dry-run                # Preview without installing"
    echo "  bash setup.sh --non-interactive         # CI/Docker (no prompts)"
    echo "  bash setup.sh --workspace /opt/clawd   # Custom workspace path"
    exit 0
}

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)
            show_help
            ;;
        --non-interactive)
            SKIP_INTERACTIVE=1
            shift
            ;;
        --workspace)
            WORKSPACE="${2:?Error: --workspace requires a PATH argument}"
            shift 2
            ;;
        --dry-run)
            DRY_RUN=1
            shift
            ;;
        --check)
            CHECK_ONLY=1
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Run 'bash setup.sh --help' for usage."
            exit 1
            ;;
    esac
done

main
