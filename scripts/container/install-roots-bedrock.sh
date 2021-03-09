#!/bin/bash

DOMAIN=$1

if [ -z "$DOMAIN" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

printf "\nInstalling Bedrock (Wordpress) ...\n"

  rm -rf /var/www/html/$DOMAIN/* && \
  cd /var/www/html/$DOMAIN/ && \
  composer create-project --prefer-dist roots/bedrock ./ && \
  ln -s /var/www/html/$DOMAIN/web /var/www/html/$DOMAIN/public && \
  sed -i 's/DB_NAME=.*/DB_NAME=docker/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/DB_USER=.*/DB_USER=root/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=password/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/# DB_HOST/DB_HOST/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/DB_HOST=.*/DB_HOST=mysql/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/WP_HOME=.*/WP_HOME=https\:\/\/localhost\.test/g' /var/www/html/$DOMAIN/.env && \
  rm -rf /var/www/html/$DOMAIN/.env.example

printf "...\e[92m done \e[39m\n"

exit 0
