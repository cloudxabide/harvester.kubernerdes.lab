#!/bin/sh
# ==============================================================================
# SCRIPT NAME: 10_Build_PXE.sh
# STATUS:  Work in Progress
# DESCRIPTION: Briefly describe the purpose of the script.
# AUTHOR: James Radtke (cloudXabide)
# GITHUB: https://github.com/cloudxabide
# DATE CREATED: 2025-04-13
# VERSION: 1.0
# LICENSE: TBD
# USAGE: ./script_name.sh [arguments]
# REQUIREMENTS: Active/valid SUSE subscription
# NOTES: Add any additional notes or context.
# ==============================================================================
# REVISION HISTORY:
# DATE        AUTHOR          VERSION     DESCRIPTION
# ----------  --------------  ----------  --------------------------------------
# YYYY-MM-DD  Your Name       X.Y         Initial version or description of changes
# ==============================================================================

# Exit immediately if a command exits with a non-zero status (POSIX-compliant).
set -e

# Treat unset variables as an error and exit immediately.
set -u

# ==============================================================================

# User-defined Variables (specific to this install)
export HARVESTER_VERSION="v1.4.2"
export IS_STABLE=1

# Variables that should not need to be modified
VARS_FILE="../Files/VARS.txt"
HARDWARE_FILE="../Files.hardware.csv"

# Source the variables file
[ -f $VARS_FILE ] && . $VARS_FILE || { echo "Error: Variables file not found"; exit 9; }
[ -f $HARDWARE_FILE ] && . $HARDWARE_FILE || { echo "Error: Hardware file not found"; exit 9; }

setup_web_server() {
sudo zypper addrepo https://download.opensuse.org/repositories/devel:languages:php/SLE_15_SP6/devel:languages:php.repo
sudo zypper --gpg-auto-import-keys refresh
sudo zypper --non-interactive install apache2 php8 php8-pdo php8-devel php8-openssl
sudo sed -i -e 's/Options None/Options FollowSymLinks Indexes/g'  /etc/apache/default-server.conf
sudo systemctl enable apache2.service --now

sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --zone=public --add-port=443/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --zone=public --list-ports
}

setup_dhcp_server() {
sudo zypper --non-interactive install dhcp-server
sudo sed -i -e 's/^DHCPD_INTERFACE=""/DHCPD_INTERFACE="eth0"/g' /etc/sysconfig/dhcpd

sudo systemctl enable dhcpd.service --now
sudo firewall-cmd --zone=public --permanent --add-service=dhcp
sudo firewall-cmd --reload

# Add code to update dhcp.conf and add dhcp-hosts.conf files


sudo rcdhcpd check-syntax
}


get_files() {
sudo -E sh -c '
cd /srv/www/htdocs
mkdir $HARVESTER_VERSION
cd $HARVESTER_VERSION
[ $IS_STABLE != 0 ] && { ln -s $HARVESTER_VERSION stable; } || { ln -s HARVESTER_VERSION latest; }

# TODO - it would be nice if it could check if file exists, and THEN grab the file
#wget https://releases.rancher.com/harvester/$HARVESTER_VERSION/harvester-$HARVESTER_VERSION-amd64.iso
#wget https://releases.rancher.com/harvester/$HARVESTER_VERSION/harvester-$HARVESTER_VERSION-vmlinuz-amd64
#wget https://releases.rancher.com/harvester/$HARVESTER_VERSION/harvester-$HARVESTER_VERSION-initrd-amd64
#wget https://releases.rancher.com/harvester/$HARVESTER_VERSION/harvester-$HARVESTER_VERSION-rootfs-amd64.squashfs
#wget https://releases.rancher.com/harvester/$HARVESTER_VERSION/harvester-$HARVESTER_VERSION-amd64.sha512
#wget https://releases.rancher.com/harvester/$HARVESTER_VERSION/version.yaml
'
}

update_host() {
}

