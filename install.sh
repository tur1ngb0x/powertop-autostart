#!/usr/bin/env bash

text() {
   printf "\n$1\n"
}

if [[ $EUID -ne 0 ]]; then
   echo "Error: Run this script as root, exiting." && exit 1
fi

text "POWERTOP AUTOSTART INSTALLER"
read -r -p " > Type 'yes' to proceed: "
if [ "$REPLY" != "yes" ]; then
   echo "Error: Incorrect input, exiting." && exit 1
fi

install_script() {
   text "INSTALLING SCRIPT"
   if [[ -f /usr/local/bin/pwrtp.sh ]]; then
      rm -fv /usr/local/bin/pwrtp.sh
   fi
   cp -iv ./pwrtp.sh /usr/local/bin/pwrtp.sh
   chmod +x /usr/local/bin/pwrtp.sh
}

install_service() {
   text "INSTALLING SERVICE"
   if [[ -f /etc/systemd/system/pwrtp.service ]]; then
      rm -fv /etc/systemd/system/pwrtp.service
   fi
   cp -iv ./pwrtp.service /etc/systemd/system/pwrtp.service
}

enable_service() {
   text "ENABLING SERVICE"
   systemctl enable --now pwrtp.service

   text "RELOADING DAEMON"
   systemctl daemon-reload
}

finished() {
   text "SUCCESSFULLY INSTALLED"
}

# Begin script from here
(install_script && install_service && enable_service && finished) || (echo "FAILED TO INSTALL" && exit 1)
