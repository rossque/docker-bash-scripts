#!/bin/bash

CWD=$1
CONTAINERS=$2

if [ -z "$CWD" ] || [ -z "$CONTAINERS" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

# Build docker containers
if [[ ! -d $CWD/src/localhost.test/public ]] && [[ ! -d $CWD/src/localhost.test/web ]]
then
  printf "\nBuilding containers ...\n"
    cd $CWD && docker rm -f $CONTAINERS 2> /dev/null && \
    docker-compose build
  printf "...\e[92m done \e[39m\n"
fi

# Build docker network
printf "Building container network ...\n"
  cd $CWD && docker-compose up -d
printf "...\e[92m done \e[39m\n"

exit 0
