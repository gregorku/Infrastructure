#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/test.sh
#
# Description:
#   Verify Infrastructure installation.
#
###############################################################################

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

###############################################################################
# Configuration
###############################################################################

source "${SCRIPT_DIR}/config.sh"

###############################################################################
# Libraries
###############################################################################

source "${SCRIPT_DIR}/lib/logging.sh"
source "${SCRIPT_DIR}/lib/common.sh"
source "${SCRIPT_DIR}/lib/filesystem.sh"
source "${SCRIPT_DIR}/lib/sync.sh"
source "${SCRIPT_DIR}/lib/docker.sh"
source "${SCRIPT_DIR}/lib/docker-compose.sh"

###############################################################################
# Test modules
###############################################################################

source "${SCRIPT_DIR}/lib/tests/project.sh"
source "${SCRIPT_DIR}/lib/tests/stack.sh"
source "${SCRIPT_DIR}/lib/tests/environment.sh"
source "${SCRIPT_DIR}/lib/tests/compose.sh"
source "${SCRIPT_DIR}/lib/tests/traefik.sh"
source "${SCRIPT_DIR}/lib/tests/docker.sh"
source "${SCRIPT_DIR}/lib/tests/dockge.sh"
source "${SCRIPT_DIR}/lib/tests/networks.sh"
source "${SCRIPT_DIR}/lib/tests/dashboard-security.sh"

###############################################################################
# Main
###############################################################################

print_section "Infrastructure test"

check_docker_environment

test_project
test_stack
test_environment
test_compose
test_docker
test_dockge
test_networks
test_dashboard-security
test_traefik

print_section "Finished"

ok "Infrastructure framework OK."