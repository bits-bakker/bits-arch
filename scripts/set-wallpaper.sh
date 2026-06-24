#!/usr/bin/env bash
# Usage: set-wallpaper.sh <image-path>
set -euo pipefail

IMAGE="${1:?Usage: set-wallpaper.sh <image-path>}"
IMAGE="$(realpath "$IMAGE")"

if [[ ! -f "$IMAGE" ]]; then
    echo "[error] File not found: $IMAGE"
    exit 1
fi

PREFS="$HOME/.config/bits-arch/theming"
THEMING="matugen"
[[ -f "$PREFS" ]] && THEMING="$(cat "$PREFS")"

# Start swww daemon if not running
if ! pgrep -x swww-daemon &>/dev/null; then
    swww-daemon &
    sleep 0.5
fi

swww img "$IMAGE" \
    --transition-type grow \
    --transition-pos center \
    --transition-duration 1

case "$THEMING" in
    matugen)
        matugen image "$IMAGE"
        pkill -SIGUSR2 waybar 2>/dev/null || true
        pkill -HUP mako 2>/dev/null || true
        ;;
    aether)
        # Aether derives its palette from the wallpaper when called with 'wallpaper'
        aether wallpaper "$IMAGE"
        ;;
esac
