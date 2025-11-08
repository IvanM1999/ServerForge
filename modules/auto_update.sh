#!/usr/bin/env bash
set -euo pipefail
REPO="${1:-https://github.com/IvanM1999/ServerForge.git}"
TMP=$(mktemp -d)
ZIP="$TMP/repo.zip"
echo "Downloading $REPO ..."
curl -L "${REPO%/}/archive/refs/heads/main.zip" -o "$ZIP"
unzip -q -o "$ZIP" -d "$TMP"
# find extracted root dir
rootdir=$(find "$TMP" -maxdepth 1 -type d -name '*ServerForge*' | head -n1)
if [ -z "$rootdir" ]; then
  rootdir=$(find "$TMP" -maxdepth 2 -type d | head -n1)
fi
rsync -a --delete --exclude='.git' --exclude='installers' --exclude='version.manifest' "$rootdir/" "$(pwd)/"
echo "Updated local copy."
