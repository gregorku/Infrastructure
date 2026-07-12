#!/usr/bin/env bash
###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/git.sh
#
###############################################################################

git_is_clean() {

    (
        cd "${GIT_DIR}"

        git diff --quiet &&
        git diff --cached --quiet
    )
}

git_current_branch() {

    (
        cd "${GIT_DIR}"

        git rev-parse --abbrev-ref HEAD
    )
}

git_current_revision() {

    (
        cd "${GIT_DIR}"

        git rev-parse --short HEAD
    )
}