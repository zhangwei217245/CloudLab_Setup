#!/bin/bash

echo "======= NOTICE: NO NEED TO PARTITION, JUST FORMAT AND MOUNT. ========"
TGTDEV="nvme0n1p4"
USER=`whoami`
GROUP=`groups | awk '{print $1}'`

#Absolute path to this script
SCRIPT=$(readlink -f $0)
#Absolute path this script is in
SCRIPTPATH=$(dirname $SCRIPT)

sudo bash ${SCRIPTPATH}/.formatNmount.sh $TGTDEV $USER $GROUP
df -h

echo "======= NOTICE: YOU ARE ALL SET!!!!! ========"
