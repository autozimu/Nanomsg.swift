#!/usr/bin/env bash

set -eufx -o pipefail

if [[ $TRAVIS_OS_NAME == "osx" ]]; then
    brew update
    brew install nanomsg
    exit 0
fi

if [[ ! -d $HOME/.nanomsg/build ]]; then
    rm -rf $HOME/.nanomsg
    git clone https://github.com/nanomsg/nanomsg.git $HOME/.nanomsg
    cd $HOME/.nanomsg
    git checkout 1.1.2
    mkdir build
    cd build
    cmake ..
    cmake --build .
fi

cd $HOME/.nanomsg/build
sudo cmake --build . --target install
sudo ldconfig
