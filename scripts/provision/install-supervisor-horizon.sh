#!/bin/bash

CWD=$1
CONTAINER=$2
DOMAIN=$3

if [ -z "$CWD" ] || [ -z "$CONTAINER" ] || [ -z "$DOMAIN" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

if [[ -f $CWD/src/$DOMAIN/composer.json ]]
then
  if grep -q "laravel" $CWD/src/$DOMAIN/composer.json
  then
    cd $CWD && docker exec $CONTAINER bash /usr/local/scripts/install-supervisor-horizon.sh
  fi
fi

exit 0