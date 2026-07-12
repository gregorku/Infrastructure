#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/test.sh
#
###############################################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/bootstrap.sh"

log_step "Testing Infrastructure library"

require_git
require_docker

log_success "Environment OK."

log_step "Filesystem"

ensure_directory "/tmp/infrastructure-test"
ensure_file "/tmp/infrastructure-test/test.txt"

log_success "Filesystem library OK."

log_step "Git"

log_info "Git branch   : $(git_current_branch)"
log_info "Git revision : $(git_current_revision)"

log_step "Docker"

if [[ -f "${COMPOSE_FILE}" ]]; then
    docker_compose_config
    log_success "Docker library OK."
else
    log_warn "Compose file not found yet."
    log_info "Expected: ${COMPOSE_FILE}"
fi

log_step "Finished"

log_success "All tests finished successfully."