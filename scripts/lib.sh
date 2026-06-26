#!/usr/bin/env bash
# Shared logging helpers — source this at the top of every script

RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

log_error()  { echo -e "${RED}[error]${NC} $*" >&2; }
log_warn()   { echo -e "${YELLOW}[warn]${NC} $*"; }
log_info()   { echo -e "${CYAN}[info]${NC} $*"; }
log_done()   { echo -e "${GREEN}[done]${NC} $*"; }
log_step()   { echo -e "  ${BLUE}→${NC} $*"; }
log_header() { local tag="$1"; shift; echo -e "\n${BOLD}${BLUE}[${tag}]${NC} $*"; }
