#!/usr/bin/fish

sudo apt-get update -y
sudo apt-get install -y wget curl axel ruby python python3 fish build-essential cmake gcc python-setuptools software-properties-common xz-utils 
curl -L http://get.oh-my.fish | fish
echo "fish" >> ~/.profile
omf install cbjohnson
