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
        return
    fi

    deploy_backup_env

    deploy_update_env_variables
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
# Synchronize .env
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

        ((added++))

    done < "${ENV_EXAMPLE_FILE}"

    if (( added == 0 )); then
        ok ".env already up to date."
    fi
}