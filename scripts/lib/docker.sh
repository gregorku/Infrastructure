#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/docker.sh
#
###############################################################################

docker_compose_config() {

    (
        cd "${STACK_DIR}"
        ${DOCKER_COMPOSE} config >/dev/null
    )

    log_success "Compose configuration is valid."
}

docker_compose_ps() {

    (
        cd "${STACK_DIR}"
        ${DOCKER_COMPOSE} ps
    )
}

docker_compose_pull() {

    (
        cd "${STACK_DIR}"
        ${DOCKER_COMPOSE} pull
    )
}

docker_compose_up() {

    (
        cd "${STACK_DIR}"
        ${DOCKER_COMPOSE} up -d
    )
}