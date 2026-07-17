#!/usr/bin/env bash

set -euo pipefail

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="backups/$TIMESTAMP"

echo "========================================="
echo " Homelab Backup"
echo "========================================="
echo

mkdir -p "$BACKUP_DIR"

echo "[1/6] Saving Git information..."

git status > "$BACKUP_DIR/git-status.txt"
git log --oneline -20 > "$BACKUP_DIR/git-history.txt"

echo "[2/6] Saving Docker information..."

docker ps -a > "$BACKUP_DIR/docker-containers.txt"
docker images > "$BACKUP_DIR/docker-images.txt"

echo "[3/6] Saving Docker Compose configuration..."

docker compose config > "$BACKUP_DIR/docker-compose-expanded.yml"

echo "[4/6] Archiving repository..."

tar \
    --exclude=.git \
    --exclude=backups \
    -czf "$BACKUP_DIR/homelab.tar.gz" .

echo "[5/6] Saving system information..."

uname -a > "$BACKUP_DIR/system.txt"
df -h > "$BACKUP_DIR/disk.txt"
free -h > "$BACKUP_DIR/memory.txt"

echo "[6/6] Backup complete."

echo
echo "Backup saved to:"
echo "$BACKUP_DIR"
