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

    require_container_running "${CROWDSEC_SERVICE}"

    ok "CrowdSec container OK."

    ###########################################################################
    # Ensure bouncer directory
    ###########################################################################

    ensure_directory "${CROWDSEC_BOUNCER_DIR}"

    local key_file
    local output
    local api_key

    key_file="${CROWDSEC_BOUNCER_KEY_FILE}"

    ###########################################################################
    # Existing key
    ###########################################################################

    if [[ -f "${key_file}" ]]; then

        #######################################################################
        # Verify bouncer
        #######################################################################

        if docker_exec "${CROWDSEC_SERVICE}" \
            cscli bouncers list \
            | awk '{print $1}' \
            | grep -qx "${CROWDSEC_BOUNCER_NAME}"
        then

            ok "Bouncer key already exists."

            ok "CrowdSec bouncer already exists."

            return

        fi

        fail "Bouncer key exists but CrowdSec bouncer '${CROWDSEC_BOUNCER_NAME}' is missing."

    fi

    ###########################################################################
    # Create bouncer
    ###########################################################################

    info "Creating CrowdSec bouncer..."

    if ! output="$(
        docker_exec "${CROWDSEC_SERVICE}" \
            cscli bouncers add "${CROWDSEC_BOUNCER_NAME}"
    )"; then

        fail "Unable to create CrowdSec bouncer."

    fi

    ###########################################################################
    # Extract API key
    ###########################################################################

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

    ###########################################################################
    # Save key
    ###########################################################################

    printf '%s\n' "${api_key}" > "${key_file}"

    chmod 600 "${key_file}"

    ok "CrowdSec bouncer created."

    ok "Bouncer key saved."

    ok "Permissions 600: ${key_file}"
}