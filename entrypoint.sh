#!/bin/sh

# echo "0 23 * * * " >> /etc/crontabs/root
echo "${CRON_SCHEDULE} cronScript.sh" >> /etc/crontabs/root
crond -l 2 -f > /dev/stdout 2> /dev/stderr 

