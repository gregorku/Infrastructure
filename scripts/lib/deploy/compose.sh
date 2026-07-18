#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy/compose.sh
#
# Description:
#   Validate and deploy Docker Compose stack.
#
###############################################################################

###############################################################################
# Validate Docker Compose configuration
###############################################################################

deploy_validate_compose()
{
    print_section "Compose validation"

    check_compose_configuration
}

###############################################################################
# Deploy Docker Compose stack
###############################################################################

deploy_compose()
{
    print_section "Infrastructure"

    log_info "Pulling container images..."

    docker compose \
        --project-name "${STACK_NAME}" \
        --file "${COMPOSE_FILE}" \
        --env-file "${ENV_FILE}" \
        pull

    log_info "Starting Infrastructure stack..."

    docker compose \
        --project-name "${STACK_NAME}" \
        --file "${COMPOSE_FILE}" \
        --env-file "${ENV_FILE}" \
        up -d

    log_success "Infrastructure deployed."
}