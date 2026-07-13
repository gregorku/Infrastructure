deploy_summary()
{
    print_section "Deployment completed"

    ok "Stack synchronized."

    info "Repository : ${PROJECT_DIR}"
    info "Stack      : ${STACK_DIR}"

    echo

    info "Next step:"
    info "Open Dockge and click Redeploy."
}