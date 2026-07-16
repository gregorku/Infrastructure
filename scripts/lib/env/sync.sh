#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/env/sync.sh
#
# Description:
#   Synchronize .env with .env.example.
#
# Responsibilities:
#   - Preserve comments
#   - Preserve blank lines
#   - Preserve variable order
#   - Apply environment policy
#
###############################################################################

###############################################################################
# Synchronize environment
###############################################################################

env_sync()
{
    declare -A ENV_CURRENT
    declare -A ENV_EXAMPLE

    env_read_current ENV_CURRENT
    env_read_example ENV_EXAMPLE

    local output=""
    local line
    local key
    local example_value
    local current_value
    local value
    local policy

    while IFS= read -r line || [[ -n "${line}" ]]
    do
        #######################################################################
        # Preserve blank lines
        #######################################################################

        if [[ -z "${line}" ]]; then
            output+=$'\n'
            continue
        fi

        #######################################################################
        # Preserve comments
        #######################################################################

        if [[ "${line}" =~ ^[[:space:]]*# ]]; then
            output+="${line}"$'\n'
            continue
        fi

        #######################################################################
        # Ignore invalid lines
        #######################################################################

        [[ "${line}" == *=* ]] || continue

        #######################################################################
        # Parse variable
        #######################################################################

        key="${line%%=*}"
        example_value="${line#*=}"

        policy="$(env_variable_policy "${key}")"

        current_value="${ENV_CURRENT[$key]-}"

        #######################################################################
        # Select value according to policy
        #######################################################################

        case "${policy}" in

            framework)

                value="${example_value}"
                ;;

            user)

                if [[ -n "${current_value}" ]]; then
                    value="${current_value}"
                else
                    value="${example_value}"
                fi
                ;;

            generated)

                if [[ -n "${current_value}" ]]; then
                    value="${current_value}"
                else
                    value="${example_value}"
                fi
                ;;

            *)

                fail "Unknown environment policy: ${policy}"
                ;;

        esac

        output+="${key}=${value}"$'\n'

    done < "${ENV_EXAMPLE_FILE}"

    env_write_file <<< "${output}"

    ok ".env synchronized."
}