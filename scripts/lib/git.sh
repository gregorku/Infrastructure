#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/git.sh
#
# Description:
#    Git helper functions.
###############################################################################

git_is_clean()
{

    require_git

    (
        cd "${GIT_DIR}"

        git diff --quiet &&
        git diff --cached --quiet
    )
}

git_current_branch()
{

    require_git

    (
        cd "${GIT_DIR}"
        git rev-parse --abbrev-ref HEAD
    )
}

git_current_revision()
{

    require_git

    (
        cd "${GIT_DIR}"
        git rev-parse --short HEAD
    )
}