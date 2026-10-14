#!/bin/bash
# Nama: Muhammad Revio
# NIM: 09011382530148
# Kelas: SKU3B

INTERVAL="${INTERVAL:-60}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

while true; do
  "$SCRIPT_DIR/backup.sh"
  sleep "$INTERVAL"
done
