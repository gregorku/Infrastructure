#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/update-env.sh
#
# Description:
#   Updates the stack .env file from .env.example.
#
#   The script:
#
#     • Creates .env if it does not exist.
#
#     • Creates a timestamped backup of the current .env.
#
#     • Adds all missing variables from .env.example.
#
#     • Never overwrites existing values.
#
#     • Never removes obsolete variables.
#
#   Existing configuration is always preserved.
#
# Usage:
#
#   ./scripts/update-env.sh
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

source "${LIB_DIR}/logging.sh"
source "${LIB_DIR}/common.sh"

source "${LIB_DIR}/deploy/update-env.sh"

###############################################################################
# Main
###############################################################################

print_header "Updating .env"

check_environment

deploy_update_env

print_footer ".env updated."