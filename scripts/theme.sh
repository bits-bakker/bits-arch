#!/usr/bin/env bash
# Called by install.py with: theme.sh <theming>
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
THEMING="${1:-matugen}"
WALLPAPER="$REPO_DIR/wallpapers/default.jpg"

case "$THEMING" in
    matugen)
        if [[ ! -f "$WALLPAPER" ]]; then
            echo "[warn] No default wallpaper found at $WALLPAPER — skipping initial theme."
            echo "       Run: set-wallpaper.sh <path-to-image>"
            exit 0
        fi
        "$REPO_DIR/scripts/set-wallpaper.sh" "$WALLPAPER"
        ;;
    aether)
        echo "[theming] Aether installed. Set a theme with:"
        echo "  ~/bits-arch/scripts/set-theme.sh dracula"
        echo "Available: dracula nord gruvbox catppuccin sakura rose-pine"
        ;;
esac
