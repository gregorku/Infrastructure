#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/tests/summary.sh
#
# Description:
#   Print Infrastructure test summary.
#
###############################################################################

###############################################################################
# Test summary
###############################################################################

test_summary()
{
    print_section "Finished"

    ok "Infrastructure tests completed."

    echo

    info "Review the output above for warnings or failures."

    echo

    ok "Test summary completed."
}