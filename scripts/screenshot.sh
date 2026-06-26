#!/usr/bin/env bash
# Usage: screenshot.sh [region|screen|window]
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

MODE="${1:-region}"
SAVEDIR="${OMARCHY_SCREENSHOT_DIR:-$HOME/Pictures/Screenshots}"
mkdir -p "$SAVEDIR"

case "$MODE" in
    region)
        FILE=$(mktemp /tmp/screenshot-XXXXXX.png)
        grim -g "$(slurp)" "$FILE" && satty --filename "$FILE" --fullscreen --output-filename "$SAVEDIR/$(date +%Y%m%d-%H%M%S).png"
        rm -f "$FILE"
        ;;
    screen)
        hyprshot -m output --output-folder "$SAVEDIR" --silent
        ;;
    window)
        hyprshot -m window --output-folder "$SAVEDIR" --silent
        ;;
    *)
        log_error "Unknown mode: $MODE. Use region, screen, or window."
        exit 1
        ;;
esac
