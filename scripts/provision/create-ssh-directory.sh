#!/bin/bash

CWD=$1

if [ -z "$CWD" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

if [[ ! -d $CWD/config/ssh ]]
then

  printf "\nCreating ssh config directory ...\n"
    mkdir config/ssh
  printf "...\e[92m done \e[39m\n"

fi

exit 0