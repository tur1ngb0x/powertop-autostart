#!/usr/bin/env bash

[[ $(id -u) -ne 0 ]] && echo "Run the script as a root user, exiting..." && exit 1
cdir=$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
function header { tput bold && tput setaf 4 && printf "%s\n" "${1}" && tput sgr0; }

header 'Uninstalling powertop service...'
systemctl stop pwrtp.service
systemctl disable pwrtp.service0
rm -fv /etc/systemd/system/pwrtp.service
systemctl daemon-reload

header 'Uninstalling powertop script...'
rm -fv /usr/local/bin/pwrtp.sh

header 'Uninstallation complete...'
header 'Reboot immediately to apply changes...'
