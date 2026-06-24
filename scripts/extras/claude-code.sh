#!/usr/bin/env bash
set -euo pipefail

# Claude Code requires Node.js
if ! command -v node &>/dev/null; then
    sudo pacman -S --needed --noconfirm nodejs npm
fi

npm install -g @anthropic-ai/claude-code
