#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y wget curl axel ruby python python3 fish build-essential cmake gcc python-setuptools software-properties-common xz-utils docker.io docker-compose docker-doc docker

service docker stop
sleep 3s
mkdir -p /data/software/docker ; mv /var/lib/docker/* /data/software/; rm -rf /var/lib/docker
ln -s /data/software/docker /var/lib/docker
service docker start
sudo usermod -a -G docker zhang56

echo "fish" >> ~/.profile
curl -L http://get.oh-my.fish > installomf
fish installomf --noninteractive
rm -rf installomf
echo "omf install cbjohnson" | fish
