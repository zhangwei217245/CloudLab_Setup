#!/bin/bash

axel -n 10 "http://download.redis.io/releases/redis-3.2.3.tar.gz"
tar zxvf redis-3.2.3.tar.gz
rm -rf redis-3.2.3.tar.gz
DIR=`pwd`
cd redis-3.2.3; sudo make && sudo make install; cd utils; sed -e 's/\s*\([\+0-9a-zA-Z/\.]*\).*/\1/' << EOF | sudo ./install_server.sh
 6379 #port number
   # default value
 /data/redis/log/6379.log #log file address
 /data/redis/data/6379 #data file address
   # default value
   # enter pressed
EOF
cd $DIR; sudo rm -rf redis-3.2.3
