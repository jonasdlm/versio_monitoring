#!/bin/bash
# Script name:          versio_disk_space.sh
# Version:              v1.01.200408
# Created on:           08/04/2020
# Author:               Jonas De la Marche
# Purpose:              Bash script that checks available diskspace on Versio shared hosting
# On GitHub:            https://gitlab.gentgrp.gent.be/systeembeheer/monitoring/nagios/linux-client-checks/blob/master/check_lin_enabled_services.sh

diskspaceGB = $(du -hs)
diskspace = ${diskspaceGB::-1}

if [ $diskspace -gt 28 ];
	then
		echo "CRITICAL: Diskpace is almost full! Usage is $diskspaceGB"
		exitcode 2
elif [ $diskspace -gt 25 ];
	then
		echo "WARNING: Diskpace is shrinking. Usage is $diskspaceGB"
		exitcode 1
elif [ -z $diskspace ]; 
	then
		echo "UNKNOW: Check the script. Unable to execute check"
		exitcode 3
else
	echo "OK: Diskpace is $diskspaceGB"
	exitcode 0
