#!/usr/bin/env bash

cd ..
mkdir -p artifacts
dpkg-deb --build casper-node-util "./artifacts/casper-node-util-$(cat VERSION).deb"