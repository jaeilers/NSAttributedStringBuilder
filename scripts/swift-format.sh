#!/bin/bash

ROOT_PATH=$(git rev-parse --show-toplevel)
SOURCE_PATH="${ROOT_PATH}/"
CONFIG_PATH="${ROOT_PATH}/.swiftformat"
EXCLUDE_PATHS="${ROOT_PATH}/vendor,${ROOT_PATH}/BuildTools"

swift run \
  -c release \
  --package-path "${ROOT_PATH}/BuildTools" \
  swiftformat "$SOURCE_PATH" \
  --config "${CONFIG_PATH}" \
  --exclude "${EXCLUDE_PATHS}"
