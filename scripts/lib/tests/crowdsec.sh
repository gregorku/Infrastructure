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
    # Traefik parser
    #

    if docker exec crowdsec cscli parsers list \
        | grep -q "crowdsecurity/traefik-logs.*enabled"
    then
        ok "Traefik parser OK."
    else
        fail "Traefik parser missing."
    fi

    #
    # Traefik bouncer
    #

    if docker exec crowdsec cscli bouncers list \
        | grep -q "^traefik[[:space:]]"
    then
        ok "Traefik bouncer OK."
    else
        fail "Traefik bouncer missing."
    fi

    #
    # Access log acquisition
    #

    if docker exec crowdsec cscli metrics \
        | grep -q "file:/logs/access.log"
    then
        ok "Access log acquisition OK."
    else
        fail "Access log acquisition missing."
    fi

    #
    # Verify parser on a real Traefik log
    #

    if docker exec crowdsec \
        cscli explain \
        --file /logs/access.log \
        --type traefik \
        --only-successful-parsers 2>/dev/null \
        | grep -q "crowdsecurity/traefik-logs"
    then
        ok "Traefik log parsing OK."
    else
        fail "Traefik log parsing failed."
    fi
}