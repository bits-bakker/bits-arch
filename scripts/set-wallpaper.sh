#!/usr/bin/env bash
# Usage: set-wallpaper.sh <image-path>
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

IMAGE="${1:?Usage: set-wallpaper.sh <image-path>}"
IMAGE="$(realpath "$IMAGE")"

if [[ ! -f "$IMAGE" ]]; then
    log_error "File not found: $IMAGE"
    exit 1
fi

if ! pgrep -x swww-daemon &>/dev/null; then
    swww-daemon &
    sleep 0.5
fi

log_step "Setting wallpaper: $IMAGE"
swww img "$IMAGE" \
    --transition-type grow \
    --transition-pos center \
    --transition-duration 1

log_step "Applying aether wallpaper colors..."
aether wallpaper "$IMAGE"
