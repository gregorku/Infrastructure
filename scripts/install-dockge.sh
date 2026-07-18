#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------------------------
# install-dockge.sh
#
# Instaluje nebo přeinstaluje Dockge.
#
# Vyžaduje:
#   - scripts/config.sh
#
# Používané proměnné:
#   DOCKGE_CONTAINER
#   DOCKGE_IMAGE
#   DOCKGE_PORT
#   DOCKGE_DATA_DIR
#   STACKS_DIR
# ------------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/config.sh
source "${SCRIPT_DIR}/config.sh"

# Odstranění případné staré instance
docker stop "${DOCKGE_CONTAINER}" >/dev/null 2>&1 || true
docker rm   "${DOCKGE_CONTAINER}" >/dev/null 2>&1 || true

# Příprava adresářů
mkdir -p "${DOCKGE_DATA_DIR}"
mkdir -p "${STACKS_DIR}"

# Instalace Dockge
docker run -d \
    --name "${DOCKGE_CONTAINER}" \
    --restart unless-stopped \
    -p "${DOCKGE_PORT}:5001" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "${DOCKGE_DATA_DIR}:/app/data" \
    -v "${STACKS_DIR}:${STACKS_DIR}" \
    -e DOCKGE_STACKS_DIR="${STACKS_DIR}" \
    "${DOCKGE_IMAGE}"

echo
echo "Dockge installed."
echo "URL: http://<server>:${DOCKGE_PORT}"