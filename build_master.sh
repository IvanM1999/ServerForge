#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")" && pwd)
OUT=ServerForge_Build_$(date +%Y%m%d_%H%M%S)
mkdir -p "$OUT/dist"
rsync -a --exclude='.git' --exclude='installers' "$ROOT/" "$OUT/dist/"
zip -r "${OUT}.zip" "$OUT/dist" >/dev/null
echo "Packaged into ${OUT}.zip"
