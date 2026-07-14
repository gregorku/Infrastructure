#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/test.sh
#
# Description:
#   Run Infrastructure framework tests.
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
# Checks library
###############################################################################

source "${SCRIPT_DIR}/lib/checks/load.sh"

###############################################################################
# Test modules
###############################################################################

source "${SCRIPT_DIR}/lib/tests/project.sh"
source "${SCRIPT_DIR}/lib/tests/stack.sh"
source "${SCRIPT_DIR}/lib/tests/environment.sh"
source "${SCRIPT_DIR}/lib/tests/compose.sh"
source "${SCRIPT_DIR}/lib/tests/docker.sh"
source "${SCRIPT_DIR}/lib/tests/dockge.sh"
source "${SCRIPT_DIR}/lib/tests/networks.sh"
source "${SCRIPT_DIR}/lib/tests/dashboard-security.sh"
source "${SCRIPT_DIR}/lib/tests/traefik.sh"
source "${SCRIPT_DIR}/lib/tests/crowdsec.sh"

###############################################################################
# Main
###############################################################################

print_header "Infrastructure test"

check_environment
check_docker_environment

test_project
test_stack
test_environment
test_compose
test_docker
test_dockge
test_networks
test_dashboard_security
test_traefik
test_crowdsec

print_section "Finished"

ok "Infrastructure framework OK."