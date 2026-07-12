#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/sync.sh
#
# Description:
#   Synchronize files from Git repository to Docker stack directory.
#
###############################################################################

###############################################################################
# Synchronize one file or directory
#
# Usage:
#   sync_item compose.yml
#   sync_item compose
#   sync_item configs
#
###############################################################################

sync_item() {

    local item="$1"

    require_file_or_directory "${GIT_DIR}/${item}"

    rsync -a --delete \
        "${GIT_DIR}/${item}" \
        "${STACK_DIR}/"

    ok "Synced ${item}"
}