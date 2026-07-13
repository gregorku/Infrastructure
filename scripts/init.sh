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

###############################################################################
# Main
###############################################################################

print_section "Infrastructure initialization"

check_environment

###############################################################################
# Project directories
###############################################################################

print_section "Project directories"

ensure_directory "${STACK_DIR}"
ensure_directory "${DATA_DIR}"

info "Stack directory : ${STACK_DIR}"
info "Data directory  : ${DATA_DIR}"

###############################################################################
# Traefik
###############################################################################

print_section "Traefik"

ensure_directory "${TRAEFIK_DIR}"
ensure_directory "${TRAEFIK_DIR}/acme"
ensure_directory "${TRAEFIK_DIR}/logs"

ensure_file_mode "${TRAEFIK_DIR}/acme/acme.json" 600

ok "Traefik layout ready."

###############################################################################
# CrowdSec
###############################################################################

print_section "CrowdSec"

ensure_directory "${CROWDSEC_DIR}"
ensure_directory "${CROWDSEC_DIR}/config"
ensure_directory "${CROWDSEC_DIR}/data"
ensure_directory "${CROWDSEC_DIR}/db"

ok "CrowdSec layout ready."

###############################################################################
# Watchtower
###############################################################################

print_section "Watchtower"

ensure_directory "${WATCHTOWER_DIR}"

ok "Watchtower layout ready."

###############################################################################
# Finished
###############################################################################

print_section "Finished"

ok "Initialization completed."