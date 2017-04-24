#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y wget curl axel ruby python python3 fish build-essential cmake gcc python-setuptools software-properties-common xz-utils docker.io docker-registry docker-compose docker-doc docker
echo "fish" >> ~/.profile
curl -L http://get.oh-my.fish > installomf
fish installomf --noninteractive
rm -rf installomf
