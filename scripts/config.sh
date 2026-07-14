#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/config.sh
#
# Description:
#   Common configuration shared by all Infrastructure scripts.
#
###############################################################################

set -Eeuo pipefail
IFS=$'\n\t'

###############################################################################
# Project
###############################################################################

readonly PROJECT_NAME="Infrastructure"

#
# Docker Compose / Dockge stack name
# (always lowercase)
#
readonly STACK_NAME="infrastructure"

###############################################################################
# Repository
###############################################################################

readonly GIT_DIR="/incus-dir/git/${PROJECT_NAME}"

###############################################################################
# Docker stack
###############################################################################

readonly STACK_DIR="/zfs-data/stacks/${STACK_NAME}"

###############################################################################
# Persistent data
###############################################################################

readonly DATA_DIR="/zfs-data/infrastructure-data"

###############################################################################
# Service directories
###############################################################################

readonly TRAEFIK_DIR="${DATA_DIR}/traefik"
readonly CROWDSEC_DIR="${DATA_DIR}/crowdsec"
readonly WATCHTOWER_DIR="${DATA_DIR}/watchtower"

###############################################################################
# Deployment
###############################################################################

readonly DEPLOY_ITEMS=(
    compose.yml
    compose
    configs
    .env.example
)

###############################################################################
# Containers
###############################################################################

readonly DOCKGE_CONTAINER="dockge"

###############################################################################
# Compose services
###############################################################################

readonly TRAEFIK_SERVICE="traefik"
readonly CROWDSEC_SERVICE="crowdsec"
readonly WATCHTOWER_SERVICE="watchtower"

###############################################################################
# Docker networks
###############################################################################

readonly NETWORK_INTERNAL="bridge-moje"
readonly NETWORK_TRAEFIK="traefik-moje"

###############################################################################
# Docker Compose
###############################################################################

readonly COMPOSE_FILE="${STACK_DIR}/compose.yml"

###############################################################################
# Colors
###############################################################################

readonly COLOR_RED="\033[0;31m"
readonly COLOR_GREEN="\033[0;32m"
readonly COLOR_YELLOW="\033[1;33m"
readonly COLOR_BLUE="\033[0;34m"
readonly COLOR_RESET="\033[0m"

###############################################################################
# Traefik configuration
###############################################################################

readonly TRAEFIK_CONFIG_DIR="${GIT_DIR}/configs/traefik"
readonly TRAEFIK_DYNAMIC_DIR="${TRAEFIK_CONFIG_DIR}/dynamic"
readonly TRAEFIK_USERS_DIR="${TRAEFIK_CONFIG_DIR}/users"
readonly TRAEFIK_HTPASSWD_FILE="${TRAEFIK_USERS_DIR}/dashboard.htpasswd"

###############################################################################
# CrowdSec
###############################################################################

readonly CROWDSEC_BOUNCER_NAME="traefik"

readonly CROWDSEC_BOUNCER_DIR="${TRAEFIK_DIR}/crowdsec"

readonly CROWDSEC_BOUNCER_KEY_FILE="${CROWDSEC_BOUNCER_DIR}/BOUNCER_KEY_${CROWDSEC_BOUNCER_NAME}"