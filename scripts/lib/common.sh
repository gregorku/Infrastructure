#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/common.sh
#
###############################################################################

die() {
    log_error "$*"
    exit 1
}

require_root() {
    [[ "${EUID}" -eq 0 ]] || die "Run this script as root."
}

require_command() {
    command -v "$1" >/dev/null 2>&1 \
        || die "Required command not found: $1"
}

separator() {
    printf '%*s\n' "${COLUMNS:-80}" '' | tr ' ' '-'
}

confirm() {

    read -r -p "$1 [y/N]: " reply

    case "${reply}" in
        [Yy]|[Yy][Ee][Ss])
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}