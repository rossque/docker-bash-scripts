#!/bin/bash

CWD=$1
CONTAINER=$2
DOMAIN=$3

if [ -z "$CWD" ] || [ -z "$CONTAINER" ] || [ -z "$DOMAIN" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx);
printf "\nUpdating host files ...\n"
cd $CWD && docker exec $CONTAINER bash /usr/local/scripts/install-nginx-hosts.sh $IP $CONTAINER $DOMAIN
printf "...\e[92m done \e[39m\n"

exit 0