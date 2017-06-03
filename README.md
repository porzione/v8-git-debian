Debian packaging for google V8 library version 3.x, work in progress.
===========

#### There are 3 ways to build and/or install libv8

#### 1. manually build Debian package

*_Prerequisites_*:  
Debian: ```sudo apt-get install build-essential debhelper devscripts cdbs clang-3.5```  
Any ruby interpreter and `rake` gem.

Prepare v8 source tree and tools as [described here](https://github.com/v8/v8/wiki/Building-from-Source). 
Just FYI we use old [GYP](https://github.com/v8/v8/wiki/Building-with-Gyp) not newer GN as in native Debian package.
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
and you can install this package in Debian 7/8

#### 2. auto build Debian package in Vagrant/Debian

prepare vagrant box, you can try other boxes

```
vagrant box add debian87 https://atlas.hashicorp.com/bento/boxes/debian-8.7/versions/2.3.4/providers/virtualbox.box

```
scripts called by `vagrant provision`:

`provision.sh` install all dev dependencies  
`user_provision.sh` install rbenv and ruby for vagrant user

user scripts, located in /vagrant inside the box:

`build_v8.sh` build v8 Debian package, consider to run the larger box with `VBOX=LARGE vagrant up` with real nproc cpu count and 8 GB RAM  
`build_h8.sh` build hybrid8 ruby gem 

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
