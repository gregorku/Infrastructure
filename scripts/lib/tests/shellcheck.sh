#!/usr/bin/env bash

find scripts -name "*.sh" -print0 |
xargs -0 shellcheck \
    -x \
    -e SC1091