#!/bin/bash
# Script name:          versio_disk_space.sh
# Version:              v1.01.200408
# Created on:           08/04/2020
# Author:               Jonas De la Marche
# Purpose:              Bash script that checks available diskspace on Versio shared hosting
# On GitHub:            https://gitlab.gentgrp.gent.be/systeembeheer/monitoring/nagios/linux-client-checks/blob/master/check_lin_enabled_services.sh

exitcode=3
returnstring="Check failed. Please debug"

while [ ! -z "$1" ]; do
    case "$1" in
        -w) shift ; warninglevel="$1" ; shift ; ;;
        -c) shift ; criticallevel="$1" ; shift ; ;;
        -h) showhelp ; exit 1 ; ;;
        *) break ; ;;
    esac
done

diskspace=$(df -Ph | awk 'NR == 2{print $5+0}')

if [[ $diskspace -gt $criticallevel  ]];
        then
                returnstring="CRITICAL: Diskpace is almost full! Usage is $diskspace%"
                exitcode=2
elif [[ $diskspace -gt $warninglevel ]];
        then
                returnstring="WARNING: Diskpace is shrinking. Usage is $diskspace%"
                exitcode=1
elif [ -z "$diskspace" ];
        then
                returnstring="UNKNOW: Check the script. Unable to execute check"
                exitcode=3
else
        returnstring="OK: Diskpace is $diskspace%"
        exitcode=0
fi

echo $returnstring
exit $exitcode
