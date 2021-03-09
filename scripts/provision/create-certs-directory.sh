#!/bin/bash

# Create /certs directory
if [[ ! -d ~/.docker/certs ]]
then

    printf "\nCreating certs directory ...\n"
    mkdir ~/.docker/certs
    printf "...\e[92m done \e[39m\n"

fi

exit 0