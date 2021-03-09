#!/bin/bash

  if [[ ! -f /etc/supervisor/conf.d/horizon.conf ]]
  then
      printf "\nRunning Laravel Horizon as background service ...\n"

cat > /etc/supervisor/conf.d/horizon.conf << EOF
[program:horizon]
process_name=%(program_name)s
command=php /var/www/html/artisan horizon
autostart=true
autorestart=true
user=root
redirect_stderr=true
stdout_logfile=/var/log/supervisor/horizon.log
stopwaitsecs=3600
EOF

      cd /etc/supervisor && service supervisor start

      printf "...\e[92m done \e[39m\n"
  fi
  

exit 0
