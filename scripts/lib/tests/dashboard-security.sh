###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/tests/dashboard.sh
#
# Description:
#   Dashboard authentication validation.
#
###############################################################################

test_dashboard()
{
    print_section "Dashboard authentication"

    require_file "${TRAEFIK_USERS_DIR}/dashboard.htpasswd"

    ok "Dashboard credentials OK."
}