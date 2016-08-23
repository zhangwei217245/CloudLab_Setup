#!/bin/bash

#check for root user
if [ "$(id -u)" -ne 0 ] ; then
	echo "You must run this script as root. Sorry!"
	exit 1
fi
# refer to : http://superuser.com/questions/332252/creating-and-formating-a-partition-using-a-bash-script
# to create the partitions programatically (rather than manually)
# we're going to simulate the manual input to fdisk
# The sed script strips off all the comments so that we can 
# document what we're doing in-line with the actual commands
# Note that a blank line (commented as "defualt" will send a empty
# line terminated with a newline to take the fdisk default.

TGTDEV=$1
if [ -z $TGTDEV ];then
echo "Among all the following partitions, which one is your targeted device?"
ls /dev/ |  grep sd
read TGTDEV
fi
if [ -n "${TGTDEV}" ]; then
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/${TGTDEV}
  n # new partition
    # default partition number 2
    # default - start at beginning of residual space 
    # default - end of the residual space 
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF
shutdown -r now
fi
