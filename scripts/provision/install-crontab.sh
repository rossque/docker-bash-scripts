#!/bin/bash

CWD=$1
CONTAINER=$2
DOMAIN=$3

if [ -z "$CWD" ] || [ -z "$CONTAINER" ] || [ -z "$DOMAIN" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

cd $CWD && docker exec $CONTAINER bash /usr/local/scripts/install-crontab.sh $DOMAIN

exit 0