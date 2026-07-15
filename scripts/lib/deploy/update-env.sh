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
    [[ -d "${STACK_DIR}" ]] \
        || die "Stack directory not found."

    [[ -f "${STACK_DIR}/.env.example" ]] \
        || die ".env.example not found."

    if deploy_create_env; then
        return
    fi

    deploy_backup_env

    deploy_sync_env
}

###############################################################################
# Create .env
###############################################################################

deploy_create_env()
{
    if [[ -f "${STACK_DIR}/.env" ]]; then
        ok ".env exists."
        return 1
    fi

    cp \
        "${STACK_DIR}/.env.example" \
        "${STACK_DIR}/.env"

    ok ".env created from .env.example."

    return 0
}

###############################################################################
# Backup .env
###############################################################################

deploy_backup_env()
{
    local backup

    [[ -f "${STACK_DIR}/.env" ]] || return

    backup="${STACK_DIR}/.env.bak-$(date +%Y%m%d-%H%M%S)"

    cp \
        "${STACK_DIR}/.env" \
        "${backup}"

    ok "Backup created: $(basename "${backup}")"
}

###############################################################################
# Synchronize .env
###############################################################################

deploy_sync_env()
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

        if grep -q "^${key}=" "${STACK_DIR}/.env"; then
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
            } >> "${STACK_DIR}/.env"

        fi

        #
        # Add variable
        #

        echo "${line}" >> "${STACK_DIR}/.env"

        ok "Added ${key}"

        ((added++))

    done < "${STACK_DIR}/.env.example"

    if (( added == 0 )); then
        ok ".env already up to date."
    fi
}