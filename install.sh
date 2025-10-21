#!/usr/bin/env bash

[[ $(id -u) -ne 0 ]] && echo "Run the script as a root user, exiting..." && exit 1

function show () { (set -x; "${@:?}"); }

show install -v -D -m 0755 -o root -g root ./pwrtp.sh /usr/local/bin/pwrtp.sh

show install -v -D -m 0644 -o root -g root ./pwrtp.service /etc/systemd/system/pwrtp.service

show systemctl daemon-reload

show systemctl enable --now pwrtp.service

show systemctl status pwrtp.service
