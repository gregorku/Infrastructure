#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/tests/post-deploy.sh
#
# Description:
#   Verify post deployment configuration.
#
###############################################################################

test_post_deploy()
{
    print_section "Post Deployment"

    ###########################################################################
    # CrowdSec bouncer key
    ###########################################################################

    file_exists "${CROWDSEC_BOUNCER_KEY_FILE}"

    permissions_are 600 "${CROWDSEC_BOUNCER_KEY_FILE}"

    ###########################################################################
    # CrowdSec bouncer
    ###########################################################################

    if docker exec "${CROWDSEC_SERVICE}" \
        cscli bouncers list \
        | awk '{print $1}' \
        | grep -qx "${CROWDSEC_BOUNCER_NAME}"
    then

        ok "CrowdSec bouncer OK."

    else

        fail "CrowdSec bouncer missing."

    fi
}