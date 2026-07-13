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
# Configuration
###############################################################################

source "${SCRIPT_DIR}/config.sh"

###############################################################################
# Core libraries
###############################################################################

#
# Common helper functions.
#
source "${SCRIPT_DIR}/lib/common.sh"

#
# Logging functions.
#
source "${SCRIPT_DIR}/lib/logging.sh"

###############################################################################
# Checks library
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
# Print deployment summary.
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

#
# Validate Docker Compose configuration.
#
deploy_validate_compose

#
# Print deployment summary.
#
deploy_summary