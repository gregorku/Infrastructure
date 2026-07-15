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

    require_container_running "${POSTGRES_METABASE_SERVICE}"

    ok "PostgreSQL container OK."

    ###############################################################################
    # Wait for PostgreSQL
    ###############################################################################

    info "Waiting for PostgreSQL..."

    local timeout=60

    until docker_exec "${POSTGRES_METABASE_SERVICE}" \
        pg_isready \
        -U "${METABASE_DB_USER}" \
        -d "${METABASE_DB_NAME}" >/dev/null 2>&1
    do
        ((timeout--))

        ((timeout > 0)) \
            || fail "PostgreSQL startup timeout."

        sleep 2
    done

    ok "PostgreSQL ready."

    ###############################################################################
    # Wait for Metabase
    ###############################################################################

    info "Waiting for Metabase..."

    timeout=60

    until docker_exec "${METABASE_SERVICE}" \
        wget -q --spider http://localhost:3000/api/health
    do
        ((timeout--))

        ((timeout > 0)) \
            || fail "Metabase startup timeout."

        sleep 2
    done

    ok "Metabase ready."
}