# Login shells

if [[ -f ~/.bashrc ]]; then
   source ~/.bashrc
fi

## ruby

path=$HOME/.rbenv/bin
if [[ -d $path ]] ; then
  echo found rbenv
  export PATH=$path:$PATH
  eval "$(rbenv init -)"
fi

## v8 depot_tools

path=$HOME/depot_tools
if [[ -d $path ]] ; then
  echo found depot_tools
  export PATH=$path:$PATH
fi


unset path
