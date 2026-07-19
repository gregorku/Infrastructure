#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/init/crowdsec.sh
#
# Description:
#   Initialize CrowdSec directory structure.
#
###############################################################################

init_crowdsec()
{
    print_section "CrowdSec"

    #
    # Directories
    #

    ensure_directory "${CROWDSEC_DIR}"
    ensure_directory "${CROWDSEC_DIR}/config"
    ensure_directory "${CROWDSEC_DIR}/data"
    ensure_directory "${CROWDSEC_DIR}/db"

    #
    # Configuration
    #
    # All CrowdSec configuration is stored in Git and copied during deploy.
    #

    local required_files=(
        "config.yaml"
        "acquis.yaml"
        "profiles.yaml"
    )

    local missing=0

    for file in "${required_files[@]}"; do
        if [[ ! -f "${CROWDSEC_DIR}/config/${file}" ]]; then
            warn "Missing CrowdSec configuration: ${file}"
            missing=1
        fi
    done

    if (( missing )); then
        die "CrowdSec configuration is incomplete. Run deploy or restore the configuration from Git."
    fi

    ok "CrowdSec layout ready."
}