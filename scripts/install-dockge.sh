#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/install-dockge.sh
#
# Description:
#   Installs (or reinstalls) Dockge.
#
#   The script:
#     - stops and removes an existing Dockge container
#     - creates required directories
#     - starts Dockge
#
# Configuration:
#   scripts/config.sh
#
###############################################################################

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/config.sh
source "${SCRIPT_DIR}/config.sh"

###############################################################################
# Stop previous container
###############################################################################

docker stop "${DOCKGE_CONTAINER}" >/dev/null 2>&1 || true
docker rm   "${DOCKGE_CONTAINER}" >/dev/null 2>&1 || true

###############################################################################
# Prepare directories
###############################################################################

mkdir -p "${DOCKGE_DATA_DIR}"
mkdir -p "${STACKS_DIR}"

###############################################################################
# Install Dockge
###############################################################################

docker run -d \
    --name "${DOCKGE_CONTAINER}" \
    --restart unless-stopped \
    -p "${DOCKGE_PORT}:5001" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "${DOCKGE_DATA_DIR}:/app/data" \
    -v "${STACKS_DIR}:${STACKS_DIR}" \
    -e DOCKGE_STACKS_DIR="${STACKS_DIR}" \
    "${DOCKGE_IMAGE}"

###############################################################################
# Done
###############################################################################

echo
echo "Dockge installed."
echo "URL: http://<server>:${DOCKGE_PORT}"