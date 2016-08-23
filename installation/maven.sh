#!/bin/bash

MAJORVER="3"
VERSION="${MAJORVER}.3.9"
RELEASE="apache-maven-${VERSION}-bin.tar.gz"
MAVEN=`echo "$RELEASE" | sed 's/-bin.tar.gz//g'`
axel -n 10 "http://www.trieuvan.com/apache/maven/maven-${MAJORVER}/${VERSION}/binaries/${RELEASE}"
tar zxf $RELEASE
CURDIR=`pwd`
echo "MAVEN_HOME=$CURDIR/$MAVEN" >> ~/.profile
echo 'PATH=$PATH:$MAVEN_HOME/bin' >> ~/.profile
rm -rf $RELEASE 
