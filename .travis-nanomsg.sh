#!/usr/bin/env bash

set -euf -o pipefail

if [[ ! -d .nanomsg ]]; then
    git clone https://github.com/nanomsg/nanomsg.git ~/.nanomsg
    cd ~/.nanomsg
    git checkout 1.0.0
    mkdir build
    cd build
    cmake ..
    cmake -- build .
fi

cd ~/.nanomsg/build
sudo cmake --build . --target install
sudo ldconfig
