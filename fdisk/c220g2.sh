#!/bin/bash


echo "======= NOTICE: NO NEED TO PARTITION, JUST FORMAT AND MOUNT. ========"

USER=`whoami`
GROUP=`groups | awk '{print $1}'`

#Absolute path to this script
SCRIPT=$(readlink -f $0)
#Absolute path this script is in
SCRIPTPATH=$(dirname $SCRIPT)


echo "format SSD first"


sudo bash ${SCRIPTPATH}/.formatNmount.sh sdc $USER $GROUP /data

echo "format HDD then"

sudo bash ${SCRIPTPATH}/.formatNmount.sh sda4 $USER $GROUP /data1

echo "format another HDD then"

sudo bash ${SCRIPTPATH}/.formatNmount.sh sdb $USER $GROUP /data2

df -h

echo "======= NOTICE: YOU ARE ALL SET!!!!! ========"


