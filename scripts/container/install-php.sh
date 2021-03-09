#!/bin/bash

DOMAIN=$1

if [ -z "$DOMAIN" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

if [[ ! -d /var/www/html/$DOMAIN/public ]]
then
    printf "\nCreating public directory ...\n"
    mkdir -p /var/www/html/$DOMAIN/public && \
    echo '<?php phpinfo();' > /var/www/html/$DOMAIN/public/index.php
    printf "...\e[92m done \e[39m\n"
fi

exit 0