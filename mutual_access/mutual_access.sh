#!/usr/bin/env bash


# This script should run in head node
while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

PRGDIR=`dirname "$PRG"`
[ -z "$PROCESSOR_HOME" ] && PROCESSOR_HOME=`cd "$PRGDIR" ; pwd`

#Absolute path to this script
SCRIPT=$(readlink -f $0)
#Absolute path this script is in
SCRIPTPATH=$(dirname $SCRIPT)


gpg -d $SCRIPTPATH/keys.tar.gz.gpg | tar xzvf -
mv dd* $SCRIPTPATH/
rm -rf ~/.ssh/id_*sa
cp /proj/cloudincr-PG0/setup/CloudLab_Setup/mutual_access/dd_rsa ~/.ssh/id_rsa
cp /proj/cloudincr-PG0/setup/CloudLab_Setup/mutual_access/dd_dsa ~/.ssh/id_dsa
rm -rf $SCRIPTPATH/dd_*
ssh-agent bash
ssh-add
