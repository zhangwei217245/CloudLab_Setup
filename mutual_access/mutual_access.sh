#!/usr/bin/env bash

gpg -d keys.tar.gz.gpg | tar xzvf -
rm -rf ~/.ssh/id_*sa
cp /proj/cloudincr-PG0/tools/installers/dd_rsa ~/.ssh/id_rsa
cp /proj/cloudincr-PG0/tools/installers/dd_dsa ~/.ssh/id_dsa
rm -rf dd_*
ssh-agent bash
ssh-add
