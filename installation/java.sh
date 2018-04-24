#!/bin/bash

sudo add-apt-repository -y ppa:webupd8team/java 
sudo add-apt-repository -y ppa:linuxuprising/java
sudo apt-get update -y
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
echo "oracle-java9-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
echo "oracle-java10-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install -y oracle-java10-installer oracle-java9-installer oracle-java8-installer ant maven gradle
java -version
javac -version
ant -v
mvn -v
gradle -v
