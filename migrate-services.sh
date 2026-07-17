#!/usr/bin/env bash
set -Eeuo pipefail

cd /opt/homelab

SERVICES=(
  homepage
  npm
  grafana
  prometheus
  portainer
  dozzle
  watchtower
  cadvisor
  node-exporter
  promtail
  loki
)

copy_if_exists() {
    local src="$1"
    local dst="$2"

    if [[ -d "$src" ]]; then
        echo "Copying $src -> $dst"
        mkdir -p "$dst"
        rsync -a "$src/" "$dst/"
    else
        echo "Skipping $src (not found)"
    fi
}

echo
echo "=== Copying configuration ==="

copy_if_exists /opt/homepage/config      config/infrastructure/homepage
copy_if_exists /opt/npm/data             config/infrastructure/npm/data
copy_if_exists /opt/npm/letsencrypt      config/infrastructure/npm/letsencrypt
copy_if_exists /opt/grafana              config/monitoring/grafana
copy_if_exists /opt/prometheus           config/monitoring/prometheus
copy_if_exists /opt/portainer            config/infrastructure/portainer
copy_if_exists /opt/dozzle               config/infrastructure/dozzle
copy_if_exists /opt/cadvisor             config/monitoring/cadvisor

echo
echo "=== Recreating containers ==="

for svc in "${SERVICES[@]}"; do
    if docker ps -a --format '{{.Names}}' | grep -qx "$svc"; then
        echo
        echo "Migrating $svc"

        docker stop "$svc" || true
        docker rm "$svc" || true

        docker compose up -d "$svc"

        docker inspect "$svc" >/dev/null

        echo "✓ $svc"
    else
        echo
        echo "Skipping $svc (container not present)"
    fi
done

echo
echo "Migration complete."

docker compose ps
