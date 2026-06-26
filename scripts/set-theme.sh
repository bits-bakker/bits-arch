#!/usr/bin/env bash
# Usage: set-theme.sh <theme-name>
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

THEME="${1:-}"
if [[ -z "$THEME" ]]; then
    log_error "Usage: set-theme.sh <theme-name>"
    log_info "Available themes: dracula nord gruvbox catppuccin sakura rose-pine"
    exit 1
fi

log_step "Applying theme: $THEME"
aether theme "$THEME"

pkill -SIGUSR2 waybar 2>/dev/null || true
pkill -HUP mako 2>/dev/null || true
log_done "Theme '$THEME' applied."
