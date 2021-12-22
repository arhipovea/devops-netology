#!/usr/bin/env bash

while ((1==1))
do
    curl http://localhost:4757 &> /dev/null
    if (($? != 0))
    then
        date >> curl.log 
        sleep 1
    else
        break
    fi
done