#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/init.sh
#
###############################################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/bootstrap.sh"

log_step "Infrastructure initialization"

require_root
require_git
require_docker
require_rsync

log_success "Environment OK."

log_step "Project directories"

ensure_directory "${STACK_DIR}"
ensure_directory "${DATA_DIR}"

log_info "Stack directory : ${STACK_DIR}"
log_info "Data directory  : ${DATA_DIR}"

log_step "Traefik"

create_traefik_layout

log_step "CrowdSec"

create_crowdsec_layout

log_step "Watchtower"

create_watchtower_layout

log_step "Finished"

log_success "Initialization completed."