#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy/sync.sh
#
# Description:
#   Synchronize Infrastructure repository to Docker stack directory.
#
###############################################################################

###############################################################################
# Synchronize one file or directory
###############################################################################

deploy_sync_item()
{
    local item="$1"

    require_file_or_directory "${GIT_DIR}/${item}"

    rsync \
        -a \
        --delete \
        "${GIT_DIR}/${item}" \
        "${STACK_DIR}/"

    ok "Synced ${item}"
}

###############################################################################
# Synchronize complete stack
###############################################################################

deploy_sync_stack()
{
    print_section "Synchronizing stack"

    local item

    require_directory "${STACK_DIR}"

    for item in "${DEPLOY_ITEMS[@]}"; do
        deploy_sync_item "${item}"
    done
}