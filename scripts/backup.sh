#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/bootstrap.sh
#
# Description:
#   Bootstrap running services after first deployment.
#
###############################################################################

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/config.sh"

source "${SCRIPT_DIR}/lib/common.sh"
source "${SCRIPT_DIR}/lib/logging.sh"

source "${SCRIPT_DIR}/lib/checks/load.sh"

source "${SCRIPT_DIR}/lib/bootstrap/crowdsec.sh"
source "${SCRIPT_DIR}/lib/bootstrap/summary.sh"

print_header "Infrastructure bootstrap"

check_environment

bootstrap_crowdsec

bootstrap_summary