#!/bin/bash
# Script name:          versio_disk_space.sh
# Version:              v1.01.20200408
# Created on:           08/04/2020
# Author:               Jonas De la Marche
# Purpose:              Bash script that checks available diskspace on Versio shared hosting
# On GitHub:            https://github.com/jonasdlm/versio_monitoring/blob/master/versio_disk_space.sh


while [ ! -z "$1" ]; do
    case $1 in
        -w) shift; WARNING=$1 ;;
        -c) shift; CRITICAL=$1 ;;
        -h) show_help; exit 1 ;;
    esac
    shift
done

show_help() {
    echo
    echo "$0 -d DEVICE [ -w tps,read,write -c tps,read,write ] "
    echo "    | [ -W qlen -C qlen ] | -h"
    echo
    echo "This plug-in is used to be alerted when maximum hard drive io/s, sectors"
    echo "read|write/s or average queue length is reached."
    echo
    echo "  -d DEVICE            DEVICE must be without /dev (ex: -d sda)."
    echo "                       To specify a LVM logical volume use:"
    echo "                       volgroup/logvol."
    echo "                       To specify symlink from /dev/disk/ use full path, ex:"
    echo "                       /dev/disk/by-id/scsi-35000c50035006fb3"
    echo "  -w/c TPS,READ,WRITE  TPS means transfer per seconds (aka IO/s)"
    echo "                       READ and WRITE are in sectors per seconds"
    echo "  -W/C NUM             Use average queue length thresholds instead.."
    echo "  -b                   Brief output."
    echo "  -s                   silent output: no warnings or critials are issued"
    echo
    echo "Performance data for graphing is supplied for tps, read, write, avgrq-sz,"
    echo "avgqu-sz and await (see iostat man page for details)."
    echo
    echo "Example: Tps, read and write thresholds:"
    echo "    $0 -d sda -w 200,100000,100000 -c 300,200000,200000"
    echo
    echo "Example: Average queue length threshold:"
    echo "    $0 -d sda -W 50 -C 100"
    echo
}

diskspace=$(du -hs)

if [[ "$diskspace" -gt "28000000" ]]; then
        echo "CRITICAL: Diskpace is almost full! Usage is $diskspace KB"
        exitcode 2
elif [[ "$diskspace" -gt "25000000" ]]; then
        echo "WARNING: Diskpace is shrinking. Usage is $diskspace KB"
        exitcode 1
elif [[ -z "$diskspace" ]]; then
        echo "UNKNOW: Check the script. Unable to execute check"
        exitcode 3
else
        echo "OK: Diskpace is $diskspace KB"
        exitcode 0
fi
