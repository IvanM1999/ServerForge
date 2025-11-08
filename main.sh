#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
if [[ "${1:-}" == "--cli" ]]; then
  echo "ServerForge CLI mode"
  exec python3 serverforge.py --cli
fi
if python3 -c "import flask" >/dev/null 2>&1; then
  echo "Launching web UI at http://127.0.0.1:8080"
  python3 ui/webapp.py
else
  exec python3 serverforge.py
fi
