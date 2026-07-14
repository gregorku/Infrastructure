#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/init.sh
#
# Description:
#   Initialize Infrastructure directory structure.
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
# Initialization modules
###############################################################################

source "${SCRIPT_DIR}/lib/init/directories.sh"
source "${SCRIPT_DIR}/lib/init/traefik.sh"
source "${SCRIPT_DIR}/lib/init/crowdsec.sh"
source "${SCRIPT_DIR}/lib/init/metabase.sh"
source "${SCRIPT_DIR}/lib/init/watchtower.sh"
source "${SCRIPT_DIR}/lib/init/summary.sh"

###############################################################################
# Main
###############################################################################

print_header "Infrastructure initialization"

#
# Verify environment.
#
check_environment

#
# Create project directories.
#
init_directories

#
# Initialize Traefik.
#
init_traefik

#
# Initialize CrowdSec.
#
init_crowdsec

init_metabase() {

    print_section "Metabase"

    #
    # PostgreSQL
    #

    ensure_directory "${DATA_DIR}/metabase/postgres"

    ensure_directory "${DATA_DIR}/metabase/postgres/data"

    #
    # Metabase
    #

    ensure_directory "${DATA_DIR}/metabase/metabase"

    ensure_directory "${DATA_DIR}/metabase/metabase/data"

    ensure_directory "${DATA_DIR}/metabase/metabase/plugins"

    ensure_directory "${DATA_DIR}/metabase/metabase/logs"

    ensure_directory "${DATA_DIR}/metabase/metabase/backups"

    success "Metabase directories ready."
}

#
# Initialize Watchtower.
#
init_watchtower

#
# Print initialization summary.
#
init_summary