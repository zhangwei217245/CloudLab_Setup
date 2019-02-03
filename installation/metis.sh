#!/bin/bash

RELEASE="metis-5.1.0.tar.gz"
DIR=`echo "$RELEASE" | sed 's/.tar.gz//g'`
axel -n 10 "http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/$RELEASE"
tar zxvf $RELEASE 
cputype=`uname -m | sed 's/\\ /_/g'`
systype=`uname -s`

cd $DIR; make config; make;
rm -rf /data/software/$DIR/*
mkdir -p /data/software/$DIR/bin
mv ./build/${systype}-${cputype}/* /data/software/$DIR/
mv ./graphs/ /data/software/$DIR/
ls -l /data/software/$DIR/programs/ | grep "\-rwx"|awk -v dir="/data/software/$DIR/programs/" '{print dir""$NF}'| while read line; do cp $line /data/software/$DIR/bin/ ; done
cd ../; rm -rf $DIR $RELEASE
