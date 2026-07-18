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
#   - Install required collections
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
    # Install required collections
    ###########################################################################

    info "Installing CrowdSec collections..."

    local collections=(
        crowdsecurity/linux
        crowdsecurity/sshd
        crowdsecurity/traefik
    )

    local collection

    for collection in "${collections[@]}"; do

        info "  ${collection}"

        docker exec "${CROWDSEC_SERVICE}" \
            cscli collections install "${collection}" >/dev/null

    done

    ok "CrowdSec collections OK."

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
        | awk 'NR > 3 { print $1 }' \
        | grep -Fxq "${CROWDSEC_BOUNCER_NAME}"
    then

        warn "CrowdSec bouncer '${CROWDSEC_BOUNCER_NAME}' already exists."
        warn "API key file is missing."
        warn "Delete and recreate the bouncer or restore the key file."

        return

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
    )" || fail "Unable to create CrowdSec bouncer."

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