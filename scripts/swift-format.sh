#!/bin/bash

set -e

if ! (which swiftformat > /dev/null); then
  echo "⚠️  SwiftFormat is not installed. Download from https://github.com/nicklockwood/SwiftFormat"
  exit 1
fi

ROOT_PATH=$(git rev-parse --show-toplevel)
CONFIG_PATH="${ROOT_PATH}/.swiftformat"
SOURCE_PATH="${ROOT_PATH}/Sources"

swiftformat "$SOURCE_PATH" \
  --config "$CONFIG_PATH"
