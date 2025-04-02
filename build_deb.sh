#!/usr/bin/env bash

mkdir -p debian
dpkg-deb --build casper-node-util "./debian/casper-node-util-$(cat VERSION).deb"