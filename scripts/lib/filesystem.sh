#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/filesystem.sh
#
# Description:
#   Filesystem helper functions.
#
###############################################################################

###############################################################################
# Create directory
#
# Usage:
#   ensure_directory /path/to/directory
#
###############################################################################

ensure_directory() {

    local directory="$1"

    mkdir -p "${directory}"

    ok "Directory ready: ${directory}"
}

###############################################################################
# Create file
#
# Usage:
#   ensure_file /path/to/file
#
###############################################################################

ensure_file() {

    local file="$1"

    if [[ ! -f "${file}" ]]; then
        touch "${file}"
    fi

    ok "File ready: ${file}"
}

###############################################################################
# Create file with permissions
#
# Usage:
#   ensure_file_mode /path/to/file 600
#
###############################################################################

ensure_file_mode() {

    local file="$1"
    local mode="$2"

    ensure_file "${file}"

    chmod "${mode}" "${file}"

    ok "Permissions ${mode}: ${file}"
}

###############################################################################
# Remove file
#
# Usage:
#   remove_file /path/to/file
#
###############################################################################

remove_file() {

    local file="$1"

    if [[ -f "${file}" ]]; then
        rm -f "${file}"
        ok "Removed file: ${file}"
    fi
}

###############################################################################
# Remove directory
#
# Usage:
#   remove_directory /path/to/directory
#
###############################################################################

remove_directory() {

    local directory="$1"

    if [[ -d "${directory}" ]]; then
        rm -rf "${directory}"
        ok "Removed directory: ${directory}"
    fi
}