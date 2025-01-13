#!/usr/bin/env bash

[[ $(id -u) -ne 0 ]] && echo "Run the script as a root user, exiting..." && exit 1
cdir=$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
function header { tput bold && tput setaf 4 && printf "%s\n" "${1}" && tput sgr0; }

header 'Installing powertop script...'
rm -fv /usr/local/bin/pwrtp.sh
cp -fv "${cdir}"/pwrtp.sh /usr/local/bin/pwrtp.sh
chmod 0755 /usr/local/bin/pwrtp.sh
chown root:root /usr/local/bin/pwrtp.sh

header 'Installing powertop service...'
rm -fv /etc/systemd/system/pwrtp.service
cp -fv "${cdir}"/pwrtp.service /etc/systemd/system/pwrtp.service
chmod -v 0644 /etc/systemd/system/pwrtp.service
chown -v root:root /etc/systemd/system/pwrtp.service

systemctl enable --now pwrtp.service
systemctl daemon-reload

header 'Installation complete...'
ls /usr/local/bin/pwrtp.sh
ls /etc/systemd/system/pwrtp.service

header 'Reboot immediately to apply changes...'
