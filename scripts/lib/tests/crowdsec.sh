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

    #
    # Traefik collection
    #

    if docker exec crowdsec cscli collections list \
        | grep -q "crowdsecurity/traefik.*enabled"
    then
        ok "Traefik collection OK."
    else
        fail "Traefik collection missing."
    fi

    #
    # Parser
    #

    if docker exec crowdsec cscli parsers list \
        | grep -q "crowdsecurity/traefik-logs.*enabled"
    then
        ok "Traefik parser OK."
    else
        fail "Traefik parser missing."
    fi

    #
    # Bouncer
    #

    if docker exec crowdsec cscli bouncers list \
        | grep -q traefik
    then
        ok "Traefik bouncer OK."
    else
        fail "Traefik bouncer missing."
    fi

    #
    # Acquisition
    #

    #
    # Traefik traffic parsing
    #

    if docker exec crowdsec cscli metrics \
        | grep -Eq "crowdsecurity/(traefik-logs|http-logs)"
    then
      ok "CrowdSec traffic parsing OK."
    else
      fail "CrowdSec is not parsing Traefik logs."
    fi
}