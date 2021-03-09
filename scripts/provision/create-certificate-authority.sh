#!/bin/bash

SSL_DAYS_DIFF=$1
SSL_DAYS_LEFT=$2

if [ -z "$SSL_DAYS_DIFF" ] || [ -z "$SSL_DAYS_LEFT" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

deleteCertificate(){
  printf "\nDeleting old certificate for $1\n"
  hashes=$(security find-certificate -c "$1" -a -Z|grep SHA-1|awk '{ print $NF }')
  for hash in $hashes; do
      sudo security delete-certificate -Z $hash
  done
  printf "...\e[92m done \e[39m\n"
}

# Create Certificate Authority
if [[ ! -f ~/.docker/certs/ca.pem ]] || [ "$SSL_DAYS_DIFF" -le $SSL_DAYS_LEFT ]
then

    printf "\nCreating SSL certificate Authority (password required) ...\n"

    deleteCertificate "Localhost (Docker) CA Self Signed CN"

    SSL_EXPIRY_DATE=$(date -v+"$SSL_DAYS"d +%s)
    echo "SSL_EXPIRY_DATE="$SSL_EXPIRY_DATE > ~/.docker/certs/.SSL_timestamp

    openssl genrsa -out ~/.docker/certs/ca.key 2048 && \
    openssl req -x509 -new -subj "/C=US/ST=California/L=San Francisco Bay Area/O=Localhost (Docker) CA Self Signed Organization/OU=Developers/CN=Localhost (Docker) CA Self Signed CN" -nodes -key ~/.docker/certs/ca.key -sha256 -days $SSL_DAYS -out ~/.docker/certs/ca.pem && \
    sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" ~/.docker/certs/ca.pem

    printf "...\e[92m done \e[39m\n"

fi

exit 0