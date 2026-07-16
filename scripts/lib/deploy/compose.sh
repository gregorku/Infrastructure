#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy/compose.sh
#
# Description:
#   Validate Docker Compose configuration.
#
###############################################################################

###############################################################################
# Validate Docker Compose configuration
###############################################################################

deploy_validate_compose()
{
    print_section "Compose validation"

    check_compose_configuration
}