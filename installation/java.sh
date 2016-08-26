#!/bin/bash

sudo add-apt-repository -y ppa:webupd8team/java 
sudo apt-get update -y
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer
java -version
javac -version
