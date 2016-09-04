#!/bin/bash

PROJNAME=`groups|awk '{print $1}'`

RELEASE="redis-3.2.3.tar.gz"
REDIS=`echo $RELEASE| sed 's/.tar.gz//g'`

mkdir -p /data/software
axel -n 10 "http://download.redis.io/releases/$RELEASE"
tar zxvf $RELEASE 
rm -rf $RELEASE 
cat /proj/${PROJNAME}/setup/CloudLab_Setup/installation/redis_conf/redis.conf > $REDIS/redis.conf
sudo mkdir -p /var/run/redis
sudo touch /var/run/redis/redis.sock
DIR=`pwd`
cd $REDIS; sudo make && sudo make install; cd utils; sed -e 's/\s*\([\+0-9a-zA-Z/\.]*\).*/\1/' << EOF | sudo ./install_server.sh
 6379 #port number
   # default value
 /data/software/redis/log/6379.log #log file address
 /data/software/redis/data/6379 #data file address
   # default value
   # enter pressed
EOF
sudo rm -rf $DIR/$REDIS
redis-cli info
