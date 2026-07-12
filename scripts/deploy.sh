#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/deploy.sh
#
###############################################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/bootstrap.sh"

log_step "Infrastructure deployment"

require_root
require_git
require_rsync
require_docker

log_success "Environment OK."

log_step "Synchronizing stack"

ensure_directory "${STACK_DIR}"

for item in "${DEPLOY_ITEMS[@]}"; do
    sync_item "${item}"
done

copy_env_if_missing

log_step "Compose validation"

validate_compose

log_step "Deployment completed"

log_success "Stack synchronized."

log_info "Open Dockge and click Redeploy."