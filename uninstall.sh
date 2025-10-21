#!/usr/bin/env bash

[[ $(id -u) -ne 0 ]] && echo "Run the script as a root user, exiting..." && exit 1

function show () { (set -x; "${@:?}"); }

show systemctl stop --now pwrtp.service

show systemctl disable pwrtp.service

show rm -fv /etc/systemd/system/pwrtp.service

show systemctl daemon-reload

show rm -fv /usr/local/bin/pwrtp.sh
