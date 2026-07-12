#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/logging.sh
#
###############################################################################

log_info() {
    printf "${COLOR_BLUE}[INFO]${COLOR_RESET} %s\n" "$*"
}

log_success() {
    printf "${COLOR_GREEN}[ OK ]${COLOR_RESET} %s\n" "$*"
}

log_warn() {
    printf "${COLOR_YELLOW}[WARN]${COLOR_RESET} %s\n" "$*"
}

log_error() {
    printf "${COLOR_RED}[FAIL]${COLOR_RESET} %s\n" "$*" >&2
}