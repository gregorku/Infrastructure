#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy/wait.sh
#
# Description:
#   Wait for Docker services to become ready.
#
###############################################################################

###############################################################################
# Wait for Dockge
###############################################################################

deploy_wait_dockge()
{
    print_section "Waiting for Dockge"

    log_info "Waiting for Dockge to start..."

    local timeout=30
    local elapsed=0

    while (( elapsed < timeout )); do
        if docker inspect -f '{{.State.Running}}' dockge 2>/dev/null | grep -q true; then
            log_success "Dockge is running."
            return
        fi

        sleep 1
        ((elapsed++))
    done

    die "Timed out waiting for Dockge."
}