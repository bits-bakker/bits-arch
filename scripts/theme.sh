#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

log_header "theme" "Aether installed. Set a theme with:"
log_step "~/bits-arch/scripts/set-theme.sh dracula"
log_info "Available: dracula nord gruvbox catppuccin sakura rose-pine"
