#!/usr/bin/env bash

[[ $(id -u) -ne 0 ]] && echo "Run the script as a non-root user. Exiting." && exit
echo() { tput bold && tput setaf 4 && printf "%s\n" "${1}" && tput sgr0; }

echo 'disabling service'
systemctl stop pwrtp.service
systemctl disable pwrtp.service

echo 'uninstalling service'
rm -fv /etc/systemd/system/pwrtp.service

echo 'uninstalling script'
rm -fv /usr/local/bin/pwrtp.sh

echo 'reloading daemon'
systemctl daemon-reload

echo 'successfully uninstalled, reboot to power cycle pcie devices'
