#!/bin/bash

TGTDEV=$1
USER=`whoami`
GROUP=`groups | awk '{print $1}'`

ls -l /dev/sd*| awk '{print $NF}'| while read line; do dev_skip=0; for dev in "${dev_mounted[@]}"; do  if [[ "${dev}" == "${line}" ]]; then dev_skip=1; break; fi; done; if [[ dev_skip -eq 0  ]];then echo $line;fi; done

exit;


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

