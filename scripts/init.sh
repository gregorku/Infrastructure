#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/config.sh"

mkdir -p "${DATA_DIR}"

mkdir -p "${DATA_DIR}/traefik/acme"
mkdir -p "${DATA_DIR}/traefik/logs"

touch "${DATA_DIR}/traefik/acme/acme.json"

chmod 600 "${DATA_DIR}/traefik/acme/acme.json"

echo "Infrastructure initialized."