#!/usr/bin/env bash

count=$1
bound=`expr $count - 1`


if [ "HOSTS" = $2 ]; then
	for i in $(seq 0 $bound)
	do
		ssh-keyscan node-$i >> ~/.ssh/known_hosts
	done
fi

# PUT file 
if [ "PUT" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo PUT Node-$(($bound - $i))
    	scp -r $3 node-$(($bound - $i)):$4
	done
fi

# RM
if [ "RM" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo RM Node-$(($bound - $i))
    	ssh node-$(($bound - $i)) "rm -r $3"
	done
fi

# CMD 
if [ "CMD" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo CMD Node-$(($bound - $i))
    	ssh node-$(($bound - $i)) "$3" &
	done
fi
# TTY 
if [ "TTY" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo TTY Node-$(($bound - $i))
    	ssh -t node-$(($bound - $i)) "$3" 
	done
fi

# SNTP
if [ "SNTP" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo SNTP Node-$(($bound - $i))
    	ssh -t node-$(($bound - $i)) "sudo sntp -s 24.56.178.140" &
	done
fi

# JPS
if [ "JPS" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo JPS Node-$(($bound - $i))
    	ssh -t node-$(($bound - $i)) "jps"
	done
fi

# PS
if [ "PS" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo PS Node-$(($bound - $i))
    	ssh -t node-$(($bound - $i)) "ps -ef | grep $3 | grep -v grep"
	done
fi

# File Limits
if [ "LIMIT" = $2 ]; then
	for i in $(seq 0 $bound)
	do
		echo Increase File Open Limit on Node-$(($bound - $i))
		ssh -t node-$(($bound - $i)) "sudo cp /proj/cloudincr-PG0/setup/CloudLab_Setup/ulimit/limits.conf /etc/security/limits.conf; sudo echo 'session required pam_limits.so' >> /etc/pam.d/common-session; ulimit -a; sudo shutdown -r now"
	done
fi
