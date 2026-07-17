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
    local differences=0

    info "Checking user variables..."

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

        #######################################################################
        # Report user variable differences
        #######################################################################

        if [[ "${policy}" == "user" ]] \
            && [[ -n "${current_value}" ]] \
            && [[ "${current_value}" != "${example_value}" ]]; then

            info "${key} differs"

            printf "       .env         : %s\n" "${current_value}"
            printf "       .env.example : %s\n" "${example_value}"
            printf "       Keeping user value.\n\n"

            differences=$((differences + 1))

        fi

        output+="${key}=${value}"$'\n'

    done < "${ENV_EXAMPLE_FILE}"

        if (( differences == 0 )); then
        ok "No user variable differences found."
    elif (( differences == 1 )); then
        info "1 user variable differs from .env.example."
    else
        info "${differences} user variables differ from .env.example."
    fi

    env_write_file <<< "${output}"
}