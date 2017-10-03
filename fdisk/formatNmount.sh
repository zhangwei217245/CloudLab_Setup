#!/bin/bash

TGTDEV=$1
USER=`whoami`
GROUP=`groups | awk '{print $1}'`

MOUNTPOINT="/data"

if [ -z $2 ];then
	MOUNTPOINT=/data
else
	MOUNTPOINT=$2
fi


echo "Device $TGTDEV will be mounted to $MOUNTPOINT"

if [ -z $TGTDEV ];then
echo "Among all the following partitions, which one do you want to format?"
ls /dev/ |  egrep "(sd|nvme0n1p)"
read TGTDEV
fi

#Absolute path to this script
SCRIPT=$(readlink -f $0)
#Absolute path this script is in
SCRIPTPATH=$(dirname $SCRIPT)

sudo bash ${SCRIPTPATH}/.formatNmount.sh $TGTDEV $USER $GROUP $MOUNTPOINT

