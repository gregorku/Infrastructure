#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/env/writer.sh
#
# Description:
#   Write environment configuration files.
#
# Responsibilities:
#   - Create new .env
#   - Preserve comments
#   - Preserve blank lines
#   - Write variables in .env.example order
#
###############################################################################

###############################################################################
# Start new environment file
###############################################################################

env_writer_begin()
{
    : > "${ENV_TMP_FILE}"
}

###############################################################################
# Write line
#
# Arguments:
#   $1 - Line
#
###############################################################################

env_writer_line()
{
    printf '%s\n' "$1" >> "${ENV_TMP_FILE}"
}

###############################################################################
# Write empty line
###############################################################################

env_writer_blank()
{
    printf '\n' >> "${ENV_TMP_FILE}"
}

###############################################################################
# Write comment
#
# Arguments:
#   $1 - Comment
#
###############################################################################

env_writer_comment()
{
    printf '%s\n' "$1" >> "${ENV_TMP_FILE}"
}

###############################################################################
# Write variable
#
# Arguments:
#   $1 - Variable
#   $2 - Value
#
###############################################################################

env_writer_variable()
{
    printf '%s=%s\n' "$1" "$2" >> "${ENV_TMP_FILE}"
}

###############################################################################
# Finish writing
###############################################################################

env_writer_finish()
{
    mv "${ENV_TMP_FILE}" "${ENV_FILE}"

    ok ".env written."
}

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