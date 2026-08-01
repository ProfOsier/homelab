RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"
RESET="\033[0m"

red(){ echo -e "${RED}$*${RESET}"; }
green(){ echo -e "${GREEN}$*${RESET}"; }
yellow(){ echo -e "${YELLOW}$*${RESET}"; }
blue(){ echo -e "${BLUE}$*${RESET}"; }
cyan(){ echo -e "${CYAN}$*${RESET}"; }
