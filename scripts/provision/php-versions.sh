#!/bin/bash

PHP="rossque/php:7.4"
PS3='Enter a number between [1-4]: '
options=("7.4" "7.3" "7.2" "7.1")
select opt in "${options[@]}"
do
    case $opt in
        "7.4")
            PHP=rossque/php:7.4
            break
            ;;
        "7.3")
            PHP=rossque/php:7.3
            break
            ;;
        "7.2")
            PHP=rossque/php:7.2
            break
            ;;
        "7.1")
            PHP=rossque/php:7.1
            break
            ;;
        *) ;;
    esac
done

printf $PHP

exit 0
