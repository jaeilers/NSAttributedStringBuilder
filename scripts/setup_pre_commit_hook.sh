#!/bin/bash

set -e

setup_pre_commit_hook() {

  ROOT_PATH=$(git rev-parse --show-toplevel)
  SHEBANG="#!/bin/sh"
  MODIFY_WARNING="# Do not modify this file! This file was auto-generated. The source can be found in ${ROOT_PATH}/scripts/pre-commit."
  FILE_NAME="pre-commit"

  SOURCE_PATH="${ROOT_PATH}/scripts/$FILE_NAME"
  DESTINATION_PATH="${ROOT_PATH}/.git/hooks/$FILE_NAME"

  if [[ -e "$DESTINATION_PATH" ]]; then
    echo "Pre-Commit hook is already installed."
    exit 0
  fi

  echo "$SHEBANG" > "$DESTINATION_PATH"
  echo "$MODIFY_WARNING" >> "$DESTINATION_PATH"
  cat "$SOURCE_PATH" >> "$DESTINATION_PATH"
  echo "$MODIFY_WARNING" >> "$DESTINATION_PATH"

  chmod +x "$DESTINATION_PATH"

}

setup_pre_commit_hook
