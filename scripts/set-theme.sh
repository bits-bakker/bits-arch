#!/usr/bin/env bash
# Usage: set-theme.sh <theme-name>
# Only meaningful when the active theming tool is aether.
# For matugen, theming is driven by wallpaper — use set-wallpaper.sh instead.
set -euo pipefail

PREFS="$HOME/.config/bits-arch/theming"
THEMING="matugen"
[[ -f "$PREFS" ]] && THEMING="$(cat "$PREFS")"

if [[ "$THEMING" != "aether" ]]; then
    echo "[info] Active theming tool is matugen, not aether."
    echo "       Use set-wallpaper.sh to re-theme from a wallpaper."
    exit 0
fi

THEME="${1:-}"
if [[ -z "$THEME" ]]; then
    echo "Usage: set-theme.sh <theme-name>"
    echo "Available themes: dracula nord gruvbox catppuccin sakura rose-pine"
    exit 1
fi

aether theme "$THEME"

pkill -SIGUSR2 waybar 2>/dev/null || true
pkill -HUP mako 2>/dev/null || true
