#!/bin/bash

# hostname
echo "hostname: $(hostname)"
echo " "
# host complete information
echo "Hostname Complete Information:"
hostnamectl
echo " "
# operating system name and version
osdata=$(hostnamectl | grep -h "Operating System")
echo "$osdata"
echo " "
# ip addresses
echo "IP Addresses: "
ip a | grep -w inet
echo " "
# space available in only the root filesystem
spacedata=$(df | grep -h "/dev/")
echo "Space Information: "
echo "$spacedata"