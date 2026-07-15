#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/init/directories.sh
#
# Description:
#   Initialize Infrastructure project directories.
#
###############################################################################

init_directories()
{
    print_section "Project directories"

    ensure_directory "${STACK_DIR}"
    ensure_directory "${DATA_DIR}"

    info "Stack directory : ${STACK_DIR}"
    info "Data directory  : ${DATA_DIR}"
    
    ok "Project directories ready."
}