#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/init.sh
#
###############################################################################

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/config.sh"

source "${SCRIPT_DIR}/lib/logging.sh"
source "${SCRIPT_DIR}/lib/common.sh"
source "${SCRIPT_DIR}/lib/filesystem.sh"

separator

log_info "Infrastructure initialization"

separator

require_root
require_git
require_docker
require_rsync

log_success "Environment OK."

separator

ensure_directory "${STACK_DIR}"

ensure_directory "${DATA_DIR}"

log_success "Project directories ready."

separator

create_traefik_layout

create_crowdsec_layout

create_watchtower_layout

separator

log_success "Initialization completed."

separator