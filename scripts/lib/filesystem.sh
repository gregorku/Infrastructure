#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/filesystem.sh
#
###############################################################################

ensure_directory() {

    local dir="$1"

    if [[ ! -d "${dir}" ]]; then
        mkdir -p "${dir}"
        log_info "Created directory: ${dir}"
    fi
}

ensure_file() {

    local file="$1"

    if [[ ! -f "${file}" ]]; then
        touch "${file}"
        log_info "Created file: ${file}"
    fi
}

copy_if_missing() {

    local src="$1"
    local dst="$2"

    if [[ ! -f "${dst}" ]]; then
        cp "${src}" "${dst}"
        log_info "Created ${dst}"
    fi
}