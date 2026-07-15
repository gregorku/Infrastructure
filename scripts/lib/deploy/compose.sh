#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy/compose.sh
#
# Description:
#   Docker Compose deployment checks.
#
###############################################################################

deploy_validate_compose()
{
    print_section "Compose validation"

    check_compose_configuration
}