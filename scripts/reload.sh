#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/reload.sh
#
# Description:
#   Reload the Infrastructure Docker stack.
#
# Usage:
#   ./scripts/reload.sh [OPTION]
#
# Options:
#   --pull
#       Pull the latest Docker images before reload.
#
#   -h, --help
#       Show this help.
#
###############################################################################

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/config.sh"
source "${SCRIPT_DIR}/lib/common.sh"
source "${SCRIPT_DIR}/lib/logging.sh"
source "${SCRIPT_DIR}/lib/checks/environment.sh"
source "${SCRIPT_DIR}/lib/checks/docker.sh"
source "${SCRIPT_DIR}/lib/checks/project.sh"
source "${SCRIPT_DIR}/lib/docker-compose.sh"

PULL_IMAGES=false

case "${1:-}" in
    "")
        ;;
    --pull)
        PULL_IMAGES=true
        ;;
    -h|--help)
        cat <<EOF
Infrastructure Project

Usage:
    ./scripts/reload.sh [OPTION]

Options:

    --pull
        Pull the latest Docker images before reload.

    -h, --help
        Show this help.

Description:

    Reload the Infrastructure Docker stack.

    Steps:

      1. Verify environment
      2. Verify Docker
      3. Verify project
      4. (Optional) Pull Docker images
      5. Recreate containers
      6. Run post deployment
      7. Run infrastructure tests

EOF
        exit 0
        ;;
    *)
        fail "Unknown option: ${1}"
        ;;
esac

print_header "Infrastructure reload"

check_environment
check_docker_environment
check_project_structure

if ${PULL_IMAGES}; then
    print_section "Pulling Docker images"

    compose_cmd pull

    ok "Docker images updated."
fi

print_section "Reloading containers"

compose_cmd up \
    -d \
    --force-recreate \
    --remove-orphans

ok "Containers recreated."

print_section "Post deployment"

"${SCRIPT_DIR}/post-deploy.sh"

print_section "Infrastructure test"

"${SCRIPT_DIR}/test.sh"

print_section "Finished"

ok "Infrastructure reload completed."