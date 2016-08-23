#!/bin/bash

axel -n 10 "http://www.trieuvan.com/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz"
tar zxf apache-maven-3.3.9-bin.tar.gz
MAVEN="apache-maven-3.3.9"
CURDIR=`pwd`
echo "MAVEN_HOME=$CURDIR/$MAVEN" >> ~/.bashrc
echo 'PATH=$PATH:$MAVEN_HOME/bin' >> ~/.bashrc
rm -rf apache-maven-3.3.9-bin.tar.gz
