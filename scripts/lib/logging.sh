#!/usr/bin/env bash

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
RESET='\033[0m'

timestamp() {
    date '+%F %T'
}

info() {
    echo -e "${BLUE}[$(timestamp)] INFO${RESET} $*"
}

ok() {
    echo -e "${GREEN}[$(timestamp)] OK${RESET} $*"
}

warn() {
    echo -e "${YELLOW}[$(timestamp)] WARN${RESET} $*"
}

error() {
    echo -e "${RED}[$(timestamp)] ERROR${RESET} $*"
}
