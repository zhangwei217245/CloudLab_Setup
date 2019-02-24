#!/bin/bash


ls -l --color=never /users/ | grep -v "total"|egrep -v "($(users)|geniuser)"|awk '{print "/users/"$NF}'|sudo xargs rm -rf

