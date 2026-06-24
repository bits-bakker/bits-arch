#!/usr/bin/env bash
set -euo pipefail

if ! command -v yay &>/dev/null; then
    echo "[error] yay not found. Run core/matugen.sh first (it installs yay)."
    exit 1
fi

yay -S --needed --noconfirm aether-bin
