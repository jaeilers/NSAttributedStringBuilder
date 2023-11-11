#!/bin/bash

set -e

if ! (which bundler > /dev/null); then
  echo "⚠️  Bundler is not installed. Please install bundler: gem install bundler"
  exit 1
fi

ROOT_PATH=$(git rev-parse --show-toplevel)
VENDOR_FOLDER_PATH="${ROOT_PATH}/vendor"
GEMFILE_LOCK_PATH="${ROOT_PATH}/Gemfile.lock"
GREEN="\x1B[32m"
NO_COLOR="\x1B[0m"

pushd "$ROOT_PATH"

if [[ -d "$VENDOR_FOLDER_PATH" ]]; then
  echo -e "${GREEN}Removing folder at path:$NO_COLOR $VENDOR_FOLDER_PATH"
  rm -rf "$VENDOR_FOLDER_PATH"
fi

if [[ -f "$GEMFILE_LOCK_PATH" ]]; then
  echo -e "${GREEN}Removing file at path:$NO_COLOR $GEMFILE_LOCK_PATH"
  rm "$GEMFILE_LOCK_PATH"
fi

bundle config set --local path 'vendor/bundle'
bundle install

declare -a PLATFORMS=("ruby" "arm64-darwin-22" "x86_64-darwin-22")

for platform in "${PLATFORMS[@]}"; do
  bundle lock --add-platform "$platform"
done

popd
