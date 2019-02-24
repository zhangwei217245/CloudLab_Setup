#!/bin/bash

CURRENT_USER=`users`

ls -l /users | grep -v "total"|egrep -v "(${CURRENT_USER}|geniuser)"| awk '{print $NF}'| xargs rm -rf
