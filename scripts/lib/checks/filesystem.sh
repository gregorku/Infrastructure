#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/checks/filesystem.sh
#
# Description:
#   Filesystem helper functions.
#
###############################################################################

###############################################################################
# Require directory
###############################################################################

require_directory()
{
    local dir="$1"

    [[ -d "${dir}" ]] \
        || fail "Directory not found: ${dir}"
}

###############################################################################
# Require file
###############################################################################

require_file()
{
    local file="$1"

    [[ -f "${file}" ]] \
        || fail "File not found: ${file}"
}

###############################################################################
# Require file or directory
###############################################################################

require_file_or_directory()
{
    local path="$1"

    [[ -e "${path}" ]] \
        || fail "Path not found: ${path}"
}

###############################################################################
# Ensure directory
###############################################################################

ensure_directory()
{
    local dir="$1"

    mkdir -p "${dir}"

    ok "Directory ready: ${dir}"
}

###############################################################################
# Ensure file
###############################################################################

ensure_file()
{
    local file="$1"

    touch "${file}"

    ok "File ready: ${file}"
}

###############################################################################
# Ensure file mode
###############################################################################

ensure_file_mode()
{
    local file="$1"
    local mode="$2"

    touch "${file}"

    chmod "${mode}" "${file}"

    ok "Permissions ${mode}: ${file}"
}

###############################################################################
# Verify file exists
###############################################################################

file_exists()
{
    local file="$1"

    [[ -f "${file}" ]] \
        || fail "File not found: ${file}"

    ok "File exists: ${file}"
}

###############################################################################
# Verify file permissions
###############################################################################

permissions_are()
{
    local expected="$1"
    local file="$2"

    local current

    current="$(stat -c '%a' "${file}")"

    [[ "${current}" == "${expected}" ]] \
        || fail "Permissions ${current}, expected ${expected}: ${file}"

    ok "Permissions ${expected}: ${file}"
}