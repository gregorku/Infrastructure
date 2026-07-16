#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/env/writer.sh
#
# Description:
#   Environment file writer.
#
# Responsibilities:
#   - Backup current .env
#   - Create temporary .env
#   - Write synchronized .env
#   - Replace original .env
#
###############################################################################

###############################################################################
# Backup environment
###############################################################################

env_backup()
{
    [[ -f "${ENV_FILE}" ]] || return

    local backup

    backup="${ENV_BACKUP_PREFIX}-$(date +%Y%m%d-%H%M%S)"

    cp "${ENV_FILE}" "${backup}"

    ok "Backup created: $(basename "${backup}")"
}

###############################################################################
# Write synchronized environment
#
# Arguments:
#   stdin - Complete .env content
#
###############################################################################

env_write_file()
{
    cat > "${ENV_TMP_FILE}"

    mv "${ENV_TMP_FILE}" "${ENV_FILE}"

    ok ".env synchronized."
}