#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/test.sh
#
# Description:
#   Verify Infrastructure installation.
#
###############################################################################

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

###############################################################################
# Configuration
###############################################################################

source "${SCRIPT_DIR}/config.sh"

###############################################################################
# Libraries
###############################################################################

source "${SCRIPT_DIR}/lib/logging.sh"
source "${SCRIPT_DIR}/lib/common.sh"
source "${SCRIPT_DIR}/lib/filesystem.sh"
source "${SCRIPT_DIR}/lib/sync.sh"
source "${SCRIPT_DIR}/lib/docker.sh"
source "${SCRIPT_DIR}/lib/docker-compose.sh"

###############################################################################
# Main
###############################################################################

print_section "Infrastructure test"

check_docker_environment

###############################################################################
# Project
###############################################################################

print_section "Project"

verify_project

###############################################################################
# Stack
###############################################################################

print_section "Stack"

require_directory "${STACK_DIR}"

require_file "${STACK_DIR}/compose.yml"

require_directory "${STACK_DIR}/compose"

require_directory "${STACK_DIR}/configs"

ok "Stack directory OK."

###############################################################################
# Environment
###############################################################################

print_section ".env"

require_file "${STACK_DIR}/.env"

ok ".env OK."

###############################################################################
# Docker Compose
###############################################################################

print_section "Docker Compose"

validate_compose

###############################################################################
# Docker daemon
###############################################################################

print_section "Docker"

ok "Docker daemon OK."

###############################################################################
# Dockge
###############################################################################

print_section "Dockge"

if docker_container_running "${DOCKGE_CONTAINER}"; then

    DOCKGE_PATH="$(
        docker_exec \
            "${DOCKGE_CONTAINER}" \
            printenv DOCKGE_STACKS_DIR
    )"

    if [[ "${DOCKGE_PATH}" == "/zfs-data/stacks" ]]; then

        ok "Dockge stack path OK."

    else

        fail "Dockge stack path is '${DOCKGE_PATH}'."

    fi

else

    warn "Dockge container is not running."

fi

###############################################################################
# Docker networks
###############################################################################

print_section "Docker networks"

docker_network_exists "${NETWORK_INTERNAL}" \
    || fail "Missing Docker network: ${NETWORK_INTERNAL}"

docker_network_exists "${NETWORK_TRAEFIK}" \
    || fail "Missing Docker network: ${NETWORK_TRAEFIK}"

ok "Docker networks OK."

###############################################################################
# Finished
###############################################################################

print_section "Finished"

ok "Infrastructure framework OK."