#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy/verify.sh
#
# Description:
#   Verify Infrastructure project before deployment.
#
###############################################################################

deploy_verify_project()
{
    print_section "Verifying project"

    local item

    for item in "${DEPLOY_ITEMS[@]}"; do
        require_file_or_directory "${GIT_DIR}/${item}"
    done

    ok "Project structure OK."
}