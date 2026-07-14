#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/tests/dashboard-security.sh
#
# Description:
#   Dashboard security validation.
#
###############################################################################

test_dashboard_security()
{
    print_section "Dashboard authentication"

    require_file "${TRAEFIK_USERS_DIR}/dashboard.htpasswd"

    ok "Dashboard credentials OK."
}