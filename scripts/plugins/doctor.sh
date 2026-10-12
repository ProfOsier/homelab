#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "$ROOT/scripts/lib/colors.sh"
source "$ROOT/scripts/lib/logging.sh"
source "$ROOT/scripts/lib/config.sh"
source "$ROOT/scripts/lib/helpers.sh"

require_root

TOTAL=0
PASS=0

check() {

    ((++TOTAL))

    printf "%-35s" "$1"

    if eval "$2" >/dev/null 2>&1; then
        ((++PASS))
        green "✔"
    else
        red "✘"
    fi
}

info "Running Homelab Doctor"

check "Docker" "command_exists docker"
check "Docker Compose" "docker compose version"
check "Git" "command_exists git"
check "TrueNAS Mount" "mount | grep -q '$APPDATA'"

check "Homepage" "container_running homepage"
check "OpenObserve" "container_running openobserve"
check "Alloy Log Collector" "container_running alloy"
check "Prometheus" "container_running prometheus"
check "Portainer" "container_running portainer"
check "NPM" "container_running npm"
check "Uptime Kuma" "container_running uptime-kuma"
check "NetAlertX" "container_running netalertx"

echo
echo "Health Score: $PASS / $TOTAL"

if [[ "$PASS" -eq "$TOTAL" ]]; then
    ok "System Healthy"
else
    warn "$((TOTAL-PASS)) checks failed"
fi
