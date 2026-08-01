#!/usr/bin/env bash

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

CONFIG_FILE="$ROOT/config/toolkit.conf"

if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
else
    echo "[WARN] toolkit.conf not found. Using defaults."

    APPDATA="/mnt/truenas"
    REPORTDIR="$ROOT/reports"
    BACKUPDIR="$ROOT/backups"
    DOMAIN="osier.local"
fi
