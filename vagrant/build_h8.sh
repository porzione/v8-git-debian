#!/bin/bash

## build h8 https://github.com/sergeych/hybrid8 or forks

REPO=$1

if [ -z "$REPO" ]; then
  echo "git repo url is required"
  exit 1
fi

NAME=`ruby -r uri -e "print URI::parse(ARGV[0]).path[1..-1].gsub('/', '_')" $REPO`
echo BUILD FOR: $NAME
cd ~/src
if [ -d $NAME ]; then
  cd $NAME
  git pull
else
  git clone $REPO $NAME
  cd $NAME
fi

rake compile

