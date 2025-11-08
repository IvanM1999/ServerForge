#!/usr/bin/env bash
echo "Sandbox helper: create limited directory for testing."
ROOT=$(cd "$(dirname "$0")/.." && pwd)
SBOX="$ROOT/sandbox"
mkdir -p "$SBOX"
echo "Sandbox ready at $SBOX"
