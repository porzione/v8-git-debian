#!/bin/bash

echo Build v8

DEB_BUILD_DIR=~/v8deb
DT_DIR=~/depot_tools
unset HTTP_PROXY http_proxy

pushd ~

## depot_tools

if [ ! -d "${DT_DIR}" ] ; then
  echo "Install depot_tools"
  git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
  grep 'depot_tools' ~/.bash_profile || echo 'export PATH="${DT_DIR}:$PATH"' >> ~/.bash_profile
  source ~/.bash_profile
  gclient
fi

## v8 git

cd ~

if [ -d v8 ]; then
  echo "Update v8"
  cd v8
  git checkout -f master
  git pull
else
  echo "Get v8"
  fetch v8
  cd v8
fi

# v8 debian build

if [ -d ${DEB_BUILD_DIR} ]; then
  cd ${DEB_BUILD_DIR}
  git pull
else
  git clone https://github.com/porzione/v8-git-debian "${DEB_BUILD_DIR}"
fi

cd ~/v8

source ~/.bash_profile
rake -f ${DEB_BUILD_DIR}/Rakefile src:checkout
rake -f ${DEB_BUILD_DIR}/Rakefile debian:files

dpkg-buildpackage -nc

popd

