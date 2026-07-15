###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy/check-env.sh
#
# Description:
#   Verifies the stack .env file.
#
#   Features:
#
#     - Verifies that .env.example exists.
#     - Verifies that .env exists.
#     - Verifies that all variables from .env.example
#       exist in .env.
#
###############################################################################

###############################################################################
# Check .env
###############################################################################

deploy_check_env()
{
    [[ -f "${ENV_EXAMPLE_FILE}" ]] \
        || die ".env.example not found."

    [[ -f "${ENV_FILE}" ]] \
        || die ".env not found. Run ./scripts/update-env.sh"

    deploy_check_env_variables
}

###############################################################################
# Check variables
###############################################################################

deploy_check_env_variables()
{
    local missing=0
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

        if grep -q "^${key}=" "${ENV_FILE}"; then
            continue
        fi

        fail "Missing variable: ${key}"

        missing=1

    done < "${ENV_EXAMPLE_FILE}"

    (( missing == 0 )) || return 1

    ok "Environment configuration OK."
}