
# powertop-autostart

Powertop bash script and systemd startup service for extending battery life on laptops running Linux.

## Requirements

```plain
# Debian/Ubuntu/Mint
$ sudo apt-get update && sudo apt-get install git powertop

# Fedora/RHEL/CentOS
$ sudo dnf upgrade && sudo dnf install git powertop

# Arch/Manjaro
$ sudo pacman -Syu && sudo pacman -S git powertop
```

## Installation

```plain
# Clone repository
$ git clone https://github.com/tur1ngb0x/powertop-autostart.git

# Move into directory
$ cd powertop-autostart

# Mark the script as executable
$ chmod +x ./install.sh

# Run the script
$ sudo ./install.sh
```

## Uninstallation

```plain
# Move into directory
$ cd powertop-autostart

# Mark the script as executable
$ chmod +x ./uninstall.sh

# Run the script
$ sudo ./uninstall.sh
```

## Configuration (Optional)

* Open a terminal, type `sudo powertop`
* Navigate to the **Tunables** tab.
  * **Good** = Power saving is enabled.
  * **Bad** = Power saving is disabled.
* Make a list of devices you want to blacklist (disable power savings), such as:
  * Input - Keyboard/Mouse/Joystick
  * Storage - SSD/HDD/FDD
  * Wireless - WiFi/Bluetooth/Headphones
* We will need path of the device in order to blacklist it.
* Toggle **Bad** state for respective device(s) and copy the command(s) printed on the top which contains the path of the device.
* Open `/usr/local/bin/pwrtp.sh` with a text editor.
* In the **block-device** section of the file, add your device path as mentioned in the example template.
* Save the file and run `/usr/local/bin/pwrtp.sh` to apply the changes.
