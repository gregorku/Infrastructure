#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/env/constants.sh
#
# Description:
#   Environment library constants.
#
###############################################################################

###############################################################################
# Environment files
###############################################################################

readonly ENV_FILE="${STACK_DIR}/.env"

readonly ENV_EXAMPLE_FILE="${STACK_DIR}/.env.example"

###############################################################################
# Temporary files
###############################################################################

readonly ENV_TMP_FILE="${STACK_DIR}/.env.tmp"

readonly ENV_BACKUP_PREFIX="${STACK_DIR}/.env.bak"