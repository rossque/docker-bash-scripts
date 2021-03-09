#!/bin/bash

MYSQL_DATABASE=$1

if [ -z "$MYSQL_DATABASE" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

# Print credentials
printf "\n"

printf "=============================\n"
printf "Domains\n"
printf "=============================\n"
printf "https://localhost.test\n"
printf "https://api.localhost.test\n"

printf "\n"

printf "=============================\n"
printf "Database\n"
printf "=============================\n"
printf "Name:               $MYSQL_DATABASE\n"
printf "Host:               127.0.0.1\n"
printf "Port:               4306\n"
printf "Username:           root\n"
printf "Password:           password\n"

printf "\n"

printf "=============================\n"
printf "Redis\n"
printf "=============================\n"
printf "Host:               127.0.0.1\n"
printf "Port:               6379\n"
printf "Password:           password\n\n"

exit 0