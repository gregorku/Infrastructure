#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/init/stack.sh
#
# Description:
#   Prepare Docker Compose stacks.
#
###############################################################################

###############################################################################
# Prepare Dockge
###############################################################################

init_prepare_dockge()
{
    log_info "Preparing Dockge..."

    mkdir -p "${DOCKGE_DIR}"

    for item in "${DOCKGE_ITEMS[@]}"; do
        cp -a \
            "${GIT_DIR}/dockge/${item}" \
            "${DOCKGE_DIR}/"
    done

    log_success "Dockge prepared."
}

###############################################################################
# Prepare Infrastructure stack
###############################################################################

init_prepare_infrastructure_stack()
{
    log_info "Preparing Infrastructure stack..."

    mkdir -p "${STACK_DIR}"

    for item in "${STACK_ITEMS[@]}"; do
        cp -a \
            "${GIT_DIR}/${item}" \
            "${STACK_DIR}/"
    done

    log_success "Infrastructure stack prepared."
}

###############################################################################
# Prepare project stacks
###############################################################################

init_prepare_stack()
{
    print_section "Project stack"

    init_prepare_dockge
    init_prepare_infrastructure_stack
}