#!/bin/bash

## ruby stuff
echo Build rubies

declare -a versions=(2.3.1) # 2.1.5 2.2.2 2.4.1

if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
else
  cd ~/.rbenv && git pull
fi

if [ ! -d ~/.rbenv/plugins/ruby-build ]; then
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
else
  cd ~/.rbenv/plugins/ruby-build && git pull
fi

type rbenv >& /dev/null
if [ $? != 0 ]; then
  echo rbenv fail
  PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
else
  echo rbenv ok
fi

for ruby in "${versions[@]}"
do
  echo "installing $ruby"
  rbenv install -s $ruby
  rbenv shell $ruby
  gem install --conservative bundler rake rake-compiler rspec hashie pargser
done

rbenv global ${versions[-1]}
