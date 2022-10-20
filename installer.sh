#!/bin/bash

# Reset
NO_COLOR='\033[0m'       # Text Reset

RED='\033[0;31m'          # Red
GREEN='\033[0;32m'        # Green
YELLOW='\033[0;33m'       # Yellow
BLUE='\033[0;34m'         # Blue

function check_preq () {
    command -v whiptail >/dev/null 2>&1 || { echo -e "${RED}whiptail must be installed to run this script${NO_COLOR}.
    sudo apt install whiptail"; exit 1; }
    command -v dos2unix >/dev/null 2>&1 || { whiptail --title "Missing Dependancy" --msgbox "This script requires dos2unix to be installed on your system.
    sudo apt install dos2unix" 8 70; exit 1; }
}

function install_script () {
    wget "https://raw.githubusercontent.com/CGBassPlayer/sicas-scripts/master/scripts/$1"
    mkdir -p ~/bin
    CMD=`echo $1 | cut -f1 -d"."` # Strip off file extension
    mv -u -S .old $1 ~/bin/${CMD}
    chmod -x ~/bin/$CMD.old
    chmod u+x ~/bin/${CMD}
    dos2unix -q ~/bin/${CMD}
    echo -e "${GREEN}Successfully installed ${CMD}${NO_COLOR}"
}

check_preq
SCRIPTS=$(whiptail --title "SICAS Developer scripts Available" --checklist "Choose scripts to install"  15 90 3 \
audit.sh "Manipulate files in a jar file" OFF \
ff_dup_id.py "Check for dupilcate Global IDs in flat file from SUNYHR" OFF \
mkextension.sh "Create extension template for Ellucian Expirience" OFF \
3>&1 1>&2 2>&3)

for SCRIPT in $SCRIPTS; do
    SCRIPT=`sed -e 's/^"//' -e 's/"$//' <<<"$SCRIPT"` # Strip double quotes from variable
    echo -e "${BLUE}Installing $SCRIPT...{$NO_COLOR}"
    install_script $SCRIPT
done

exit 0
