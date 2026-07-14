#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/bootstrap.sh
#
# Description:
#   Bootstrap Infrastructure on a new server.
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

###############################################################################
# Run one bootstrap step
#
# Usage:
#   run_step init.sh
#
###############################################################################

run_step() {

    local script="$1"

    print_section "Running ${script}"

    "${SCRIPT_DIR}/${script}"

    ok "${script} completed."
}

###############################################################################
# Main
###############################################################################

print_section "Infrastructure bootstrap"

run_step init.sh

run_step deploy.sh

run_step test.sh

###############################################################################
# Finished
###############################################################################

print_section "Bootstrap completed"

ok "Infrastructure is ready."

echo

info "Next step:"
info "Open Dockge and click Redeploy."

--------------------------------------------------------------------------------
Infrastructure bootstrap completed successfully.
--------------------------------------------------------------------------------