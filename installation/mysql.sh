#!/bin/bash

#axel -n 10 "http://dev.mysql.com/get/mysql-apt-config_0.7.3-1_all.deb"
#sudo dpkg -i mysql-apt-config_0.7.3-1_all.deb
sudo apt-get purge -y mysql-server mysql-client
sudo apt -y autoremove
sudo apt-get update -y
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mysql-server mysql-client 
