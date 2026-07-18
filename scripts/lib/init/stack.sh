#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/init/stack.sh
#
# Description:
#   Prepare Infrastructure Docker Compose stack.
#
# Responsibilities:
#   - Create stack directory structure
#   - Copy compose.yml
#   - Copy .env.example
#   - Copy compose/ directory
#
# Notes:
#   This module prepares everything required before running update-env.sh
#   and deploy.sh.
#
###############################################################################

###############################################################################
# Initialize project stack
###############################################################################

init_stack()
{
    log_step "Project stack"

    #
    # Stack directory
    #
    ensure_directory "${STACK_DIR}"

    #
    # Compose directory
    #
    ensure_directory "${STACK_DIR}/compose"

    #
    # Copy compose.yml
    #
    copy_stack_file \
        "compose.yml"

    #
    # Copy .env.example
    #
    copy_stack_file \
        ".env.example"

    #
    # Copy compose directory
    #
    copy_stack_directory \
        "compose"

    log_success "Project stack ready."
}

###############################################################################
# Copy one stack file
###############################################################################

copy_stack_file()
{
    local file="$1"

    local source="${GIT_DIR}/${file}"
    local destination="${STACK_DIR}/${file}"

    if [[ ! -f "${source}" ]]; then
        log_error "Missing project file: ${source}"
        return 1
    fi

    install -m 644 "${source}" "${destination}"

    log_success "File ready: ${destination}"
}

###############################################################################
# Copy stack directory
###############################################################################

copy_stack_directory()
{
    local directory="$1"

    local source="${GIT_DIR}/${directory}"
    local destination="${STACK_DIR}/${directory}"

    if [[ ! -d "${source}" ]]; then
        log_error "Missing project directory: ${source}"
        return 1
    fi

    mkdir -p "${destination}"

    cp -a "${source}/." "${destination}/"

    log_success "Directory ready: ${destination}"
}