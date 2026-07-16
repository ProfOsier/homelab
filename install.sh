#!/usr/bin/env bash
set -euo pipefail

echo "========================================="
echo " Homelab Infrastructure Installer"
echo "========================================="
echo

# Verify operating system
if ! grep -qi "ubuntu\|debian" /etc/os-release; then
    echo "ERROR: This installer supports Ubuntu and Debian only."
    exit 1
fi

echo "[1/8] Updating package lists..."
apt update

echo "[2/8] Installing required packages..."
apt install -y \
    ca-certificates \
    curl \
    git \
    unzip \
    jq

if ! command -v docker >/dev/null 2>&1; then
    echo "[3/8] Installing Docker..."

    curl -fsSL https://get.docker.com | sh
else
    echo "[3/8] Docker already installed."
fi

echo "[4/8] Enabling Docker..."
systemctl enable docker
systemctl start docker

if docker compose version >/dev/null 2>&1; then
    echo "[5/8] Docker Compose detected."
else
    echo "ERROR: Docker Compose is not installed."
    exit 1
fi

echo "[6/8] Creating project directories..."

mkdir -p backups
mkdir -p logs
mkdir -p compose
mkdir -p config
mkdir -p assets
mkdir -p docs

echo "[7/8] Pulling container images..."
docker compose pull

echo "[8/8] Starting containers..."
docker compose up -d

echo
echo "========================================="
echo " Installation Complete"
echo "========================================="
echo

docker ps
