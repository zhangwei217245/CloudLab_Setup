#!/bin/bash


ARCH=$1

if [ -z "$1" ]
  then
    ARCH="x86_64"
fi

sudo apt-get remove docker docker-engine docker.io containerd runc


curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=${ARCH}] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  
sudo apt-get update -y 
sudo apt-get install -y docker-ce docker-ce-cli containerd.io


sudo service docker stop
sleep 3s
sudo mkdir -p /data/software/lib/docker ; sudo mv /var/lib/docker/* /data/software/lib/docker/; sudo rm -rf /var/lib/docker
sudo ln -s /data/software/lib/docker /var/lib/docker
sudo service docker start
sudo usermod -a -G docker zhang56
