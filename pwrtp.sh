#!/usr/bin/env bash

function auto_tune {
    # Apply power savings to all devices
    echo "Auto T: Apply Auto/Good setting to selected devices..."
    sudo powertop --auto-tune
}

function allow_devices {
    echo "Allow Devices: Apply Auto/Good setting to selected devices..."
    devices=(
        "/sys/bus/pci/devices/0000:01:00.0/power/control"  # dGPU - Nvidia GeForce MX150 2GB (Optimus)
        "/sys/bus/pci/devices/0000:00:02.0/power/control"  # iGPU - Intel Corporation UHD Graphics 620
    )
    for dev in "${devices[@]}"; do
        if [[ -e "${dev}" ]]; then
            echo "${dev}"
            echo "auto" > "${dev}"
        else
            echo "Error: ${dev} not found"
        fi
    done
}

function block_devices {
    # Do not apply power savings to these devices
    # Syntax: sudo bash -c 'echo "on" > path'
    echo "Block Devices: Apply On/Bad setting to selected devices..."

    devices=(
        "/sys/bus/usb/devices/1-1/power/control"
        "/sys/bus/usb/devices/1-2/power/control"
        "/sys/bus/usb/devices/1-3/power/control"
        "/sys/bus/usb/devices/1-4/power/control"
        "/sys/bus/usb/devices/1-5/power/control"
        "/sys/bus/usb/devices/1-6/power/control"
        "/sys/bus/pci/devices/0000:03:00.0/power/control"  # WiFi - Qualcomm Atheros QCA9377
        "/sys/bus/pci/devices/0000:02:00.1/power/control"  # Ethernet - Realtek Semiconductor 8168
    )

    for dev in "${devices[@]}"; do
        if [[ -e "${dev}" ]]; then
            echo "${dev}"
            echo "on" > "${dev}"
        else
            echo "Error: ${dev} not found"
        fi
    done
}


function wakeup_lan {
    # Disable wake up via LAN events to these devices
    # Syntax: sudo bash -c 'echo "disabled" > path'
    echo "Wakeup LAN: Apply Disabled setting to selected devices..."

    devices=(
        "/sys/class/net/enp2s0f1/device/power/wakeup"
        "/sys/class/net/wlp3s0/device/power/wakeup"
        "/sys/class/net/wlan0/device/power/wakeup"
    )

    for dev in "${devices[@]}"; do
        if [[ -e "${dev}" ]]; then
            echo "${dev}"
            echo "disabled" > "${dev}"
        else
            echo "Error: ${dev} not found"
        fi
    done
}

function wakeup_usb {
    # Disable wake up via USB events to these devices
    # Syntax: sudo bash -c 'echo "disabled" > path'
    echo "Wakeup USB: Apply Disabled setting to selected devices..."

    devices=(
        "/sys/bus/usb/devices/usb1/power/wakeup"
        "/sys/bus/usb/devices/usb2/power/wakeup"
        "/sys/bus/usb/devices/1-1/power/wakeup"
        "/sys/bus/usb/devices/1-2/power/wakeup"
        "/sys/bus/usb/devices/1-3/power/wakeup"
        "/sys/bus/usb/devices/1-4/power/wakeup"
        "/sys/bus/usb/devices/1-5/power/wakeup"
        "/sys/bus/usb/devices/1-6/power/wakeup"
        "/sys/bus/usb/devices/1-7/power/wakeup"
    )

    for dev in "${devices[@]}"; do
        if [[ -e "${dev}" ]]; then
            echo "${dev}"
            echo "disabled" > "${dev}"
        else
            echo "Error: ${dev} not found"
        fi
    done
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
