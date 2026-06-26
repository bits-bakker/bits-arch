#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WALLPAPER="$REPO_DIR/wallpapers/default.png"

if [[ -f "$WALLPAPER" ]]; then
    log_header "theme" "Applying default wallpaper..."
    "$REPO_DIR/scripts/set-wallpaper.sh" "$WALLPAPER"
else
    log_warn "No default wallpaper found at $WALLPAPER"
fi

log_info "Change theme:     ~/bits-arch/scripts/set-theme.sh dracula"
log_info "Change wallpaper: ~/bits-arch/scripts/set-wallpaper.sh <image>"
log_info "Available themes: dracula nord gruvbox catppuccin sakura rose-pine"
