#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/post-deploy/crowdsec.sh
#
# Description:
#   Configure CrowdSec after deployment.
#
###############################################################################

post_deploy_crowdsec()
{
    print_section "CrowdSec"

    ###########################################################################
    # Verify container
    ###########################################################################

    docker_container_running "${CROWDSEC_SERVICE}"

    ok "CrowdSec container OK."

    ###########################################################################
    # Paths
    ###########################################################################

    local key_dir="${DATA_DIR}/traefik/crowdsec"
    local key_file="${key_dir}/BOUNCER_KEY_traefik"

    ensure_directory "${key_dir}"

    ###########################################################################
    # Existing key
    ###########################################################################

    if [[ -f "${key_file}" ]]; then

        ok "Bouncer key already exists."

        return

    fi

    ###########################################################################
    # Existing bouncer
    ###########################################################################

    if docker exec "${CROWDSEC_SERVICE}" \
        cscli bouncers list \
        | awk '{print $1}' \
        | grep -qx "traefik"
    then

        fail "Traefik bouncer already exists but key file is missing."

    fi

    ###########################################################################
    # Create bouncer
    ###########################################################################

    info "Creating Traefik bouncer..."

    local output
    local api_key

    output="$(
        docker exec "${CROWDSEC_SERVICE}" \
            cscli bouncers add traefik
    )"

    api_key="$(
        printf '%s\n' "${output}" \
        | grep -E '^[[:space:]]*[A-Za-z0-9]{20,}[[:space:]]*$' \
        | tr -d '[:space:]'
    )"

    [[ -n "${api_key}" ]] \
        || fail "Unable to extract CrowdSec API key."

    printf '%s\n' "${api_key}" > "${key_file}"

    chmod 600 "${key_file}"

    ok "Traefik bouncer created."

    ok "Bouncer key saved."

    ok "Permissions 600: ${key_file}"
}