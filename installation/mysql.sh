#!/bin/bash

axel -n 10 "http://dev.mysql.com/get/mysql-apt-config_0.7.3-1_all.deb"
sudo dpkg -i mysql-apt-config_0.7.3-1_all.deb
sudo apt-get update -y
sudo apt-get install -y mysql-server mysql-client mysql-common libmysqlclient20 mysql-workbench-community mysql-connector-python-py3 mysql-connector-python mysql-utilities mysql-router
