#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/test.sh
#
###############################################################################

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/config.sh"

source "${SCRIPT_DIR}/lib/logging.sh"
source "${SCRIPT_DIR}/lib/common.sh"
source "${SCRIPT_DIR}/lib/filesystem.sh"
source "${SCRIPT_DIR}/lib/docker.sh"
source "${SCRIPT_DIR}/lib/git.sh"

separator

log_info "Testing Infrastructure library"

require_git
require_docker

log_success "Environment OK."

separator

ensure_directory "/tmp/infrastructure-test"
ensure_file "/tmp/infrastructure-test/test.txt"

log_success "Filesystem library OK."

separator

log_info "Git branch   : $(git_current_branch)"
log_info "Git revision : $(git_current_revision)"

separator

if [[ -f "${COMPOSE_FILE}" ]]; then
    docker_compose_config
    log_success "Docker library OK."
else
    log_warn "Compose file not found yet."
    log_info "Expected: ${COMPOSE_FILE}"
fi

separator

log_success "All tests finished successfully."