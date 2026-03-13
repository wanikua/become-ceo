#!/bin/bash
set -e

WORKSPACE="${OPENCLAW_WORKSPACE:-$HOME/clawd}"
CONFIG_DIR="${OPENCLAW_CONFIG_DIR:-$HOME/.openclaw}"

# ---- Initialize workspace templates (first run only) ----
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
EOF
echo "✓ SOUL.md created"
fi

if [ ! -f "$WORKSPACE/IDENTITY.md" ]; then
cat > "$WORKSPACE/IDENTITY.md" << 'EOF'
# IDENTITY.md - Identity

- **Name:** CEO Agent
- **Creature:** AI C-Suite Agent Cluster
- **Vibe:** Loyal, capable, each role well-defined
- **Emoji:** 🏢
EOF
echo "✓ IDENTITY.md created"
fi

if [ ! -f "$WORKSPACE/USER.md" ]; then
cat > "$WORKSPACE/USER.md" << 'EOF'
# USER.md - About You

- **Name:** (your name here)
- **Language:** English
- **Style:** Concise and efficient
EOF
echo "✓ USER.md created"
fi

mkdir -p "$WORKSPACE/memory"

# ---- OpenViking initialization (if configured) ----
if [ -f "/root/.openviking/ov.conf" ] || [ -n "$OPENVIKING_CONFIG_FILE" ]; then
    echo "✓ OpenViking config detected"
    mkdir -p /root/.openviking/data
fi

# ---- GUI Dashboard auto-start (if available) ----
if [ -f "/opt/gui/server/index.js" ]; then
    echo "✓ CEO Dashboard detected, starting..."
    cd /opt/gui && node server/index.js &
    GUI_PID=$!
    cd "$WORKSPACE"
    echo "✓ Dashboard started (PID: $GUI_PID, port: 18795)"
fi

# ---- Info messages ----
if [ ! -f "$CONFIG_DIR/openclaw.json" ]; then
    echo ""
    echo "================================"
    echo "⚠ Config file not found"
    echo "================================"
    echo ""
    echo "Choose one way to initialize:"
    echo ""
    echo "  Option 1: Interactive setup (recommended)"
    echo "    docker exec -it become-ceo /init-docker.sh"
    echo ""
    echo "  Option 2: OpenClaw config wizard"
    echo "    docker exec -it become-ceo openclaw onboard"
    echo ""
    echo "  Option 3: Mount existing config file"
    echo "    docker run -v ./openclaw.json:/root/.openclaw/openclaw.json ..."
    echo ""
fi

echo ""
echo "🏢 Become CEO — Docker starting..."
echo "  Workspace:  $WORKSPACE"
echo "  Config:     $CONFIG_DIR/openclaw.json"
echo "  Gateway:    http://localhost:18789"
echo "  Dashboard:  http://localhost:18795"
echo "  Setup:      docker exec -it become-ceo /init-docker.sh"
echo ""

exec "$@"
