###############################################################################
#
# Get HTTP response headers from inside a container.
#
# Usage:
#   docker_http_headers <container> <url>
#
###############################################################################

docker_http_headers()
{
    local container="$1"
    local url="$2"

    docker_exec "${container}" \
        wget \
            --no-check-certificate \
            -S \
            -O /dev/null \
            "${url}" \
            2>&1 || true
}