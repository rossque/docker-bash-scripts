#!/bin/bash

  if [[ ! -f /root/.ssh/id_rsa.pub ]]
  then
      printf "\nCreating SSH key ...\n\n"

        mkdir /root/.ssh_install && \
        ssh-keygen -t rsa -f /root/.ssh_install/id_rsa -q -P "" -C "docker@localhost.test" && \
        cp -R /root/.ssh_install/* /root/.ssh/ && \
        cat /root/.ssh/id_rsa.pub

      printf "\n...\e[92m done \e[39m\n"
  fi

exit 0
