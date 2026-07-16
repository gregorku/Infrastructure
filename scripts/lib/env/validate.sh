#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/env/validate.sh
#
# Description:
#   Validate environment configuration.
#
###############################################################################

###############################################################################
# Validate environment file
###############################################################################

env_validate()
{
    declare -A ENV

    env_read_current ENV

    local variable

    for variable in "${!ENV_POLICY[@]}"
    do
        [[ -v ENV["$variable"] ]] \
            || fail "Missing variable: ${variable}"
    done

    ok "Environment configuration OK."
}