#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/tests/crowdsec.sh
#
# Description:
#   CrowdSec tests.
#
###############################################################################

test_crowdsec()
{
    print_section "CrowdSec"

    docker_container_running "${CROWDSEC_SERVICE}"

    ok "CrowdSec container OK."
}