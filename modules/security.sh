#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
case "${1:-genkey}" in
  genkey)
    mkdir -p "$ROOT/keys"
    ssh-keygen -t ed25519 -f "$ROOT/keys/serverforge_ed25519" -N "" -C "serverforge" >/dev/null
    echo "Keypair generated under $ROOT/keys"
    ;;
  cert)
    echo "Certificate operations not implemented in offline build."
    ;;
  *)
    echo "Usage: $0 {genkey|cert}"; exit 2;;
esac
