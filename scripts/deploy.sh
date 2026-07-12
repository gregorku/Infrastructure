#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   deploy.sh
#
# Description:
#   Synchronize Git repository into Docker stack directory.
#
###############################################################################

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/config.sh"
source "${SCRIPT_DIR}/lib/logging.sh"
source "${SCRIPT_DIR}/lib/common.sh"
source "${SCRIPT_DIR}/lib/filesystem.sh"
source "${SCRIPT_DIR}/lib/sync.sh"
source "${SCRIPT_DIR}/lib/docker-compose.sh"

###############################################################################
# Main
###############################################################################

print_header "Infrastructure deployment"

check_environment

###############################################################################

print_section "Synchronizing stack"

ensure_directory "${STACK_DIR}"

sync_item compose.yml
sync_item compose
sync_item configs
sync_item .env.example

###############################################################################
# .env
###############################################################################

if [[ ! -f "${STACK_DIR}/.env" ]]; then
    cp "${STACK_DIR}/.env.example" "${STACK_DIR}/.env"
    ok ".env created from .env.example"
else
    info ".env already exists"
fi

###############################################################################
# Validate compose
###############################################################################

print_section "Compose validation"

validate_compose

###############################################################################
# Finished
###############################################################################

print_section "Deployment completed"

ok "Stack synchronized."

info "Stack directory : ${STACK_DIR}"
info "Open Dockge and click Redeploy."