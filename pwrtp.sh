#!/usr/bin/env bash

function auto_tune {
	# Apply power savings to all devices
	echo "powertop --autotune: Applying 'Good' setting to all devices..."
	sudo powertop --auto-tune
}

function allow_devices {
	# Apply power savings to these devices
	# Syntax: sudo bash -c 'echo "on" > path'
	echo "Allow List: Applying 'Good' setting to selected devices..."
	sudo bash -c 'echo "auto" > /sys/bus/pci/devices/0000:01:00.0/power/control' # dGPU - Nvidia GeForce MX150 2GB (Optimus)
	sudo bash -c 'echo "auto" > /sys/bus/pci/devices/0000:00:02.0/power/control' # iGPU - Intel Corporation UHD Graphics 620
}

function block_devices {
	# Do not apply power savings to these devices
	# Syntax: sudo bash -c 'echo "on" > path'
	echo "Block List: Applying 'Bad' setting to selected devices..."
	sudo bash -c 'echo "on" > /sys/bus/usb/devices/1-1/power/control'
	sudo bash -c 'echo "on" > /sys/bus/usb/devices/1-2/power/control'
	sudo bash -c 'echo "on" > /sys/bus/usb/devices/1-3/power/control'
	sudo bash -c 'echo "on" > /sys/bus/usb/devices/1-4/power/control'
	sudo bash -c 'echo "on" > /sys/bus/usb/devices/1-5/power/control'
	sudo bash -c 'echo "on" > /sys/bus/usb/devices/1-6/power/control'
	sudo bash -c 'echo "on" > /sys/bus/pci/devices/0000:03:00.0/power/control' # WiFi - Qualcomm Atheros QCA9377
	sudo bash -c 'echo "on" > /sys/bus/pci/devices/0000:02:00.1/power/control' # Ethernet - Realtek Semiconductor 8168
}

function wakeup_lan {
	# Disable wake up via LAN events to these devices
 	# Syntax: sudo bash -c 'echo "disabled" > path'
	echo "Wakeup LAN: Applying 'Disabled' setting to selected devices..."
	sudo bash -c 'echo "disabled" > /sys/class/net/enp2s0f1/device/power/wakeup'
	sudo bash -c 'echo "disabled" > /sys/class/net/wlp3s0/device/power/wakeup'
	sudo bash -c 'echo "disabled" > /sys/class/net/wlan0/device/power/wakeup'
}

function wakeup_usb {
	# Disable wake up via USB events to these devices
 	# Syntax: sudo bash -c 'echo "disabled" > path'
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

function main {
	auto_tune
	allow_devices
	block_devices
	wakeup_lan
	wakeup_usb
}

# begin script from here
main "${@}"
