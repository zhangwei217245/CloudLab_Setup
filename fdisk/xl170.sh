#!/bin/bash

echo "======= NOTICE: NO NEED TO PARTITION, JUST FORMAT AND MOUNT. ========"
TGTDEV="sda4"
bash formatNmount.sh $TGTDEV
df -h

echo "======= NOTICE: YOU ARE ALL SET!!!!! ========"
