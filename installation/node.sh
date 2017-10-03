#!/usr/bin/env bash

sudo rm -rf /usr/bin/node /usr/bin/npm
sudo rm -rf /usr/include/node
sudo rm -rf /usr/lib/node_modules
sudo rm -rf /usr/share/doc/node
sudo rm -rf /usr/share/man/man1/node.1
sudo rm -rf /usr/share/systemtap/tapset/node.stp
ARCH=$1
VALIDARCH="armv6l|armv7l|arm64|x86|x64"
VALIDARCHLIST=`echo ${VALIDARCH}| sed 's/[|]/ /g'`
if [ -n "$ARCH" ]; then
	if [[ $VALIDARCHLIST =~ $1 ]]; then
		mkdir -p /data/software
		VERSION="v8.6.0"
		RELEASE="node-${VERSION}-linux-${ARCH}.tar.xz"
		NODEARM=`echo $RELEASE| sed 's/.tar.xz//g'`
		rm -rf /data/software/${NODEARM}*
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
		node -v
		npm -v
		exit;
	fi
	echo "Only support these architectures:(armv6l|armv6l|arm64|x86|x64)"
fi
