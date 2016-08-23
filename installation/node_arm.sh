#!/bin/bash

sudo rm -rf /usr/bin/node /usr/bin/npm
sudo rm -rf /usr/include/node
sudo rm -rf /usr/lib/node_modules
sudo rm -rf /usr/share/doc/node
sudo rm -rf /usr/share/man/man1/node.1
sudo rm -rf /usr/share/systemtap/tapset/node.stp
if [ "x$1" = "xinstall" ]; then
mkdir -p /data/software
VERSION="v6.4.0"
RELEASE="node-v6.4.0-linux-arm64.tar.xz"
NODEARM=`echo $RELEASE| sed 's/.tar.xz//g'`
axel -n 10 "https://nodejs.org/dist/$VERSION/$RELEASE"
tar xf $RELEASE 
rm -rf $RELEASE
mv $NODEARM /data/software
CURDIR="/data/software"
sudo ln -s $CURDIR/$NODEARM/bin/* /usr/bin/
sudo ln -s $CURDIR/$NODEARM/include/* /usr/include/
sudo ln -s $CURDIR/$NODEARM/lib/* /usr/lib/
sudo ln -s $CURDIR/$NODEARM/share/doc/* /usr/share/doc/
sudo ln -s $CURDIR/$NODEARM/share/man/man1/* /usr/share/man/man1/
sudo ln -s $CURDIR/$NODEARM/share/systemtap/tapset/* /usr/share/systemtap/tapset/
fi
