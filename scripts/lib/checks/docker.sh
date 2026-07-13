###############################################################################
#
# Verify Docker environment.
#
###############################################################################

check_docker_environment()
{
    check_environment

    require_docker

    require_docker_daemon

    ok "Docker environment OK."
}