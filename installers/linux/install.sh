#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd)
TARGET=/opt/serverforge
echo "Installing to $TARGET"
sudo mkdir -p "$TARGET"
sudo rsync -a --exclude='.git' "$ROOT/" "$TARGET/"
sudo ln -sf "$TARGET/main.sh" /usr/local/bin/serverforge
echo "Installed. Run 'serverforge --cli' or 'serverforge' to start."
