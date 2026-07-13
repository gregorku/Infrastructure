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

set -Eeuo pipefail

###############################################################################
# Directories
###############################################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

###############################################################################
# Core libraries
###############################################################################

source "${SCRIPT_DIR}/lib/config.sh"

source "${SCRIPT_DIR}/lib/common.sh"

source "${SCRIPT_DIR}/lib/logging.sh"

###############################################################################
# Required helpers
###############################################################################

#
# Docker helper functions.
#
source "${SCRIPT_DIR}/lib/checks/docker.sh"

#
# Filesystem helper functions.
#
source "${SCRIPT_DIR}/lib/checks/filesystem.sh"

#
# Docker Compose helper functions.
#
source "${SCRIPT_DIR}/lib/checks/compose.sh"

###############################################################################
# Deploy modules
###############################################################################

#
# Verify project structure.
#
source "${SCRIPT_DIR}/lib/deploy/verify.sh"

#
# Synchronize repository to stack directory.
#
source "${SCRIPT_DIR}/lib/deploy/sync.sh"

#
# Validate Docker Compose configuration.
#
source "${SCRIPT_DIR}/lib/deploy/compose.sh"

#
# Deployment summary.
#
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
# Verify Docker.
#
check_docker_environment

#
# Verify project.
#
deploy_verify_project

#
# Synchronize stack.
#
deploy_sync_stack

#
# Validate Compose.
#
deploy_validate_compose

#
# Print summary.
#
deploy_summary