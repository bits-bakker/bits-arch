#!/usr/bin/env bash
# Usage: set-wallpaper.sh <image-path>
set -euo pipefail

IMAGE="${1:?Usage: set-wallpaper.sh <image-path>}"
IMAGE="$(realpath "$IMAGE")"

if [[ ! -f "$IMAGE" ]]; then
    echo "[error] File not found: $IMAGE"
    exit 1
fi

# Start swww daemon if not running
if ! pgrep -x swww-daemon &>/dev/null; then
    swww-daemon &
    sleep 0.5
fi

# Set wallpaper with smooth transition
swww img "$IMAGE" \
    --transition-type grow \
    --transition-pos center \
    --transition-duration 1

# Generate Material You palette and apply templates
matugen image "$IMAGE"

# Reload apps that need a signal to pick up new colors
pkill -SIGUSR2 waybar 2>/dev/null || true
pkill -HUP mako 2>/dev/null || true
