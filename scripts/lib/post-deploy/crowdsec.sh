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

    local key_dir
    local key_file

    key_dir="${DATA_DIR}/traefik/crowdsec"
    key_file="${CROWDSEC_BOUNCER_KEY_FILE}"

    ensure_directory "${key_dir}"

    ###########################################################################
    # Existing key
    ###########################################################################

    if [[ -f "${key_file}" ]]; then

        ok "Bouncer key already exists."

        return

    fi

        ###############################################################################
        # Existing key
        ###############################################################################

        if [[ -f "${key_file}" ]]; then

        ###########################################################################
        # Verify bouncer
        ###########################################################################

        if docker exec "${CROWDSEC_SERVICE}" \
            cscli bouncers list \
            | awk '{print $1}' \
            | grep -qx "${CROWDSEC_BOUNCER_NAME}"
        then

            ok "Bouncer key already exists."

            return

        fi

        fail "Bouncer key exists but CrowdSec bouncer '${CROWDSEC_BOUNCER_NAME}' is missing."

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
        printf '%s\n' "${output}" \
        | awk '
            NF {
                count++
                if (count == 2) {
                    gsub(/[[:space:]]/, "")
                    print
                    exit
                }
            }
        '
    )"

    [[ -n "${api_key}" ]] \
        || fail "Unable to extract CrowdSec API key."

    printf '%s\n' "${api_key}" > "${key_file}"

    chmod 600 "${key_file}"

    ok "CrowdSec bouncer created."

    ok "Bouncer key saved."

    ok "Permissions 600: ${key_file}"
}