#!/bin/bash

set -e

bundle exec pod lib lint --allow-warnings
bundle exec pod trunk push --allow-warnings
