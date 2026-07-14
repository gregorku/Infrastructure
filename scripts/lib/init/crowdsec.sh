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

    ensure_directory "${CROWDSEC_DIR}"

    ensure_directory "${CROWDSEC_DIR}/config"

    ensure_directory "${CROWDSEC_DIR}/data"

    ensure_directory "${CROWDSEC_DIR}/db"

    ok "CrowdSec layout ready."
}