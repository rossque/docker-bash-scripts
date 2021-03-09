#!/bin/bash

CWD=$1

if [ -z "$CWD" ]
then
    printf "Missing script argument\n"$0" <cwd>"
    exit 1
fi


exit 0