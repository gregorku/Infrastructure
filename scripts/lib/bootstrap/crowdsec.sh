#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/bootstrap/crowdsec.sh
#
# Description:
#   Bootstrap CrowdSec after containers are running.
#
###############################################################################

###############################################################################
# CrowdSec collections
###############################################################################

CROWDSEC_COLLECTIONS=(
    "crowdsecurity/linux"
    "crowdsecurity/sshd"
    "crowdsecurity/traefik"
    "crowdsecurity/whitelist-good-actors"
)

###############################################################################
# Bootstrap CrowdSec
###############################################################################

bootstrap_crowdsec()
{
    print_section "CrowdSec"

    require_container_running "crowdsec"

    local collection

    for collection in "${CROWDSEC_COLLECTIONS[@]}"; do

        if docker exec crowdsec \
            cscli collections inspect "${collection}" >/dev/null 2>&1
        then

            ok "Collection installed: ${collection}"

        else

            info "Installing ${collection}"

            docker exec crowdsec \
                cscli collections install "${collection}"

            ok "Installed: ${collection}"
        fi
    done

    info "Restarting CrowdSec..."

    docker restart crowdsec >/dev/null

    ok "CrowdSec restarted."

    sleep 5

    ok "CrowdSec bootstrap completed."
}