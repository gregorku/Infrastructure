#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/tests/metabase.sh
#
# Description:
#   Test Metabase deployment.
#
###############################################################################

test_metabase()
{
    print_section "Metabase"

    ###########################################################################
    # PostgreSQL
    ###########################################################################

    docker_container_running "postgres-metabase"

    ok "PostgreSQL container OK."

    ###########################################################################
    # Metabase
    ###########################################################################

    docker_container_running "metabase"

    ok "Metabase container OK."

    ###########################################################################
    # Directories
    ###########################################################################

    directory_exists "${DATA_DIR}/metabase/postgres/data"

    ok "PostgreSQL data directory OK."

    directory_exists "${DATA_DIR}/metabase/metabase/data"

    ok "Metabase data directory OK."

    directory_exists "${DATA_DIR}/metabase/metabase/plugins"

    ok "Plugins directory OK."

    directory_exists "${DATA_DIR}/metabase/metabase/logs"

    ok "Logs directory OK."

    directory_exists "${DATA_DIR}/metabase/metabase/backups"

    ok "Backups directory OK."
}