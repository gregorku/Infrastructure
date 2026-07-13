#!/usr/bin/env bash

...

source "${SCRIPT_DIR}/lib/deploy/verify.sh"
source "${SCRIPT_DIR}/lib/deploy/sync.sh"
source "${SCRIPT_DIR}/lib/deploy/compose.sh"
source "${SCRIPT_DIR}/lib/deploy/summary.sh"

print_section "Infrastructure deployment"

check_docker_environment

deploy_verify_project
deploy_sync_stack
deploy_validate_compose
deploy_summary