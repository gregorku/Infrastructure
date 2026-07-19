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

    require_directory "${STACK_DIR}/configs/traefik/users"

    require_file \
        "${STACK_DIR}/configs/traefik/users/dashboard.htpasswd"

    ok "Dashboard credentials OK."
}