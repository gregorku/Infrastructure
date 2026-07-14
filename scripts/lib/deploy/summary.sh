#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy/summary.sh
#
# Description:
#   Deployment summary.
#
###############################################################################

deploy_summary()
{
    print_section "Deployment completed"

    ok "Stack synchronized."

    info "Repository : ${GIT_DIR}"
    info "Stack      : ${STACK_DIR}"

    echo

    info "Next step:"
    info "Open Dockge and click Redeploy."
}