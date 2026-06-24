#!/usr/bin/env bash
set -euo pipefail

if ! command -v yay &>/dev/null; then
    echo "[error] yay not found. Run core/matugen.sh first (it installs yay)."
    exit 1
fi

# code-oss is the open-source build in the official repos; use the AUR for the
# proprietary Microsoft build (with marketplace access)
yay -S --needed --noconfirm visual-studio-code-bin
