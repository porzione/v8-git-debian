#!/bin/sh

TERM=xterm-256color
LANG=C
DEBIAN_FRONTEND=noninteractive

sudo cp /vagrant/sources.list /etc/apt/sources.list

sudo echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/99translations

# sudo cp /vagrant/fiamme.list /etc/apt/sources.list.d
# curl http://debian.fiam.me/fiamme.gpg | sudo apt-key add -

apt-get update #&& apt-get -y dist-upgrade --force-yes

apt-get -y purge exim4 exim4-base exim4-config exim4-daemon-light bsd-mailx xmail installation-report reportbug pinentry-gtk2 apt-listchanges python-reportbug avahi-daemon cpp-4.8 gcc-4.8 gcc-4.8-base libgcc-4.8-dev
sudo apt-get -y --purge autoremove

apt-get install -y \
openssl curl wget git build-essential devscripts cdbs debhelper sudo vim \
autoconf bison subversion \
libssl-dev libcurl4-openssl-dev zlib1g-dev libreadline-dev libffi-dev zlib1g-dev \
libsqlite3-dev libpq-dev \
libxml2-dev libyaml-dev libxslt1-dev libgmp-dev libexpat1-dev python-dev

update-alternatives --set editor /usr/bin/vim.basic

sudo -u vagrant cp -a /vagrant/home/ /home/vagrant
sudo -iu vagrant /vagrant/build_rubies.sh
sudo -iu vagrant /vagrant/build_v8.sh
