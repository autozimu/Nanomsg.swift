#!/usr/bin/env bash

set -euf -o pipefail

if [[ ! -d $HOME/.nanomsg ]]; then
    git clone https://github.com/nanomsg/nanomsg.git $HOME/.nanomsg
    cd $HOME/.nanomsg
    git checkout 1.0.0
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
    cmake --build .
fi

cd $HOME/.nanomsg/build
sudo cmake --build . --target install

if [[ $TRAVIS_OS_NAME == "linux" ]]; then
    sudo ldconfig
fi
