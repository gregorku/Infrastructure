#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/init/crowdsec.sh
#
# Description:
#   Initialize CrowdSec directory structure.
#
###############################################################################

init_crowdsec()
{
    print_section "CrowdSec"

    #
    # Directories
    #

    ensure_directory "${CROWDSEC_DIR}"

    ensure_directory "${CROWDSEC_DIR}/config"

    ensure_directory "${CROWDSEC_DIR}/data"

    ensure_directory "${CROWDSEC_DIR}/db"

    #
    # Default configuration
    #

    if [[ ! -f "${CROWDSEC_DIR}/config/acquis.yaml" ]]; then

        cat > "${CROWDSEC_DIR}/config/acquis.yaml" <<'EOF'
###############################################################################
#
# CrowdSec acquisition
#
###############################################################################

filenames:

  - /logs/access.log

labels:

  type: traefik
EOF

        ok "Created CrowdSec acquis.yaml"

    fi

    if [[ ! -f "${CROWDSEC_DIR}/config/profiles.yaml" ]]; then

        cat > "${CROWDSEC_DIR}/config/profiles.yaml" <<'EOF'
###############################################################################
#
# CrowdSec profiles
#
###############################################################################

name: default_ip_remediation

filters:
  - Alert.Remediation == true

decisions:
  - type: ban
    duration: 4h

on_success: break
EOF

        ok "Created CrowdSec profiles.yaml"

    fi

    ok "CrowdSec layout ready."
}