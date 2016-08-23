#!/bin/bash

#check for root user
if [ "$(id -u)" -ne 0 ] ; then
	echo "You must run this script as root. Sorry!"
	exit 1
fi

echo "Among all the following partitions, which one do you want to format?"
ls /dev/ |  grep sd
read TGTDEV
if [ -n "${TGTDEV}" ]; then
	mkfs -t ext3 $TGTDEV	
fi

echo "Mounting device on /data"
mkdir -p /data
echo "$TGTDEV    /data   ext3    defaults     0        2" >> /etc/fstab
mount -a
chown -R daidong:cloudincr-PG0 /data
su daidong
mkdir -p /data/software
