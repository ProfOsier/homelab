#!/usr/bin/env bash
set -Eeuo pipefail

cd /opt/homelab

echo "===== Creating directories ====="

mkdir -p config/infrastructure/homepage
mkdir -p config/infrastructure/npm/data
mkdir -p config/infrastructure/npm/letsencrypt
mkdir -p config/infrastructure/portainer/data

mkdir -p config/monitoring/grafana
mkdir -p config/monitoring/prometheus
mkdir -p config/monitoring/prometheus-data
mkdir -p config/monitoring/loki
mkdir -p config/monitoring/promtail

echo
echo "===== Copying bind-mounted data ====="

copy_dir () {
    SRC="$1"
    DST="$2"

    if [ -d "$SRC" ]; then
        echo "Copying $SRC"
        rsync -a "$SRC/" "$DST/"
    else
        echo "Skipping $SRC"
    fi
}

copy_file () {
    SRC="$1"
    DST="$2"

    if [ -f "$SRC" ]; then
        echo "Copying $SRC"
        cp -f "$SRC" "$DST"
    fi
}

copy_dir /opt/homepage/config config/infrastructure/homepage
copy_dir /opt/npm/data config/infrastructure/npm/data
copy_dir /opt/npm/letsencrypt config/infrastructure/npm/letsencrypt
copy_dir /opt/portainer/data config/infrastructure/portainer/data

copy_file /opt/prometheus/prometheus.yml config/monitoring/prometheus/prometheus.yml

echo
echo "===== Exporting Docker named volumes ====="

export_volume () {

    VOL="$1"
    DEST="$2"

    if docker volume inspect "$VOL" >/dev/null 2>&1; then

        mkdir -p "$DEST"

        docker run --rm \
            -v "$VOL":/from:ro \
            -v "$(pwd)/$DEST":/to \
            alpine \
            sh -c "cp -a /from/. /to/"

        echo "Exported $VOL"

    else

        echo "Volume $VOL not found"

    fi

}

export_volume grafana_grafana-data config/monitoring/grafana
export_volume prometheus_prometheus-data config/monitoring/prometheus-data

echo
echo "===== Stopping old containers ====="

docker stop \
homepage \
npm \
grafana \
prometheus \
portainer \
dozzle \
watchtower \
cadvisor \
node-exporter \
promtail \
loki 2>/dev/null || true

docker rm \
homepage \
npm \
grafana \
prometheus \
portainer \
dozzle \
watchtower \
cadvisor \
node-exporter \
promtail \
loki 2>/dev/null || true

echo
echo "===== Starting unified stack ====="

docker compose up -d

echo
echo "===== Verifying ====="

docker compose ps

echo
echo "Migration complete."
