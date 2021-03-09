#!/bin/bash

CWD=$1
CONTAINERS=$2

if [ -z "$CWD" ] || [ -z "$CONTAINERS" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

printf "\nRestarting services ...\n"
cd $CWD && docker restart $CONTAINERS
printf "...\e[92m done \e[39m\n"

exit 0
