#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/deploy.sh
#
# Description:
#   Deploy Infrastructure services.
#
# Responsibilities:
#   - Verify deployment environment
#   - Deploy Dockge
#   - Deploy Infrastructure Docker Compose stack
#   - Print deployment summary
#
###############################################################################

set -Eeuo pipefail

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
# Checks
###############################################################################

source "${SCRIPT_DIR}/lib/checks/load.sh"

###############################################################################
# Environment
###############################################################################

source "${SCRIPT_DIR}/lib/env/load.sh"

###############################################################################
# Deployment modules
###############################################################################

source "${SCRIPT_DIR}/lib/deploy/verify.sh"
source "${SCRIPT_DIR}/lib/deploy/check-env.sh"
source "${SCRIPT_DIR}/lib/deploy/dockge.sh"
source "${SCRIPT_DIR}/lib/deploy/wait.sh"
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
# Verify .env.
#
deploy_check_env

#
# Deploy Dockge.
#
deploy_dockge

#
# Wait until Dockge is ready.
#
deploy_wait_dockge

#
# Validate Docker Compose configuration.
#
deploy_validate_compose

#
# Deploy Infrastructure stack.
#
deploy_compose

#
# Print deployment summary.
#
deploy_summary

print_footer "Deployment completed."