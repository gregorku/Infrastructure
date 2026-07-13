test_traefik()
{
    print_section "Traefik"

    docker_container_running "${TRAEFIK_SERVICE}" \
        || fail "Traefik container is not running."

    docker_exec "${TRAEFIK_SERVICE}" \
        ss -tln \
        | grep -q ":8443" \
        || fail "Admin entrypoint missing."

    ok "Admin entrypoint OK."

    docker_exec "${TRAEFIK_SERVICE}" \
        ss -tln \
        | grep -q ":443" \
        || fail "HTTPS entrypoint missing."

    ok "HTTPS entrypoint OK."

    docker_exec "${TRAEFIK_SERVICE}" \
        ss -tln \
        | grep -q ":80" \
        || fail "HTTP entrypoint missing."

    ok "HTTP entrypoint OK."

    docker_exec "${TRAEFIK_SERVICE}" \
        wget \
            --no-check-certificate \
            -qS \
            -O /dev/null \
            https://127.0.0.1:8443/dashboard/ \
            2>&1 \
        | grep -q "401 Unauthorized" \
        || fail "Dashboard authentication missing."

    ok "Dashboard authentication OK."
}