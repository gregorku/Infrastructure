#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/post-deploy/summary.sh
#
# Description:
#   Post-deployment summary.
#
###############################################################################

post_deploy_summary()
{
    print_section "Finished"

    ok "Post deployment completed."

    echo

    info "Next step:"

    echo "  ./scripts/test.sh"

    echo
}