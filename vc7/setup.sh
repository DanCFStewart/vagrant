#!/bin/bash
# Provisioning script for setting up mysql, apache, and php on vagrant centos/7 box
# configured with 3 virtual hosts
# Author Dan Stewart onemanbanddan@gmail.com

VAGRANTDIR=/vagrant
SERVERDIR=/var/www
LOGDIR=/var/log

# add epel repo for php 7.2 on centos/7
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
# some utils
sudo yum install -y patch
sudo yum -y install wget
sudo yum install -y vim
sudo yum -y install nano
# add repo for mysql on centos/7
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
# mysql, apache, php
sudo yum update
sudo yum -q -y install mysql-server
sudo yum -q -y install httpd
sudo yum -q -y install mod_php72w
sudo yum -q -y install php72w-common
sudo yum -q -y install php72w-xml
sudo yum -q -y install php72w-opcache
sudo yum -q -y install php72w-mysql
# make directories for virtual hosts
sudo mkdir /etc/httpd/sites-available
sudo mkdir /etc/httpd/sites-enabled
sudo mkdir -p $SERVERDIR/web1/web
sudo mkdir -p $SERVERDIR/web2/web
sudo mkdir -p $SERVERDIR/web3/web
sudo mkdir -p $LOGDIR/web1
sudo mkdir -p $LOGDIR/web2
sudo mkdir -p $LOGDIR/web3
# pre create logfiles
sudo touch $LOGDIR/web1/error.log
sudo touch $LOGDIR/web1/requests.log
sudo touch $LOGDIR/web2/error.log
sudo touch $LOGDIR/web2/requests.log
sudo touch $LOGDIR/web3/error.log
sudo touch $LOGDIR/web3/requests.log
# set SELinux context for logs
sudo chcon system_u:object_r:httpd_log_t:s0 $LOGDIR/web1/error.log
sudo chcon system_u:object_r:httpd_log_t:s0 $LOGDIR/web1/requests.log
sudo chcon system_u:object_r:httpd_log_t:s0 $LOGDIR/web2/error.log
sudo chcon system_u:object_r:httpd_log_t:s0 $LOGDIR/web2/requests.log
sudo chcon system_u:object_r:httpd_log_t:s0 $LOGDIR/web3/error.log
sudo chcon system_u:object_r:httpd_log_t:s0 $LOGDIR/web3/requests.log
# allow NFS for content
sudo setsebool -P httpd_use_nfs=1
# copy apache conf files
sudo cp $VAGRANTDIR/httpd.conf /etc/httpd/conf/
sudo cp $VAGRANTDIR/web1.conf /etc/httpd/sites-available/
sudo cp $VAGRANTDIR/web2.conf /etc/httpd/sites-available/
sudo cp $VAGRANTDIR/web3.conf /etc/httpd/sites-available/
# create symlinks to enable
sudo ln -s /etc/httpd/sites-available/web1.conf /etc/httpd/sites-enabled/web1.conf
sudo ln -s /etc/httpd/sites-available/web2.conf /etc/httpd/sites-enabled/web2.conf
sudo ln -s /etc/httpd/sites-available/web3.conf /etc/httpd/sites-enabled/web3.conf
sudo systemctl restart httpd.service
sudo systemctl enable httpd.service
# copy the initial web pages
cp -n $VAGRANTDIR/vc7_initial/web1/index.html $SERVERDIR/web1/web/
cp -n $VAGRANTDIR/vc7_initial/web2/index.html $SERVERDIR/web2/web/
cp -n $VAGRANTDIR/vc7_initial/web3/index.php $SERVERDIR/web3/web/
