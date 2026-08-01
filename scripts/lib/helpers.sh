#!/usr/bin/env bash

require_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This command must be run as root."
        exit 1
    fi
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

container_running() {
    docker ps --format '{{.Names}}' | grep -qx "$1"
}
