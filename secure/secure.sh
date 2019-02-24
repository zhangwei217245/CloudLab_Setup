#!/bin/bash

CURRENT_USER=`users`

ls -l --color=never /users/ | grep -v "total"|egrep -v "(${CURRENT_USER}|geniuser)"|awk '{print "/users/"$NF}'|xargs rm -rf

