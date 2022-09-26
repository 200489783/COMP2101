#!/bin/bash

# title of script
echo "Report for myvm"

echo "==============="
# FULLY QUALIFIED DOMAIN NAME
fqdn=$(hostname --fqdn)
echo "FQDN: $fqdn"
# OPERATING SYSTEM AND VERSION
osnv=$(hostnamectl | grep -h "Operating System")
echo ":$osnv"
# IP ADDRESS
ipaddr=$(hostname -i)
echo "IP Address: $ipaddr" 
# ROOT FILESYSTEM
rfs=$(df -h / | grep "dev/sda" | awk '{print $4}')
echo "Root Filesystem Free Space: $rfs"
echo "==============="