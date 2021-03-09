#!/bin/bash

DOMAIN=$1

if [ -z "$DOMAIN" ]
then
    printf "Missing script arguments\n"$0" <ip> <server>"
    exit 1
fi

printf "\nInstalling Artisan Scheduler ...\n"

service cron start

if [[ $(crontab -l | egrep -v "^(#|$)" | grep -q "/usr/local/bin/php /var/www/html/$DOMAIN/artisan schedule:run"; echo $?) == 1 ]]
then
    printf "$(crontab -l ; echo "* * * * * /usr/local/bin/php /var/www/html/$DOMAIN/artisan schedule:run")\n" | crontab -
fi

printf "...\e[92m done \e[39m\n"

exit 0