#!/bin/sh

export TERM=vt100
export LANG=C

sudo cp /vagrant/sources.ru.list /etc/apt/sources.list
sudo cp /vagrant/fiamme.list /etc/apt/sources.list.d

sudo echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/99translations

curl http://debian.fiam.me/fiamme.gpg | sudo apt-key add -

apt-get update #&& apt-get -y dist-upgrade --force-yes

apt-get -y purge exim4 exim4-base exim4-config exim4-daemon-light bsd-mailx xmail

apt-get install -y \
openssl curl git gcc g++ dpkg-dev devscripts cdbs debhelper \
make autoconf bison subversion \
libssl-dev libcurl4-openssl-dev zlib1g-dev libreadline-dev \
libsqlite3-dev \
libxml2-dev libyaml-dev libxslt1-dev libgmp-dev  \
ssh tmux vim python-dev libpq-dev 

apt-get purge cpp-4.8 gcc-4.8 gcc-4.8-base libgcc-4.8-dev

sudo apt-get -y --purge autoremove

update-alternatives --set editor /usr/bin/vim

sudo -u vagrant /vagrant/user_provision.sh

