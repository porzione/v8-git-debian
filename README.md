Debian packaging for latest google V8 library
===========

**Don't use built packages in production, please. For testing purposes only.**

**amd64 only (google calls this x64)**

### in short

You need debian stuff: build-essential, debhelper, cdbs, etc.
And you need ruby and rake.

Prepare v8 source tree and tools as described [here] (https://code.google.com/p/v8-wiki/wiki/UsingGit).
Also will be helpful [this page] (https://code.google.com/p/v8-wiki/wiki/BuildingWithGYP).

In source tree run 

```
rake -f ~/prog/v8deb/Rakefile src:checkout
rake -f ~/prog/v8deb/Rakefile debian:files
```

inspect output and `debian` folder. If everything is ok then run

```
dpkg-buildpackage -nc
```

### vagrant scripts

prepare vagrant box

`vagrant box add debian77 http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_debian-7.7_chef-provisionerless.box`

scripts called by `vagrant provision`

`provision.sh` install all dev dependencies
`user_provision.sh` install rbenv and ruby for vagrant user

user scripts, located in /vagrant inside the box

`build_v8.sh` build v8 debian package, consider to run the larger box with `VBOX=LARGE vagrant up` with real nproc cpu count and 8 GB RAM
`build_h8.sh` build hybrid8 ruby gem` 


