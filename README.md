Debian packaging for google V8 library version 3.x, work in progress.
===========

#### There are 2 ways to build libv8

#### 1. build Debian package in Vagrant

prepare vagrant box with Debian Jessie
```
vagrant box add debian/jessie64
cd vagrant.jessie
vagrant up

```
scripts called by `vagrant provision` during `vagrant up`:  
`provision.sh` install all dev dependencies  
user scripts in /vagrant inside the box:  
`build_rubies.sh` install rbenv and rubies, see versions inside  
`build_v8.sh` build v8 Debian package  
`build_h8.sh <REPO> <RUBY_VERSION>` build hybrid8 ruby gem, for example  
`build_h8.sh https://github.com/sergeych/hybrid8 2.3.1`

#### 2. manually build Debian package

*_Prerequisites_*:  
Debian: ```sudo apt-get install build-essential debhelper devscripts cdbs clang-3.5```  
Any ruby interpreter and `rake` gem.

Prepare v8 source tree and tools as [described here](https://github.com/v8/v8/wiki/Building-from-Source). 
Just fyi we use old [GYP](https://github.com/v8/v8/wiki/Building-with-Gyp) not newer GN.
Execute in source tree:
```
rake -f ~/v8-git-debian/Rakefile src:checkout
rake -f ~/v8-git-debian/Rakefile debian:files
```

inspect output and `debian` folder then run
```
dpkg-buildpackage -nc
```
If compilation goes well you will see something like
```
dpkg-deb: building package 'libv8-3.31-dev' in '../libv8-3.31-dev_3.31.72-2_amd64.deb'.
```
and you can install this package in Debian 7/8, maybe in Ubuntu.

<!---
##### 3. install from experimental repo

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
sudo apt-get install libv8-3.31-dev
```
-->
