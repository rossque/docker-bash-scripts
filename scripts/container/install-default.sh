#!/bin/bash

  if [[ ! -d /var/www/html/localhost.test/public ]]
  then
      printf "\nCreating public directory ...\n"
        mkdir /var/www/html/localhost.test && \
        mkdir /var/www/html/localhost.test/public && \
        echo '<?php phpinfo();' > /var/www/html/localhost.test/public/index.php
      printf "...\e[92m done \e[39m\n"
  fi

exit 0
