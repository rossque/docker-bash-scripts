#!/bin/bash

CWD=$1
CONTAINER=$2

if [ -z "$CWD" ] || [ -z "$CONTAINER" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

read -p "Do you want to SSH into your PHP container [y/n]?" CONT
if [ "$CONT" = "y" ]; then
  printf "...\e[92m done \e[39m\n\n"
  cd $CWD && docker exec -it $CONTAINER bash && exit 0
fi

exit 0