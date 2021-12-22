#!/usr/bin/env bash

IP=(192.168.0.1 173.194.222.113 87.250.250.242)

for ip in ${IP[@]}
do
    for i in {0..4}
    do
        res=$(curl -Is -m 2 http://$ip -w "%{http_code}" -o /dev/null)
        if (( $? == 0 ))
        then
            echo $(date) [$ip] Server respond: $res >> log
        else
            echo $(date) [$ip] Server is not responding >> log
        fi
        sleep 1
    done
done