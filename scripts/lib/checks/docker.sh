#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/checks/docker.sh
#
# Description:
#   Docker helper functions used by Infrastructure scripts.
#
###############################################################################

###############################################################################
# Docker command
###############################################################################

require_docker()
{
    require_command docker
}

###############################################################################
# Docker daemon
###############################################################################

require_docker_daemon()
{
    docker info >/dev/null 2>&1 \
        || fail "Docker daemon is not running."
}

###############################################################################
# Docker environment
###############################################################################

check_docker_environment()
{
    check_environment

    require_docker

    require_docker_daemon

    ok "Docker environment OK."
}

###############################################################################
# Execute command inside container
###############################################################################

docker_exec()
{
    local container="$1"

    shift

    docker exec "${container}" "$@"
}

###############################################################################
# Container state
###############################################################################

docker_container_running()
{
    local container="$1"

    [[ "$(docker inspect \
        --format '{{.State.Running}}' \
        "${container}" 2>/dev/null)" == "true" ]]
}

###############################################################################
# Docker network
###############################################################################

docker_network_exists()
{
    local network="$1"

    docker network inspect "${network}" >/dev/null 2>&1
}

###############################################################################
# HTTP headers from inside container
###############################################################################

docker_http_headers()
{
    local container="$1"
    local url="$2"

    docker_exec "${container}" \
        wget \
            --no-check-certificate \
            -S \
            -O /dev/null \
            "${url}" \
            2>&1 || true
}