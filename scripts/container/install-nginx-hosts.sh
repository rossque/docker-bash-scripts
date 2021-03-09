#!/bin/bash

IP=$1
SERVER=$2
DOMAIN=$3

if [ -z "$IP" ] || [ -z "$SERVER" ] || [ -z "$DOMAIN" ]
then
    printf "Missing script arguments\n"$0" <ip> <server>"
    exit 1
fi

echo "$IP $DOMAIN" >> /etc/hosts
printf "Adding $IP $DOMAIN ($SERVER)...\n"

exit 0