#!/bin/bash

## repos:
## https://github.com/sergeych/hybrid8
## https://github.com/porzione/hybrid8

echo Build h8

if [ "$#" -ne 2 ] ; then
  echo "usage: $0 REPO RUBY_VERSION"
  exit 1
fi

REPO=$1
RUBY=$2

eval "$(rbenv init -)"
rbenv shell "${RUBY}"

NAME=`ruby -r uri -e "print URI::parse(ARGV[0]).path[1..-1].gsub('/', '_')" $REPO`
echo BUILD FOR: $NAME

test -d ~src || mkdir ~src
cd ~src

if [ -d $NAME ]; then
  cd $NAME
  git pull
else
  git clone $REPO $NAME
  cd $NAME
fi

find lib -name *.so -delete
echo Complile
rake clean compile
echo RSpec
rspec

