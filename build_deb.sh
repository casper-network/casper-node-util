#!/usr/bin/env bash

dpkg-deb --build casper-node-util "casper-node-util-$(cat VERSION).deb"