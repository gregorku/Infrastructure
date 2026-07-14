###############################################################################
#
# Check .env
#
###############################################################################

deploy_check_env()
{
    print_section "Checking .env"

    local missing=0

    deploy_check_env_example_exists || return 1
    deploy_check_env_exists || return 1

    deploy_check_env_variables || missing=1

    if (( missing )); then

        fail ".env requires update."

        echo
        info "Run:"
        echo
        echo "    ./scripts/update-env.sh"
        echo

        return 1

    fi

    ok "Environment configuration OK."
}