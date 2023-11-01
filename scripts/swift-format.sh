#!/bin/bash

if ! (which swiftformat > /dev/null); then
  echo "Warning: Swiftformat is not installed. download from https://github.com/nicklockwood/SwiftFormat"
fi

ROOT_PATH=$(git rev-parse --show-toplevel)
CONFIG_PATH="${ROOT_PATH}/.swiftformat"
EXCLUDE_PATHS="${ROOT_PATH}/vendor,${ROOT_PATH}/fastlane,${ROOT_PATH}/fastlane_builds"

swiftformat "$ROOT_PATH" \
  --config "$CONFIG_PATH" \
  --exclude "${EXCLUDE_PATHS}"
