#!/usr/bin/env bash

[[ $(id -u) -ne 0 ]] && echo "Run the script as a non-root user. Exiting." && exit
cdir=$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
echo() { tput bold && tput setaf 4 && printf "%s\n" "${1}" && tput sgr0; }

echo 'installing script'
rm -fv /usr/local/bin/pwrtp.sh
cp -fv "${cdir}"/pwrtp.sh /usr/local/bin/pwrtp.sh
chmod +x /usr/local/bin/pwrtp.sh

echo 'installing service'
rm -fv /etc/systemd/system/pwrtp.service
cp -fv "${cdir}"/pwrtp.service /etc/systemd/system/pwrtp.service

echo 'enabling service'
systemctl enable --now pwrtp.service

echo 'reloading daemon'
systemctl daemon-reload

echo 'successfully installed'
