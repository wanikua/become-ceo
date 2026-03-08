#!/bin/bash
# ============================================
# Become CEO — Full Install (wrapper for setup.sh)
# For users who prefer `install.sh` naming convention
# ============================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec bash "$SCRIPT_DIR/setup.sh" "$@"
