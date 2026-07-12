#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/logging.sh
#
# Description:
#   Logging helpers used by all Infrastructure scripts.
#
###############################################################################

###############################################################################
# Log messages
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

###############################################################################
# Sections
###############################################################################

log_step() {

    separator

    printf "%s\n" "$*"

    separator
}

###############################################################################
# Backward compatibility
###############################################################################

info() {
    log_info "$@"
}

ok() {
    log_success "$@"
}

warn() {
    log_warn "$@"
}

fail() {
    log_error "$@"
    exit 1
}

print_section() {
    log_step "$@"
}

print_header() {
    log_step "$@"
}