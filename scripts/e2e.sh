#!/usr/bin/env bash
./scripts/link.sh 9999.0.0

rm -rf tmp
mkdir -p tmp/angular
mkdir -p tmp/nx

if [ -n "$1" ]; then
  TEST_FILE="./build/e2e/$1.test.js"
  COMMAND_FILE="./build/e2e/commands/$1.test.js"

  if [ -f "$TEST_FILE" ]; then
    PUBLISHED_VERSION=9999.0.0 NPM_CONFIG_REGISTRY=http://localhost:4872/ jest -c "./build/e2e/jest-config.js" --maxWorkers=1 $TEST_FILE
  else
    PUBLISHED_VERSION=9999.0.0 NPM_CONFIG_REGISTRY=http://localhost:4872/ jest -c "./build/e2e/jest-config.js" --maxWorkers=1 $COMMAND_FILE
  fi
else
  PUBLISHED_VERSION=9999.0.0 NPM_CONFIG_REGISTRY=http://localhost:4872/ jest -c "./build/e2e/jest-config.js" --maxWorkers=1 ./build/e2e/*.test.js
fi
