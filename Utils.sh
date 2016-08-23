#!/usr/bin/env bash

bound=`expr $1 - 1`


# PUT file 
if [ "PUT" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo SOURCE Node-$i
    	scp -r $3 node-$i:$4
	done
fi

# RM
if [ "RM" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo RM Node-$i
    	ssh node-$i "rm -r $3"
	done
fi

# CMD 
if [ "CMD" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo CMD Node-$i
    	ssh node-$i "$3" &
	done
fi
# TTY 
if [ "TTY" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo CMD Node-$i
    	ssh -t node-$i "$3" 
	done
fi

# SNTP
if [ "SNTP" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo SNTP Node-$i
    	ssh -t node-$i "sudo sntp -s 24.56.178.140" &
	done
fi

# JPS
if [ "JPS" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo JPS Node-$i
    	ssh -t node-$i "jps"
	done
fi

# PS
if [ "PS" = $2 ]; then
	for i in $(seq 0 $bound)
	do
    	echo PS Node-$i
    	ssh -t node-$i "ps -ef | grep $3 | grep -v grep"
	done
fi

# File Limits
if [ "LIMIT" = $2 ]; then
	for i in $(seq 0 $bound)
	do
		echo Increase File Open Limit on Node-$i
		ssh -t node-$i "sudo cp ulimit/limits.conf /etc/security/limits.conf"
	done
fi
