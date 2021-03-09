#!/bin/bash

NODE="node:14.8.0-slim"
PS3='Enter a number between [1-6]: '
options=("14" "13" "12" "11" "10" "8")
select opt in "${options[@]}"
do
    case $opt in
        "14")
            NODE=node:14.8.0-slim
            break
            ;;
        "13")
            NODE=node:13.14.0-slim
            break
            ;;
        "12")
            NODE=node:12.18.3-slim
            break
            ;;
        "11")
            NODE=node:11.13-slim
            break
            ;;
        "10")
            NODE=node:10.22.0-slim
            break
            ;;
        "8")
            NODE=node:8.16.2-slim
            break
            ;;
        *) ;;
    esac
done

printf $NODE

exit 0
