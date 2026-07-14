#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/bootstrap/summary.sh
#
# Description:
#   Bootstrap summary.
#
###############################################################################

bootstrap_summary()
{
    print_section "Bootstrap completed"

    ok "Infrastructure bootstrap finished."

    echo

    info "Verify CrowdSec:"

    echo "  docker exec crowdsec cscli metrics"

    echo "  docker exec crowdsec cscli alerts list"

    echo "  docker exec crowdsec cscli decisions list"

    echo
}