#!/bin/bash
function check_preq () {
    command -v whiptail >/dev/null 2>&1 || { echo "whiptail must be installed to run this script.
    sudo apt install whiptail"; exit 1; }
    command -v dos2unix >/dev/null 2>&1 || { whiptail --title "Missing Dependancy" --msgbox "This script requires dos2unix to be installed on your system. 
    sudo apt install dos2unix" 8 70; exit 1; }
    command -v wget >/dev/null 2>&1 || { whiptail --title "Missing Dependancy" --msgbox "This script requires wget to be installed on your system. 
    sudo apt install wget" 8 70; exit 1; }
}

function install_script () {
    wget "https://raw.githubusercontent.com/CGBassPlayer/sicas-scripts/master/$1.sh"
    mkdir -p ~/bin
    mv -u -S .old $1.sh ~/bin/$1
    chmod u+x ~/bin/$1
    dos2unix -q ~/bin/$1
    echo "Successfully installed $1"
}

check_preq
SCRIPTS=$(whiptail --title "SICAS Developer scripts Available" --checklist "Choose scripts to install"  20 78 4 \
audit "Manipulate files in a jar file" OFF 3>&1 1>&2 2>&3)

for SCRIPT in $SCRIPTS; do
    SCRIPT=`sed -e 's/^"//' -e 's/"$//' <<<"$SCRIPT"` # Strip double quotes from variable
    echo "installing $SCRIPT"
    install_script $SCRIPT
done

exit 0
