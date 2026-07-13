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
        -S \
        -O /dev/null \
        https://127.0.0.1:8443/dashboard/ \
        2>&1 \
    | grep -Eq "401|403" \
    || fail "Dashboard protection is not enabled."

ok "Dashboard protection OK."
}