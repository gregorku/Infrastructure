###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/tests/dockge.sh
#
# Description:
#   Dockge validation tests.
#
###############################################################################

test_dockge()
{
    print_section "Dockge"

    docker_container_running "${DOCKGE_CONTAINER}" \
        || fail "Dockge container is not running."

    local dockge_path

    dockge_path="$(
        docker_exec \
            "${DOCKGE_CONTAINER}" \
            printenv DOCKGE_STACKS_DIR
    )"

    [[ "${dockge_path}" == "/zfs-data/stacks" ]] \
        || fail "Dockge stack path is '${dockge_path}'."

    ok "Dockge stack path OK."
}