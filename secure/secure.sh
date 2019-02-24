#!/bin/bash

ls -l --color=never /users/ | grep -v "total"|egrep -v "($(whoami)|geniuser)"|awk '{print "/users/"$NF}'|sudo xargs rm -rf

