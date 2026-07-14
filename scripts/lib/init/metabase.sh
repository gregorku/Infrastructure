###############################################################################
#
# Infrastructure Project
#
# File:
#   scripts/lib/init/metabase.sh
#
# Description:
#   Initialize Metabase directories.
#
###############################################################################

init_metabase() {

    print_section "Metabase"

    #
    # PostgreSQL
    #

    ensure_directory "${DATA_DIR}/metabase/postgres"

    ensure_directory "${DATA_DIR}/metabase/postgres/data"

    #
    # Metabase
    #

    ensure_directory "${DATA_DIR}/metabase/metabase"

    ensure_directory "${DATA_DIR}/metabase/metabase/data"

    ensure_directory "${DATA_DIR}/metabase/metabase/plugins"

    ensure_directory "${DATA_DIR}/metabase/metabase/logs"

    ensure_directory "${DATA_DIR}/metabase/metabase/backups"

    success "Metabase directories ready."
}