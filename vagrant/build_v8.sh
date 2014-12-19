#!/bin/bash

DIR_V8=~/src/v8
DIR_BLD=~/src/v8deb

## v8 git

sudo apt-get -y install gyp

test -d ~/depot_tools || git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
grep 'depot_tools' ~/.bash_profile || echo 'export PATH="$HOME/depot_tools:$PATH"' >> ~/.bash_profile
source ~/.bash_profile

test -d ~/src || mkdir ~/src
cd ~/src

if [ -d v8 ]; then
  #gclient sync
  cd v8
  git fetch
else
  fetch v8
fi

# v8 debian build

cd ~/src

test -d ${DIR_BLD} || git clone https://github.com/porzione/v8-git-debian ${DIR_BLD}

cd ${DIR_V8}

rake -f ${DIR_BLD}/Rakefile src:checkout
rake -f ${DIR_BLD}/Rakefile debian:files

dpkg-buildpackage -nc
