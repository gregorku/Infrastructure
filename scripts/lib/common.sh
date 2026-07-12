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

separator() {
    printf '%80s\n' '' | tr ' ' '-'
}

require_root() {

    [[ "${EUID}" -eq 0 ]] \
        || die "Run this script as root."
}

require_command() {

    command -v "$1" >/dev/null 2>&1 \
        || die "Required command not found: $1"
}

require_git() {

    require_command git
}

require_rsync() {

    require_command rsync
}

require_docker() {

    require_command docker

    docker compose version >/dev/null 2>&1 \
        || die "Docker Compose plugin is not available."
}

confirm() {

    local reply

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