#!/usr/bin/env bash

set -e

PASS="✓"
FAIL="✗"

echo
echo "========================================="
echo "        Homelab Health Check"
echo "========================================="
echo

check() {
    local description="$1"
    shift

    if "$@" >/dev/null 2>&1; then
        printf "%-40s %s\n" "$description" "$PASS"
    else
        printf "%-40s %s\n" "$description" "$FAIL"
    fi
}

echo "System"

check "Internet Connectivity" ping -c1 8.8.8.8
check "DNS Resolution" ping -c1 github.com
check "Docker Installed" docker --version
check "Docker Service" systemctl is-active docker
check "Git Installed" git --version

echo
echo "Infrastructure"

check "OPNsense (192.168.1.1)" ping -c1 192.168.1.1
check "Pi-hole (192.168.1.5)" ping -c1 192.168.1.5
check "TrueNAS (192.168.1.7)" ping -c1 192.168.1.7
check "Omada Controller (192.168.1.3)" ping -c1 192.168.1.3

echo
echo "Docker"

docker ps --format "table {{.Names}}\t{{.Status}}"

echo
echo "Disk Usage"

df -h /

echo
echo "Memory Usage"

free -h

echo
echo "Git Repository"

git status --short

echo
echo "Latest Commit"

git log -1 --oneline

echo
echo "========================================="
echo "Verification Complete"
echo "========================================="
