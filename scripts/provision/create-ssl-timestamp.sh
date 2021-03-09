#!/bin/bash

SSL_DAYS=$1
CURRENT_DATE=$2

if [ -z "$SSL_DAYS" ] || [ -z "$CURRENT_DATE" ]
then
    printf "Missing script argument\n"$0" <ssl_days> <ssl_expiry_date>"
    exit 1
fi

if [[ ! -f ~/.docker/certs/.SSL_timestamp ]]
then
  printf "\nCreating SSL expiry timestamp ...\n"
  SSL_EXPIRY_DATE=$(date -v+"$SSL_DAYS"d +%s)
  echo "SSL_EXPIRY_DATE="$SSL_EXPIRY_DATE > ~/.docker/certs/.SSL_timestamp
  printf "...\e[92m done \e[39m\n"
fi

exit 0