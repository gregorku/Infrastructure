#!/usr/bin/env bash
set -euo pipefail

docker stop dockge 2>/dev/null || true
docker rm dockge 2>/dev/null || true

mkdir -p /zfs-data/dockge
mkdir -p /zfs-data/stacks

docker run -d \
  --name dockge \
  --restart unless-stopped \
  -p 5001:5001 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /zfs-data/dockge:/app/data \
  -v /zfs-data/stacks:/zfs-data/stacks \
  -e DOCKGE_STACKS_DIR=/zfs-data/stacks \
  louislam/dockge:latest

echo
echo "Dockge installed."
echo "URL: http://<server>:5001"