#!/bin/bash

DOMAIN=$1

if [ -z "$DOMAIN" ]
then
    printf "Missing script argument\n"$0" <domain>"
    exit 1
fi

if ! grep -q $DOMAIN /etc/hosts
then

    printf "\nAdding new host to /etc/hosts (sudo password required)!\n"
    printf "If you don't want to enter your password, create this host manually using 'sudo vi /etc/hosts'.\n\n"
    printf "127.0.0.1 $DOMAIN\n"
    sudo sh -c "echo '\n# Added for docker development\n127.0.0.1 $DOMAIN' >> /etc/hosts"
    printf "...\e[92m done \e[39m\n"

fi

exit 0