#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV="$REPO_DIR/.venv"

# Install Python if missing
if ! command -v python3 &>/dev/null; then
    sudo pacman -S --needed --noconfirm python
fi

# Create venv if it doesn't exist yet
if [[ ! -d "$VENV" ]]; then
    python3 -m venv "$VENV"
fi

# Install dependencies into the venv
"$VENV/bin/pip" install --quiet --upgrade pip
"$VENV/bin/pip" install --quiet -r "$REPO_DIR/requirements.txt"

# Hand off to the Python installer, passing any CLI args through
exec "$VENV/bin/python" "$REPO_DIR/install.py" "$@"
