#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/config.sh"

source "${SCRIPT_DIR}/lib/logging.sh"
source "${SCRIPT_DIR}/lib/common.sh"

source "${SCRIPT_DIR}/lib/filesystem.sh"

source "${SCRIPT_DIR}/lib/docker.sh"
source "${SCRIPT_DIR}/lib/git.sh"

separator

log_info "Testing Infrastructure library"

require_command git
require_command docker

log_success "Everything is OK."

separator

ensure_directory "/tmp/infrastructure-test"

ensure_file "/tmp/infrastructure-test/test.txt"

log_success "Filesystem library OK."

branch="$(git_current_branch)"
revision="$(git_current_revision)"

log_info "Git branch : ${branch}"
log_info "Git revision : ${revision}"

docker_compose_config

log_success "Docker library OK."