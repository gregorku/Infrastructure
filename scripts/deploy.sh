#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/deploy.sh
#
# Description:
#   Deploy the Infrastructure stack to the Docker environment.
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

source "${SCRIPT_DIR}/lib/common.sh"
source "${SCRIPT_DIR}/lib/logging.sh"

###############################################################################
# Checks library
###############################################################################

source "${SCRIPT_DIR}/lib/checks/load.sh"

###############################################################################
# Environment library
###############################################################################

source "${SCRIPT_DIR}/lib/env/load.sh"

###############################################################################
# Deploy library
###############################################################################

source "${SCRIPT_DIR}/lib/deploy/verify.sh"
source "${SCRIPT_DIR}/lib/deploy/sync.sh"
source "${SCRIPT_DIR}/lib/deploy/check-env.sh"
source "${SCRIPT_DIR}/lib/deploy/compose.sh"
source "${SCRIPT_DIR}/lib/deploy/summary.sh"

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
# Synchronize repository to stack directory.
#
deploy_sync_stack

#
# Verify synchronized environment.
#
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