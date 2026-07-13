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
    # Dashboard must be protected.
    #
    local output

    output="$(
        docker_exec "${TRAEFIK_SERVICE}" \
            wget \
                --no-check-certificate \
                -S \
                -O /dev/null \
                https://127.0.0.1:8443/dashboard/ \
                2>&1 || true
    )"

    echo "${output}" \
        | grep -Eq "HTTP/1\.[01] (401|403)" \
        || fail "Dashboard protection is not enabled."

    ok "Dashboard protection OK."
}