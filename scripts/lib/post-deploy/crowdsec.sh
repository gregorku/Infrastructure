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
# Responsibilities:
#   - Verify CrowdSec container
#   - Create Traefik bouncer if missing
#   - Save API key
#   - Set correct permissions
#
###############################################################################

post_deploy_crowdsec()
{
    print_section "CrowdSec"

    ###########################################################################
    # Verify CrowdSec
    ###########################################################################

    docker_container_running "${CROWDSEC_SERVICE}"

    ok "CrowdSec container OK."

    ###########################################################################
    # Prepare directory
    ###########################################################################

    ensure_directory "${CROWDSEC_BOUNCER_DIR}"

    ###########################################################################
    # Existing key
    ###########################################################################

    if [[ -f "${CROWDSEC_BOUNCER_KEY_FILE}" ]]; then

        ok "CrowdSec bouncer key already exists."

        return

    fi

    ###########################################################################
    # Existing bouncer
    ###########################################################################

    if docker exec "${CROWDSEC_SERVICE}" \
        cscli bouncers list \
        | awk '{print $1}' \
        | grep -qx "${CROWDSEC_BOUNCER_NAME}"
    then

        fail "CrowdSec bouncer exists but API key file is missing."

    fi

    ###########################################################################
    # Create bouncer
    ###########################################################################

    info "Creating CrowdSec bouncer..."

    local output
    local api_key

    output="$(
        docker exec "${CROWDSEC_SERVICE}" \
            cscli bouncers add "${CROWDSEC_BOUNCER_NAME}"
    )"

    api_key="$(
        printf '%s\n' "${output}" |
        grep -E '^[[:space:]]*[A-Za-z0-9]{20,}[[:space:]]*$' |
        tr -d '[:space:]'
    )"

    [[ -n "${api_key}" ]] \
        || fail "Unable to extract CrowdSec API key."

    ###########################################################################
    # Save key
    ###########################################################################

    printf '%s\n' "${api_key}" > "${CROWDSEC_BOUNCER_KEY_FILE}"

    chmod 600 "${CROWDSEC_BOUNCER_KEY_FILE}"

    ok "CrowdSec bouncer created."

    ok "API key saved."

    ok "Permissions set to 600."

    info "Key file:"
    info "  ${CROWDSEC_BOUNCER_KEY_FILE}"
}