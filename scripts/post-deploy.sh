#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/post-deploy.sh
#
# Description:
#   Configure services after the stack is running.
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
# Modules
###############################################################################

source "${SCRIPT_DIR}/lib/post-deploy/crowdsec.sh"
source "${SCRIPT_DIR}/lib/post-deploy/metabase.sh"
source "${SCRIPT_DIR}/lib/post-deploy/summary.sh"

###############################################################################
# Main
###############################################################################

print_header "Infrastructure post deployment"

check_environment
check_docker_environment

post_deploy_crowdsec

#
# Metabase
#
post_deploy_metabase

post_deploy_summary