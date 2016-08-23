#!/usr/bin/env bash

cp /proj/cloudincr-PG0/tools/installers/id_rsa ~/.ssh/
cp /proj/cloudincr-PG0/tools/installers/id_dsa ~/.ssh/
ssh-agent bash
ssh-add
