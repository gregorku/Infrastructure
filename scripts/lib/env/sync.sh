#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/env/update.sh
#
# Description:
#   Synchronize .env with .env.example.
#
# Responsibilities:
#   - Preserve file layout
#   - Preserve comments
#   - Preserve blank lines
#   - Synchronize variables according to policy
#
###############################################################################

###############################################################################
# Update environment
###############################################################################

env_sync()
{
    declare -A ENV_CURRENT
    declare -A ENV_EXAMPLE

    env_read_current ENV_CURRENT
    env_read_example ENV_EXAMPLE

    env_backup

    env_writer_begin

    local line
    local key
    local example_value
    local current_value
    local policy
    local value

    while IFS= read -r line || [[ -n "${line}" ]]
    do
        #######################################################################
        # Empty line
        #######################################################################

        if [[ -z "${line}" ]]; then
            env_writer_blank
            continue
        fi

        #######################################################################
        # Comment
        #######################################################################

        if [[ "${line}" =~ ^[[:space:]]*# ]]; then
            env_writer_comment "${line}"
            continue
        fi

        #######################################################################
        # Invalid line
        #######################################################################

        [[ "${line}" == *=* ]] || continue

        key="${line%%=*}"
        example_value="${line#*=}"

        policy="$(env_variable_policy "${key}")"

        current_value="${ENV_CURRENT[$key]-}"

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

        env_writer_variable "${key}" "${value}"

    done < "${ENV_EXAMPLE_FILE}"

    env_writer_finish

    ok ".env synchronized."
}