#!/usr/bin/env bash
init_stack() {
    print_section "Project stack"
    log_info "Preparing Infrastructure stack..."
    mkdir -p "${STACK_DIR}"
    for item in "${DEPLOY_ITEMS[@]}"; do
        cp -a "${GIT_DIR}/${item}" "${STACK_DIR}/"
    done
    log_success "Infrastructure stack prepared."
}
