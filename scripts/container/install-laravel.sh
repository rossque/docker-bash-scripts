#!/bin/bash

DOMAIN=$1

if [ -z "$DOMAIN" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

printf "\nInstalling Laravel ...\n"

  rm -rf /var/www/html/$DOMAIN/* && \
  cd /var/www/html/$DOMAIN/ && \
  composer create-project --prefer-dist laravel/laravel ./ && \
  sed -i 's/APP_URL=.*/APP_URL=https\:\/\/localhost\.test/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/DB_HOST=.*/DB_HOST=mysql/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/DB_DATABASE=.*/DB_DATABASE=docker/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/DB_USERNAME=.*/DB_USERNAME=root/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=password/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/BROADCAST_DRIVER=.*/BROADCAST_DRIVER=redis/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/QUEUE_CONNECTION=.*/QUEUE_CONNECTION=redis/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/SESSION_DRIVER=.*/SESSION_DRIVER=redis/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/REDIS_HOST=.*/REDIS_HOST=redis/g' /var/www/html/$DOMAIN/.env && \
  sed -i 's/REDIS_PASSWORD=.*/REDIS_PASSWORD=password/g' /var/www/html/$DOMAIN/.env

  cd /var/www/html/$DOMAIN/ && \
  composer require predis/predis && \
  composer require laravel/horizon && \
  composer require laravel/slack-notification-channel && \
  php artisan horizon:install && \
  php artisan migrate

printf "...\e[92m done \e[39m\n"

exit 0
