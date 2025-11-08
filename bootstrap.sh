#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
echo "[bootstrap] root=$ROOT"
if command -v python3 >/dev/null 2>&1; then
  echo "[bootstrap] verifying integrity..."
  python3 tools/integrity_check.py --verify || {
    echo "[bootstrap] Integrity failed. Attempting restore..."
    python3 tools/integrity_check.py --full || {
      echo "[bootstrap] Restore failed."
      exit 2
    }
  }
else
  echo "[bootstrap] python3 not found. Skipping integrity check."
fi
echo "[bootstrap] done. Run './main.sh' to launch."
