#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/deploy.sh
#
# Description:
#   Synchronize the Infrastructure repository to the Docker stack directory.
#
###############################################################################

set -euo pipefail

###############################################################################
# Directories
###############################################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

###############################################################################
# Configuration
###############################################################################

source "${SCRIPT_DIR}/config.sh"

###############################################################################
# Core libraries
###############################################################################

source "${SCRIPT_DIR}/lib/paths.sh"
source "${SCRIPT_DIR}/lib/logging.sh"
source "${SCRIPT_DIR}/lib/common.sh"

###############################################################################
# Checks library
###############################################################################

source "${SCRIPT_DIR}/lib/checks/load.sh"

###############################################################################
# Deploy modules
###############################################################################

source "${SCRIPT_DIR}/lib/deploy/verify.sh"
source "${SCRIPT_DIR}/lib/deploy/sync.sh"
source "${SCRIPT_DIR}/lib/deploy/compose.sh"
source "${SCRIPT_DIR}/lib/deploy/summary.sh"
source "${SCRIPT_DIR}/lib/deploy/check-env.sh"

###############################################################################
# Main
###############################################################################

print_header "Infrastructure deployment"

#
# Verify environment.
#
check_environment

#
# Verify Docker environment.
#
check_docker_environment

#
# Verify project structure.
#
deploy_verify_project

#
# Synchronize stack.
#
deploy_sync_stack
deploy_check_env

#
# Validate Docker Compose configuration.
#
deploy_validate_compose

#
# Print deployment summary.
#
deploy_summary
print_footer "Deployment finished."