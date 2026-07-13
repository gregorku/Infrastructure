###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/deploy/verify.sh
#
# Description:
#   Deployment project verification.
#
###############################################################################

deploy_verify_project()
{
    print_section "Verifying project"

    require_directory "${PROJECT_DIR}"

    require_file "${PROJECT_DIR}/compose.yml"

    require_directory "${PROJECT_DIR}/compose"

    require_directory "${PROJECT_DIR}/configs"

    ok "Project structure OK."
}