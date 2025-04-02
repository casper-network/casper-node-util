#!/usr/bin/env bash

# This script will build
#  - debian package
#  - version.json
# in target/artifacts

set -e

if command -v jq >&2; then
  echo "jq installed"
else
  echo "ERROR: jq is not installed and required"
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 && pwd)"
ARTIFACTS_DIR="$ROOT_DIR/artifacts/"
GIT_HASH=$(git rev-parse HEAD)
BRANCH_NAME=$(git branch --show-current)
SCRIPT_VERSION=$(cat "$ROOT_DIR/VERSION")

echo "Copying debian to artifacts"
"$ROOT_DIR/ci/build_deb.sh"

echo "Copying script to artifacts"
cp "$ROOT_DIR/casper-node-util/usr/bin/casper-node-util" "$ARTIFACTS_DIR/casper-node-util"

echo "Building version.json"
jq --null-input \
--arg	branch "$BRANCH_NAME" \
--arg version "$SIDECAR_VERSION" \
--arg ghash "$GIT_HASH" \
--arg now "$(jq -nr 'now | strftime("%Y-%m-%dT%H:%M:%SZ")')" \
--arg files "$(ls "$ARTIFACTS_DIR" | jq -nRc '[inputs]')" \
'{"branch": $branch, "version": $version, "git-hash": $ghash, "timestamp": $now, "files": $files}' \
> "$ARTIFACTS_DIR/version.json"
