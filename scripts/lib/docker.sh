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

    require_docker

    [[ -f "${COMPOSE_FILE}" ]] \
        || die "Compose file not found: ${COMPOSE_FILE}"

    (
        cd "${STACK_DIR}"
        docker compose config >/dev/null
    )

    log_success "Compose configuration is valid."
}

docker_compose_ps() {

    require_docker

    (
        cd "${STACK_DIR}"
        docker compose ps
    )
}

docker_compose_pull() {

    require_docker

    (
        cd "${STACK_DIR}"
        docker compose pull
    )
}

docker_compose_up() {

    require_docker

    (
        cd "${STACK_DIR}"
        docker compose up -d
    )
}