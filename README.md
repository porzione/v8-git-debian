Debian packaging for latest google V8 library (WIP)
===========

### manually build Debian package

Prerequisites

Debian tools: ```apt-get install build-essential debhelper devscripts cdbs clang-3.5```

Ruby language and rake gem.

Prepare v8 source tree and tools as described in https://github.com/v8/v8/wiki/Building-from-Source.

Execute in source tree:

```
rake -f ~/v8-git-debian/Rakefile src:checkout
rake -f ~/v8-git-debian/Rakefile debian:files
```

inspect output and `debian` folder then run

```
dpkg-buildpackage -nc
```

### automatic provision and build in Vagrant/Debian


prepare vagrant box

```
vagrant box add debian87 https://atlas.hashicorp.com/bento/boxes/debian-8.7/versions/2.3.4/providers/virtualbox.box

```

#### scripts called by `vagrant provision`

`provision.sh` install all dev dependencies

`user_provision.sh` install rbenv and ruby for vagrant user

#### user scripts, located in /vagrant inside the box

`build_v8.sh` build v8 Debian package, consider to run the larger box with `VBOX=LARGE vagrant up` with real nproc cpu count and 8 GB RAM

`build_h8.sh` build hybrid8 ruby gem 

#### experimental repo at debian.fiam.me

add repo key
```
curl http://debian.fiam.me/fiamme.gpg | sudo apt-key add -
```

add apt source
```
echo "deb [arch=amd64] http://debian.fiam.me wheezy main" > /etc/apt/sources.list.d/fiamme.list
```

install package
```
sudo apt-get update
sudo apt-get install libv8-3.xx-dev
```
