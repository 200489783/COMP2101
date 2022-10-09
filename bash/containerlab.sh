#!/bin/bash

# =========================
# Test if lxd is installed
# =========================

if lxd --version | grep -q '.';  then
    echo "::: lxd is Preinstalled "
else
    sudo snap install lxd
    echo "::: Installed LXD"
fi

# =========================
# Installing curl if not already installed
# =========================
if curl --version | grep -q '.'; then
    echo "::: curl preinstalled "
else
    sudo apt install curl
    echo "::: Installed CURL"
fi

# =========================
# 2. Run lxd init –auto if no lxdbr0 exists
# =========================

if ip a | grep -q 'lxdbr0'; then
    echo "::: LXD already exists "
else
    lxd init auto
    echo "::: LXD Initialized"
fi

# =========================
# 3. Launch a container running Ubuntu server named COMP2101-S22 if necessary
# =========================

if lxc list | grep -q 'COMP2101-S22 | RUNNING'; then
    echo "::: Container is running "
else
    lxc launch images:ubuntu/20.04 COMP2101-S22
    lxc exec COMP2101-S22 -- apt update
    lxc exec COMP2101-S22 -- apt upgrade
    echo "::: Created the CONTAINER "
fi
    
# =========================
# 5. Install Apache2 in the container if necessary
# =========================
if lxc exec COMP2101-S22 -- apache2 -v | grep -q 'version: Apache/2'; then
    echo "::: Apache2 is already installed "
else
    lxc exec COMP2101-S22 -- apt install apache2
fi

# =========================
# Fetch IP Address
# =========================
lxdIpAddress=$(lxc list | grep COMP2101-S22 | grep -E -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")

# =========================
# 6. Retrieve the default web page
# =========================
status=$(curl -s -I -X GET $lxdIpAddress)
if echo "$status" | grep -q 'Content-Type'; then
    echo "::: Success! Server online --> http://$lxdIpAddress "
else
    echo "::: !!! Server Offline "
fi

# =========================
# 4. Associate COMP2101-S22 > container’s IP in /etc/hosts 
# =========================
if grep -q "COMP2101-S22" /etc/hosts; then
    echo "::: HOST Entry exists "
else
    echo "$lxdIpAddress COMP2101-S22" >> /etc/hosts
fi