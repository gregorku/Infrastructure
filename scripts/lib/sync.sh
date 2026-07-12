#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy.sh
#
###############################################################################

sync_item() {

    local item="$1"

    [[ -e "${GIT_DIR}/${item}" ]] \
        || die "Missing: ${GIT_DIR}/${item}"

    rsync -a --delete \
        "${GIT_DIR}/${item}" \
        "${STACK_DIR}/"

    log_success "Synced ${item}"
}

copy_env_if_missing() {

    if [[ ! -f "${STACK_DIR}/.env" ]]; then

        cp "${STACK_DIR}/.env.example" \
           "${STACK_DIR}/.env"

        log_success ".env created from .env.example"

    else

        log_info ".env already exists"

    fi
}

validate_compose() {

    docker_compose_config
}