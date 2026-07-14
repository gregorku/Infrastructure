#!/usr/bin/env bash

###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/post-deploy/metabase.sh
#
# Description:
#   Verify Metabase after deployment.
#
###############################################################################

post_deploy_metabase()
{
    print_section "Metabase"

    ###########################################################################
    # Verify PostgreSQL container
    ###########################################################################

    docker_container_running "postgres-metabase"

    ok "PostgreSQL container OK."

    ###########################################################################
    # Verify Metabase container
    ###########################################################################

    docker_container_running "metabase"

    ok "Metabase container OK."

    ###########################################################################
    # Wait for PostgreSQL
    ###########################################################################

    info "Waiting for PostgreSQL..."

    until docker exec postgres-metabase \
        pg_isready \
        -U "${METABASE_DB_USER}" \
        -d "${METABASE_DB_NAME}" >/dev/null 2>&1
    do
        sleep 2
    done

    ok "PostgreSQL ready."

    ###########################################################################
    # Wait for Metabase
    ###########################################################################

    info "Waiting for Metabase..."

    until docker exec metabase \
        wget -q --spider http://localhost:3000/api/health
    do
        sleep 2
    done

    ok "Metabase ready."
}