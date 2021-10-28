#!/usr/bin/env bash

text() {
   printf "\n$1\n"
}

if [[ $EUID -ne 0 ]]; then
   echo "Error: Run this script as root, exiting." && exit 1
fi

text "POWERTOP AUTOSTART UNINSTALLER"
read -r -p " > Type 'yes' to proceed: "
if [ "$REPLY" != "yes" ]; then
   echo "Error: Incorrect input, exiting." && exit 1
fi

text "DISABLING SERVICE"
systemctl stop pwrtp.service
systemctl disable pwrtp.service

text "UNINSTALLING SERVICE"
rm -fv /etc/systemd/system/pwrtp.service

text "UNINSTALLING SCRIPT"
rm -fv /usr/local/bin/pwrtp.sh

text "RELOADING DAEMON"
systemctl daemon-reload

text "SUCCESSFULLY UNINSTALLED"
