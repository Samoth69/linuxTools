#!/bin/bash

# color variables, from https://stackoverflow.com/a/28938235/9658535
# Reset
Color_Off='\033[0m' # Text Reset

# Regular Colors
Black='\033[0;30m'  # Black
Red='\033[0;31m'    # Red
Green='\033[0;32m'  # Green
Yellow='\033[0;33m' # Yellow
Blue='\033[0;34m'   # Blue
Purple='\033[0;35m' # Purple
Cyan='\033[0;36m'   # Cyan
White='\033[0;37m'  # White

apt-get update -y
apt-get upgrade -y
apt-get autoremove -y

# check if a reboot is required
if [ -f /var/run/reboot-required ]; then

    echo -e "${Red}A reboot is required${Color_Off}"

    # check if a restart HASN'T been planned
    if [ ! -f /run/systemd/shutdown/scheduled ]; then
        echo -e "${Red}Planning reboot for 5AM${Color_Off}"
        shutdown -r 05:00
    else
        echo -e "${Red}Reboot already planned${Color_Off}"
    fi
fi