#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
PIDFILE="$ROOT/.serverforge_server.pid"
case "${1:-status}" in
  start)
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" >/dev/null 2>&1; then
      echo "Server already running with PID $(cat "$PIDFILE")"
      exit 0
    fi
    nohup python3 -m http.server 8000 --directory "$ROOT" >/dev/null 2>&1 &
    echo $! > "$PIDFILE"
    echo "Server started, pid $(cat $PIDFILE)"
    ;;
  stop)
    if [ -f "$PIDFILE" ]; then
      kill "$(cat "$PIDFILE")" && rm -f "$PIDFILE"
      echo "Stopped server"
    else
      echo "No server PIDfile"
    fi
    ;;
  restart)
    $0 stop || true
    $0 start
    ;;
  status)
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE") >/dev/null 2>&1"; then
      echo "Running (pid $(cat $PIDFILE))"
    else
      echo "Not running"
    fi
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"; exit 2;;
esac
