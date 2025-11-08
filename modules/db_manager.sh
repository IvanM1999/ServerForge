#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
DB="$ROOT/data/serverforge.sqlite"
case "${1:-status}" in
  init)
    mkdir -p "$(dirname "$DB")"
    sqlite3 "$DB" "CREATE TABLE IF NOT EXISTS kv(key TEXT PRIMARY KEY, value TEXT);"
    echo "DB initialized at $DB"
    ;;
  backup)
    mkdir -p "$ROOT/backups"
    cp "$DB" "$ROOT/backups/serverforge.sqlite.$(date +%Y%m%d%H%M%S)"
    echo "Backup created"
    ;;
  restore)
    if [ -z "${2:-}" ]; then echo "Usage: $0 restore <backupfile>"; exit 2; fi
    cp "$2" "$DB"
    echo "Restored"
    ;;
  *)
    echo "Usage: $0 {init|backup|restore}"; exit 2;;
esac
