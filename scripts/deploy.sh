#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/deploy.sh
#
###############################################################################

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/config.sh"

echo
echo "Deploying ${PROJECT_NAME}"
echo

mkdir -p "${STACK_DIR}"

echo "Synchronizing stack..."

rsync -av --delete \
    --exclude ".git" \
    --exclude ".github" \
    --exclude "docs" \
    --exclude "examples" \
    --exclude "scripts" \
    --exclude ".env" \
    "${GIT_DIR}/" \
    "${STACK_DIR}/"

if [[ ! -f "${STACK_DIR}/.env" ]]; then
    echo "Creating .env from .env.example"
    cp "${STACK_DIR}/.env.example" "${STACK_DIR}/.env"
fi

echo
echo "Validating compose..."

cd "${STACK_DIR}"

${DOCKER_COMPOSE} config

echo
echo "Deployment finished."
echo
echo "Open Dockge and click:"
echo
echo "   Redeploy"
echo