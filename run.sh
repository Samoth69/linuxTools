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

# stop le script si une commande plante
set -e

if [ "$EUID" -ne 0 ]; then
    echo -e "${Red}This script must be runned as root${Color_Off}"
    exit
fi

# # install dependencies
# echo -e "${Blue}Installing packages...${Color_Off}"
# apt-get update -y
# apt-get install python3 python3-pip python3-venv -y

# # create venv
# echo -e "${Blue}Creating Python venv...${Color_Off}"
# python3 -m venv .venv

# # enable venv, anything below will be executed in the python venv
# echo -e "${Blue}Activating venv...${Color_Off}"
# source .venv/bin/activate

# # install dependencies in venv
# echo -e "${Blue}Installing requirements...${Color_Off}"
# pip install -r requirements.txt

# # deactivate venv
# deactivate

# echo -e "${Blue}Done :)${Color_Off}"

install_auto_update() {
    echo -e "${Blue}Installing prerequisites...${Color_Off}"
    apt-get update -y
    apt-get install cron -y

    echo -e "${Blue}Installing auto update script...${Color_Off}"
    cp scripts/auto_update.sh /usr/local/sbin/auto_update.sh
    chmod 700 /usr/local/sbin/auto_update.sh
    chown root:root /usr/local/sbin/auto_update.sh

    cp scripts/auto_update_cron /etc/cron.d/auto_update_cron
    chmod 644 /etc/cron.d/auto_update_cron
    chown root:root /etc/cron.d/auto_update_cron

    echo -e "${Green}Done${Color_Off}"
}

uninstall_auto_update() {
    echo -e "${Blue}Uninstalling auto update script...${Color_Off}"
    rm /usr/local/sbin/auto_update.sh
    rm /etc/cron.d/auto_update_cron

    echo -e "${Green}Done${Color_Off}"
}

main() {
    # see https://askubuntu.com/a/1716
    PS3='Please enter your choice: '
    options=("Setup auto-update cron" "Remove auto-update cron" "Setup correct timezone (TODO)" "Quit")
    select opt in "${options[@]}"; do
        case $opt in
        "${options[0]}")
            install_auto_update
            ;;
        "${options[1]}")
            uninstall_auto_update
            ;;
        # "Option 3")
        #     echo "you chose choice $REPLY which is $opt"
        #     ;;
        "${options[3]}")
            echo -e "${Green}Goodbye!${Color_Off}"
            break
            ;;
        *) echo "invalid option $REPLY" ;;
        esac
    done
}

main
