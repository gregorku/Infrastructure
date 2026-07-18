#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy/dockge.sh
#
# Description:
#   Deploy and start the Dockge service.
#
###############################################################################

###############################################################################
# Deploy Dockge
###############################################################################

deploy_dockge() {

    print_section "Dockge"

    #
    # Verify Docker Compose file.
    #
    require_file "${DOCKGE_COMPOSE_FILE}"

    #
    # Dockge already running.
    #
    if docker container inspect dockge >/dev/null 2>&1; then

        if [[ "$(docker inspect -f '{{.State.Running}}' dockge)" == "true" ]]; then
            log_success "Dockge is already running."
            return
        fi

    fi

    log_info "Starting Dockge..."

    docker compose \
        --project-name dockge \
        --file "${DOCKGE_COMPOSE_FILE}" \
        --env-file "${DOCKGE_ENV_FILE}" \
        up -d

    log_success "Dockge deployed."

}