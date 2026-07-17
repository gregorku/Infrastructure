#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy/update-env.sh
#
# Description:
#   Updates the stack .env file.
#
#   Features:
#
#     - Creates .env from .env.example if missing.
#     - Creates a timestamped backup.
#     - Adds missing variables from .env.example.
#     - Never overwrites existing values.
#     - Never removes obsolete variables.
#
###############################################################################

###############################################################################
# Update .env
###############################################################################

deploy_update_env()
{
    [[ -f "${ENV_EXAMPLE_FILE}" ]] \
        || die ".env.example not found."

    if deploy_create_env; then

        ok ".env initialized."

        return

    fi

    deploy_backup_env

    deploy_update_env_variables
    deploy_check_user_variables
}

###############################################################################
# Create .env
###############################################################################

deploy_create_env()
{
    if [[ -f "${ENV_FILE}" ]]; then
        ok ".env exists."
        return 1
    fi

    cp \
        "${ENV_EXAMPLE_FILE}" \
        "${ENV_FILE}"

    ok ".env created from .env.example."

    return 0
}

###############################################################################
# Backup .env
###############################################################################

deploy_backup_env()
{
    local backup

    [[ -f "${ENV_FILE}" ]] || return

    backup="${ENV_FILE}.bak-$(date +%Y%m%d-%H%M%S)"

    cp \
        "${ENV_FILE}" \
        "${backup}"

    ok "Backup created: $(basename "${backup}")"
}

###############################################################################
# Update .env variables
###############################################################################

deploy_update_env_variables()
{
    local added=0
    local line
    local key

    while IFS= read -r line || [[ -n "${line}" ]]; do

        #
        # Skip comments
        #

        [[ "${line}" =~ ^[[:space:]]*# ]] && continue

        #
        # Skip empty lines
        #

        [[ -z "${line}" ]] && continue

        #
        # Skip invalid lines
        #

        [[ "${line}" != *=* ]] && continue

        key="${line%%=*}"

        #
        # Variable already exists
        #

        if grep -q "^${key}=" "${ENV_FILE}"; then
            continue
        fi

        #
        # Create automatic section
        #

        if (( added == 0 )); then

            {
                echo
                echo "###############################################################################"
                echo "# Added automatically"
                echo "###############################################################################"
                echo
            } >> "${ENV_FILE}"

        fi

        #
        # Add variable
        #

        echo "${line}" >> "${ENV_FILE}"

        ok "Added ${key}"

        added=$((added + 1))

    done < "${ENV_EXAMPLE_FILE}"

    if (( added == 0 )); then
        ok ".env already up to date."
    fi
}

deploy_check_user_variables()
{
    local variable
    local env_value
    local example_value
    local differences=0

    info "Checking user variables..."

    for variable in "${!ENV_POLICY[@]}"; do

        #
        # Only user variables
        #

        [[ "${ENV_POLICY[$variable]}" != "user" ]] && continue

        #
        # Read values
        #

        env_value=$(grep -E "^${variable}=" "${ENV_FILE}" \
            | head -n1 | cut -d= -f2-)

        example_value=$(grep -E "^${variable}=" "${ENV_EXAMPLE_FILE}" \
            | head -n1 | cut -d= -f2-)

        #
        # Missing variable
        #

        [[ -z "${env_value}" ]] && continue
        [[ -z "${example_value}" ]] && continue

        #
        # Same value
        #

        [[ "${env_value}" == "${example_value}" ]] && continue

        info "${variable} differs"

        printf "       .env         : %s\n" "${env_value}"
        printf "       .env.example : %s\n" "${example_value}"
        printf "       Keeping user value.\n\n"

        differences=$((differences + 1))

    done

    if (( differences == 1 )); then
        info "1 user variable differs from .env.example."
    else
        info "${differences} user variables differ from .env.example."
    fi
}