#!/usr/bin/env bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 && pwd)"
mkdir -p "$ROOT_DIR/artifacts"
dpkg-deb -Zgzip --build casper-node-util "$ROOT_DIR/artifacts/casper-node-util-$(cat VERSION).deb"