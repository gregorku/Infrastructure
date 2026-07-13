###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/tests/traefik.sh
#
# Description:
#   Traefik validation tests.
#
###############################################################################

test_traefik()
{
    print_section "Traefik"

    #
    # Container
    #
    docker_container_running "${TRAEFIK_SERVICE}" \
        || fail "Traefik container is not running."

    ok "Traefik container OK."

    #
    # Dashboard must be protected by BasicAuth.
    #
    docker_exec "${TRAEFIK_SERVICE}" \
        wget \
            --no-check-certificate \
            -qS \
            -O /dev/null \
            https://127.0.0.1:8443/dashboard/ \
            2>&1 \
        | grep -q "401 Unauthorized" \
        || fail "Dashboard authentication is not enabled."

    ok "Dashboard authentication OK."
}