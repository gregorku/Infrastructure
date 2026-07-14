#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy/compose.sh
#
# Description:
#   Validate Docker Compose configuration before deployment.
#
###############################################################################

deploy_validate_compose()
{
    print_section "Compose validation"

    validate_compose
}