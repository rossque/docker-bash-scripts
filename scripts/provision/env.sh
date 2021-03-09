#!/bin/bash

CWD=$1
PHP=$2
NODE=$3

if [ -z "$CWD" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

if [[ ! -f $CWD/.env ]]
then

    if [ -z "$CWD" ] || [ -z "$PHP" ] || [ -z "$NODE" ]
    then
        printf "Missing script argument\n"$0" <cwd> <php> <node>"
        exit 1
    fi

printf "\nCreating environment variables ...\n"

cat > $CWD/.env << EOF
NGINX_IMAGE=nginx:alpine
COMPOSER_IMAGE=composer:latest
NODE_IMAGE=$NODE
MYSQL_IMAGE=mariadb:latest
REDIS_IMAGE=redis:latest
PHP_IMAGE=$PHP
MYSQL_DATABASE=docker
EOF

printf "...\e[92m done \e[39m\n"

fi

exit 0