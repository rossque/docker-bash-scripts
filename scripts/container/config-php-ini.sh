#!/bin/bash

CONTAINER=$1

if [ -z "$CONTAINER" ]
then
    printf "Missing script argument\n"$0" <container>"
    exit 1
fi

  if [[ ! -f /usr/local/etc/php/php.ini ]]
  then
      printf "\nConfiguring $CONTAINER container ...\n"

        cp -R /usr/local/etc/.php_install/* /usr/local/etc/php/ && \
        cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini && \
        sed -i 's/error_reporting = E_ALL/error_reporting = E_ALL \^ E_DEPRECATED/g' /usr/local/etc/php/php.ini && \
        rm -rf /usr/local/etc/php/php.ini-development && \
        rm -rf /usr/local/etc/php/php.ini-production

      printf "...\e[92m done \e[39m\n"
  fi

exit 0
