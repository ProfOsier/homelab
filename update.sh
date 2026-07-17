#!/usr/bin/env bash

set -euo pipefail

echo "========================================="
echo " Homelab Update"
echo "========================================="
echo

echo "[1/7] Updating Git repository..."
git pull

echo
echo "[2/7] Pulling Docker images..."
docker compose pull

echo
echo "[3/7] Recreating updated containers..."
docker compose up -d

echo
echo "[4/7] Removing unused Docker images..."
docker image prune -f

echo
echo "[5/7] Removing unused Docker networks..."
docker network prune -f

echo
echo "[6/7] Current container status..."
docker ps

echo
echo "[7/7] Running health verification..."
./verify.sh

echo
echo "========================================="
echo " Update Complete"
echo "========================================="
