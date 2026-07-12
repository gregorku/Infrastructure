#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/deploy.sh
#
# Description:
#   Synchronize Infrastructure Git repository into the Docker stack directory
#   and validate the Docker Compose configuration.
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

print_section "Infrastructure deployment"

check_docker_environment

###############################################################################
# Verify project
###############################################################################

print_section "Verifying project"

verify_project

###############################################################################
# Synchronize stack
###############################################################################

print_section "Synchronizing stack"

ensure_directory "${STACK_DIR}"

sync_stack

###############################################################################
# Environment file
###############################################################################

if [[ ! -f "${STACK_DIR}/.env" ]]; then

    cp \
        "${STACK_DIR}/.env.example" \
        "${STACK_DIR}/.env"

    ok ".env created from .env.example"

else

    info ".env already exists"

fi

###############################################################################
# Validate Docker Compose
###############################################################################

print_section "Compose validation"

validate_compose

###############################################################################
# Finished
###############################################################################

print_section "Deployment completed"

ok "Stack synchronized."

info "Repository : ${GIT_DIR}"
info "Stack      : ${STACK_DIR}"

echo

info "Next step:"
info "Open Dockge and click Redeploy."