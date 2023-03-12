#!/usr/bin/env bash

# Apply power savings to all devices
auto-tune() {
	echo "powertop --autotune: Applying 'Good' setting to all devices..."
	sudo powertop --auto-tune
}

# Apply power savings to these devices
# Syntax: sudo bash -c 'echo "on" > path'
allow-devices() {
	echo "Allowlist: Applying 'Good' setting to selected devices..."
	sudo bash -c 'echo "auto" > /sys/bus/pci/devices/0000:01:00.0/power/control' # Nvidia GeForce MX150 2GB (Optimus)
	sudo bash -c 'echo "auto" > /sys/bus/pci/devices/0000:00:02.0/power/control' # Intel Corporation UHD Graphics 620
}

# Do not apply power savings to these devices
# Syntax: sudo bash -c 'echo "on" > path'
block-devices() {
	echo "Blocklist: Applying 'Bad' setting to selected devices..."
	sudo bash -c 'echo "on" > /sys/bus/usb/devices/1-1/power/control'
	sudo bash -c 'echo "on" > /sys/bus/usb/devices/1-2/power/control'
	sudo bash -c 'echo "on" > /sys/bus/usb/devices/1-3/power/control'
	sudo bash -c 'echo "on" > /sys/bus/usb/devices/1-4/power/control'
	sudo bash -c 'echo "on" > /sys/bus/usb/devices/1-5/power/control'
	sudo bash -c 'echo "on" > /sys/bus/usb/devices/1-6/power/control'
	sudo bash -c 'echo "on" > /sys/bus/pci/devices/0000:03:00.0/power/control' # Qualcomm Atheros QCA9377 Wi-Fi
	sudo bash -c 'echo "on" > /sys/bus/pci/devices/0000:02:00.1/power/control' # Realtek Semiconductor 8168 Ethernet
}

wakeup-lan() {
	echo "Wakeup LAN: Applying 'Disabled' setting to selected devices..."
	sudo bash -c 'echo "disabled" > /sys/class/net/enp2s0f1/device/power/wakeup'
	sudo bash -c 'echo "disabled" > /sys/class/net/wlp3s0/device/power/wakeup'
	sudo bash -c 'echo "disabled" > /sys/class/net/wlan0/device/power/wakeup'
}

wakeup-usb() {
	echo "Wakeup USB: Applying 'Disabled' setting to selected devices..."
	sudo bash -c 'echo "disabled" > /sys/bus/usb/devices/usb1/power/wakeup'
	sudo bash -c 'echo "disabled" > /sys/bus/usb/devices/usb2/power/wakeup'
	sudo bash -c 'echo "disabled" > /sys/bus/usb/devices/1-1/power/wakeup'
	sudo bash -c 'echo "disabled" > /sys/bus/usb/devices/1-2/power/wakeup'
	sudo bash -c 'echo "disabled" > /sys/bus/usb/devices/1-3/power/wakeup'
	sudo bash -c 'echo "disabled" > /sys/bus/usb/devices/1-4/power/wakeup'
	sudo bash -c 'echo "disabled" > /sys/bus/usb/devices/1-5/power/wakeup'
	sudo bash -c 'echo "disabled" > /sys/bus/usb/devices/1-6/power/wakeup'
	sudo bash -c 'echo "disabled" > /sys/bus/usb/devices/1-7/power/wakeup'
}

# Begin script from here
auto-tune
allow-devices
block-devices
wakeup-lan
wakeup-usb
