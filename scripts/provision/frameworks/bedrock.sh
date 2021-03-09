#!/bin/bash

CWD=$1
CONTAINER=$2
DOMAIN=$3

if [ -z "$CWD" ] || [ -z "$CONTAINER" ] || [ -z "$DOMAIN" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

if [[ ! -d $CWD/src/$DOMAIN/web ]]
then
    cd $CWD && docker exec $CONTAINER bash /usr/local/scripts/install-roots-bedrock.sh $DOMAIN
fi

exit 0