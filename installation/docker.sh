#!/bin/bash


ARCH=$1

if [ -z "$1" ]
  then
    ARCH="amd64"
fi



curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=${ARCH}] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  
sudo apt-get update -y 
sudo apt-get install docker-ce docker-ce-cli containerd.io


service docker stop
sleep 3s
mkdir -p /data/software/lib/docker ; mv /var/lib/docker/* /data/software/lib/docker/; rm -rf /var/lib/docker
sudo ln -s /data/software/lib/docker /var/lib/docker
service docker start
sudo usermod -a -G docker zhang56
