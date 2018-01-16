#!/usr/bin/env bash

set -eufx -o pipefail

git clone https://github.com/nanomsg/nanomsg.git /tmp/nanomsg
cd /tmp/nanomsg
git checkout 1.1.2

mkdir build && cd build
apt-get update && apt-get install --yes cmake
cmake ..
cmake --build .
cmake --build . --target install

ldconfig
