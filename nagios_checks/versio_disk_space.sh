#!/bin/bash
# Script name:          versio_disk_space.sh
# Version:              v1.01.20200408
# Created on:           08/04/2020
# Author:               Jonas De la Marche
# Purpose:              Bash script that checks available diskspace on Versio shared hosting
# On GitHub:            https://github.com/jonasdlm/versio_monitoring/blob/master/versio_disk_space.sh

diskspace=$(du -hs)

if [ "$diskspace" -gt "28000000" ];
        then
                echo "CRITICAL: Diskpace is almost full! Usage is $diskspace KB"
                exitcode 2
elif [ "$diskspace" -gt "25000000" ];
        then
                echo "WARNING: Diskpace is shrinking. Usage is $diskspace KB"
                exitcode 1
elif [ -z "$diskspace" ];
        then
                echo "UNKNOW: Check the script. Unable to execute check"
                exitcode 3
else
        echo "OK: Diskpace is $diskspace KB"
        exitcode 0
fi
