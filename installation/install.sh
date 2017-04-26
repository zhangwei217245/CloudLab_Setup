#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y wget curl axel ruby python python3 fish build-essential cmake gcc python-setuptools software-properties-common xz-utils docker.io docker-registry docker-compose docker-doc docker

service docker stop
sleep 3s
mkdir -p /data/software/docker ; mv /var/lib/docker/* /data/software/; rm -rf /var/lib/docker
ln -s /data/software/docker /var/lib/docker
service docker start

echo "fish" >> ~/.profile
curl -L http://get.oh-my.fish > installomf
fish installomf --noninteractive
rm -rf installomf
