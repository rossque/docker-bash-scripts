#!/bin/bash

CWD=$1
CONTAINER=$2

if [ -z "$CWD" ] || [ -z "$CONTAINER" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

cd $CWD && docker exec $CONTAINER bash /usr/local/scripts/config-php-ini.sh $CONTAINER

exit 0