#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/bootstrap.sh
#
# Description:
#   Bootstrap loader for Infrastructure scripts.
#
###############################################################################

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

###############################################################################
# Core configuration
###############################################################################

source "${SCRIPT_DIR}/config.sh"

###############################################################################
# Libraries
###############################################################################

source "${SCRIPT_DIR}/lib/logging.sh"
source "${SCRIPT_DIR}/lib/common.sh"
source "${SCRIPT_DIR}/lib/filesystem.sh"
source "${SCRIPT_DIR}/lib/docker.sh"
source "${SCRIPT_DIR}/lib/git.sh"
source "${SCRIPT_DIR}/lib/deploy.sh"