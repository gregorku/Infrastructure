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
#
###############################################################################

###############################################################################
# Update .env
###############################################################################

deploy_update_env()
{
    print_section "Updating .env"

    deploy_create_env

    deploy_backup_env

    deploy_add_missing_env_variables
}

###############################################################################
# Create .env
###############################################################################

deploy_create_env()
{
    if [[ -f "${STACK_DIR}/.env" ]]; then
        ok ".env exists."
        return
    fi

    cp \
        "${STACK_DIR}/.env.example" \
        "${STACK_DIR}/.env"

    ok ".env created from .env.example."
}

###############################################################################
# Backup .env
###############################################################################

deploy_backup_env()
{
    local backup

    backup="${STACK_DIR}/.env.bak-$(date +%Y%m%d-%H%M%S)"

    cp \
        "${STACK_DIR}/.env" \
        "${backup}"

    ok "Backup created: $(basename "${backup}")"
}

###############################################################################
# Add missing variables
###############################################################################

deploy_add_missing_env_variables()
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

        [[ -z "${line// }" ]] && continue

        #
        # Skip invalid lines
        #

        [[ "${line}" != *=* ]] && continue

        key="${line%%=*}"

        #
        # Variable already exists
        #

        if grep -qE "^${key}[[:space:]]*=" "${STACK_DIR}/.env"; then
            continue
        fi

        #
        # Append missing variable
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

        echo "${line}" >> "${STACK_DIR}/.env"

        ok "Added ${key}"

        ((added++))

    done < "${STACK_DIR}/.env.example"

    if (( added == 0 )); then
        ok ".env already up to date."
    fi
}