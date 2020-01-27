#!/bin/bash

formatNmountDev () {
	TGTDEV=$1
	USER=$2
	GROUP=$3

	MOUNTPOINT=/data
	if [ -z $MOUNTPOINT ];then
		MOUNTPOINT=/data
	else
		MOUNTPOINT=$4
	fi
	
	if [ -n "${TGTDEV}" ]; then
		#fuser -km $MOUNTPOINT
		umount -f $MOUNTPOINT
		sed -i.bak '/'"$TGTDEV"'/d' /etc/fstab
		yes | mkfs -t ext4 /dev/$TGTDEV
		echo "============= Mounting device $TGTDEV   on $MOUNTPOINT ======== "
		mkdir -p $MOUNTPOINT
		echo "/dev/$TGTDEV    $MOUNTPOINT   ext4    defaults     0        2" >> /etc/fstab
		mount -a
		mkdir -p $MOUNTPOINT/software
		chown -R ${USER}:${GROUP} $MOUNTPOINT
	fi
}


USER=`whoami`
GROUP=`groups | awk '{print $1}'`

# check to see if re_mount_all is needed
re_mount_all=0

if [[ $1 -eq 1 ]]; then
	re_mount_all=1
fi

#check for root user
if [ "$(id -u)" -ne 0 ] ; then
	echo "You must run this script as root. Sorry!"
	exit 1
fi

system_par=`df -h | egrep -e "/$" | awk '{print $1}'`

#umount all /dev/sd* devices that are mounted as /data*
if [[ $re_mount_all -eq 1 ]]; then
	df -h |  grep "/dev/sd" | grep "/data" | grep -v ${system_par} | awk '{print $NF}' | while read line; do 
		umount -f ${line}
	done
fi

dev_mounted=(`df -h | grep "/dev/sd" |grep -v ${system_par} | awk '{print $1}'`)
system_disk=`echo ${system_par}|sed 's/[0-9]//g'`

ls -l /dev/sd*|grep -v ${system_par}| awk '{print $NF}'| while read line;
do 
	dev_skip=0; 
	for dev in "${dev_mounted[@]}"; 
	do 
		if [[ "${dev}" == "${line}" ]]; 
		then 
			dev_skip=1; 
			break; 
		fi; 
	done; 

	is_large_disk=`fdisk -l ${line} | grep "Disk /dev/sd" | awk '{if($5/1024/1024/1024 >= 120){print "1"}else{print "0"}}'`

	if [[ ${is_large_disk} -eq 0 ]]; then
		dev_skip=1;
	fi
	if [[ " $line " == " ${system_disk} " ]];then
		dev_skip=1;
	fi
	if [[ $dev_skip -eq 0  ]];
	then 
		dev_name=`echo $line | awk -F '/' '{print $NF}'`
		echo ${line}
		formatNmountDev ${dev_name} ${USER} ${GROUP} /data_${dev_name}	
	fi; 
done
