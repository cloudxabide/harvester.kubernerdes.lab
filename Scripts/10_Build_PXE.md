#!/bin/bash

# User-defined Variables (specific to this install)
HARVESTER_VERSION="v1.4.2"

# Variables that should not need to be modified
VARS_FILE="../Files/VARS.txt"
HARDWARE_FILE="../Files.hardware.csv"

# Source the variables file
[ -f $VARS_FILE ] && . $VARS_FILE || { echo "Error: Variables file not found"; exit 9; }
[ -f $HARDWARE_FILE ] && . $HARDWARE_FILE || { echo "Error: Hardware file not found"; exit 9; }


setup_web_server() {
}



get_file() {
https://releases.rancher.com/harvester/$HARVESTER_VERSION/harvester-$HARVESTER_VERSION-amd64.iso
https://releases.rancher.com/harvester/$HARVESTER_VERSION/harvester-$HARVESTER_VERSION-vmlinuz-amd64
https://releases.rancher.com/harvester/$HARVESTER_VERSION/harvester-$HARVESTER_VERSION-initrd-amd64
https://releases.rancher.com/harvester/$HARVESTER_VERSION/harvester-$HARVESTER_VERSION-rootfs-amd64.squashfs
https://releases.rancher.com/harvester/$HARVESTER_VERSION/harvester-$HARVESTER_VERSION-amd64.sha512
https://releases.rancher.com/harvester/$HARVESTER_VERSION/version.yaml
}
