#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/init/traefik.sh
#
# Description:
#   Initialize Traefik directory structure.
#
###############################################################################

init_traefik()
{
    print_section "Traefik"

    ensure_directory "${TRAEFIK_DIR}"

    ensure_directory "${TRAEFIK_DIR}/acme"

    ensure_directory "${TRAEFIK_DIR}/logs"

    ensure_file_mode \
        "${TRAEFIK_DIR}/acme/acme.json" \
        600
    
    ensure_directory "${TRAEFIK_DIR}/crowdsec"

    ok "Traefik layout ready."
}