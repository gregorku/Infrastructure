#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/check-env.sh
#
# Description:
#   Verifies the stack .env file.
#
#   The script:
#
#     • Verifies that .env.example exists.
#
#     • Verifies that .env exists.
#
#     • Verifies that all variables from .env.example
#       exist in .env.
#
#     • Does not modify any files.
#
# Usage:
#
#   ./scripts/check-env.sh
#
###############################################################################

set -euo pipefail

###############################################################################
# Directories
###############################################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LIB_DIR="${SCRIPT_DIR}/lib"

###############################################################################
# Libraries
###############################################################################

source "${LIB_DIR}/paths.sh"

source "${LIB_DIR}/logging.sh"

source "${LIB_DIR}/common.sh"

source "${LIB_DIR}/deploy/check-env.sh"

###############################################################################
# Main
###############################################################################

print_header "Infrastructure Environment Check"

check_environment

print_section "Checking .env"

deploy_check_env

print_footer "Environment configuration OK."