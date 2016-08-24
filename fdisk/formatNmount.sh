#!/bin/bash

#check for root user
if [ "$(id -u)" -ne 0 ] ; then
	echo "You must run this script as root. Sorry!"
	exit 1
fi

TGTDEV=$1
if [ -z $TGTDEV ];then
echo "Among all the following partitions, which one do you want to format?"
ls /dev/ |  grep sd
read TGTDEV
fi

if [ -n "${TGTDEV}" ]; then
	fuser -km /data
	umount -f /data
	sed -i.bak '/'"$TGTDEV"'/d' /etc/fstab
	yes | mkfs -t ext3 /dev/$TGTDEV	
	echo "Mounting device on /data"
	mkdir -p /data
	echo "/dev/$TGTDEV    /data   ext3    defaults     0        2" >> /etc/fstab
	mount -a
	mkdir -p /data/software
	chown -R daidong:cloudincr-PG0 /data
	exit
fi
exit
