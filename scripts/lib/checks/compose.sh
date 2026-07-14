#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/checks/compose.sh
#
# Description:
#   Docker Compose helper functions.
#
###############################################################################

###############################################################################
# Validate Docker Compose configuration.
###############################################################################

validate_compose()
{
    docker compose \
        --env-file "${STACK_DIR}/.env" \
        -f "${STACK_DIR}/compose.yml" \
        config >/dev/null \
        || fail "Compose configuration is invalid."

    ok "Compose configuration is valid."
}