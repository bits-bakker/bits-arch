#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

log_header "claude-code" "Installing Claude Code..."
if ! command -v node &>/dev/null; then
    log_step "Installing Node.js..."
    sudo pacman -S --needed --noconfirm nodejs npm
fi

npm install -g @anthropic-ai/claude-code
log_done "Claude Code installed."
