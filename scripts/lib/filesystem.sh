#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/filesystem.sh
#
###############################################################################

ensure_directory() {

    local dir="$1"

    if [[ ! -d "${dir}" ]]; then
        mkdir -p "${dir}"
        log_info "Created directory: ${dir}"
    fi
}

ensure_file() {

    local file="$1"

    if [[ ! -f "${file}" ]]; then
        touch "${file}"
        log_info "Created file: ${file}"
    fi
}

copy_if_missing() {

    local src="$1"
    local dst="$2"

    if [[ ! -f "${dst}" ]]; then
        cp "${src}" "${dst}"
        log_info "Created ${dst}"
    fi
}

###############################################################################
# Permissions
###############################################################################

ensure_permissions() {

    local mode="$1"
    local path="$2"

    chmod "${mode}" "${path}"
}

###############################################################################
# Traefik
###############################################################################

create_traefik_layout() {

    ensure_directory "${DATA_DIR}/traefik"
    ensure_directory "${DATA_DIR}/traefik/acme"
    ensure_directory "${DATA_DIR}/traefik/logs"

    ensure_file "${DATA_DIR}/traefik/acme/acme.json"

    ensure_permissions 600 \
        "${DATA_DIR}/traefik/acme/acme.json"

    log_success "Traefik layout ready."
}

###############################################################################
# CrowdSec
###############################################################################

create_crowdsec_layout() {

    ensure_directory "${DATA_DIR}/crowdsec"

    ensure_directory "${DATA_DIR}/crowdsec/config"

    ensure_directory "${DATA_DIR}/crowdsec/data"

    ensure_directory "${DATA_DIR}/crowdsec/db"

    log_success "CrowdSec layout ready."
}

###############################################################################
# Watchtower
###############################################################################

create_watchtower_layout() {

    ensure_directory "${DATA_DIR}/watchtower"

    log_success "Watchtower layout ready."
}