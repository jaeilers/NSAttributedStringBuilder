#!/bin/bash

set -e

ROOT_PATH=$(git rev-parse --show-toplevel)

# Returns the coverage file paths comma separated for codecov.io
echo "$(find "${ROOT_PATH}" -type d -name 'cov*' -exec find {} -type f -name '*.xml' \; | paste -s -d ',' -)"
