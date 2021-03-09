#!/bin/bash

CWD=$1
MYSQL_DATABASE=$2
DOMAIN=$3

if [ -z "$CWD" ] || [ -z "$MYSQL_DATABASE" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi

COUNTER=0
COUNTER_BLOCK="#"
INCREMENT=3

progressBar(){

  LINE="["

  COUNT=0
  while [ $COUNT -lt 100 ]
  do
    if [ $1 -lt $COUNT ]
    then
      LINE=$LINE"-"
    else
      if [ $1 -eq $COUNT ]
      then
        LINE=$LINE">"
      else
        LINE=$LINE"="
      fi
    fi
    ((COUNT=COUNT+$2))
  done

  LINE=$LINE"] $1%"

  echo $LINE
  
}

printf "\nTesting database connection (please wait)...\n"
until mysql -u root -p'password' -h 127.0.0.1 -P 4306 -D $MYSQL_DATABASE -e exit 2> /dev/null
do

  progressBar $COUNTER $INCREMENT
  sleep $INCREMENT

  ((COUNTER=COUNTER+INCREMENT))
  COUNTER_BLOCK="$COUNTER_BLOCK#"

  if [ $COUNTER -gt 100 ]
  then
    COUNTER=0
    COUNTER_BLOCK="#"
    echo ""
  fi

done
printf "...\e[92m done \e[39m\n"

exit 0
