#!/bin/bash

DIR_V8=~/src/v8
DIR_BLD=~/src/v8deb

## v8 git

test -d ~/depot_tools || git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
grep 'depot_tools' ~/.bash_profile || echo 'export PATH="$HOME/depot_tools:$PATH"' >> ~/.bash_profile
source ~/.bash_profile

test -d ~/src || mkdir ~/src
cd ~/src

if [ -d v8 ]; then
  cd v8
  git checkout -f master
  git pull
else
  fetch v8
fi

# v8 debian build

cd ~/src

if [ -d ${DIR_BLD} ]; then
  cd ${DIR_BLD}
  git pull
else
  git clone https://github.com/porzione/v8-git-debian ${DIR_BLD}
fi

cd ${DIR_V8}

rake -f ${DIR_BLD}/Rakefile src:checkout
rake -f ${DIR_BLD}/Rakefile debian:files

dpkg-buildpackage -nc

