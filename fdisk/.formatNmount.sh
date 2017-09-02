#!/bin/bash

#check for root user
if [ "$(id -u)" -ne 0 ] ; then
	echo "You must run this script as root. Sorry!"
	exit 1
fi

TGTDEV=$1
USER=$2
GROUP=$3

MOUNTPOINT=/data
if [ -n $MOUNTPOINT ];then
MOUNTPOINT=$4
fi

if [ -z $TGTDEV ];then
echo "Among all the following partitions, which one do you want to format?"
ls /dev/ |  grep sd
read TGTDEV
fi

if [ -n "${TGTDEV}" ]; then
	#fuser -km $MOUNTPOINT
	umount -f $MOUNTPOINT
	sed -i.bak '/'"$TGTDEV"'/d' /etc/fstab
	yes | mkfs -t ext3 /dev/$TGTDEV	
	echo "Mounting device on /data"
	mkdir -p $MOUNTPOINT
	echo "/dev/$TGTDEV    $MOUNTPOINT   ext3    defaults     0        2" >> /etc/fstab
	mount -a
	mkdir -p $MOUNTPOINT/software
	chown -R ${USER}:${GROUP} $MOUNTPOINT
	exit
fi
exit
