#!/bin/sh
# ==============================================================================
# SCRIPT NAME: 00_Post_SLE_Install.sh
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

# Update SUDO NOPASSWD for this user - you need sudo already, or root pass, for this to work
echo "# Note: script is about to ask for your (sudo) or root passwd"
echo "$(whoami) ALL=(ALL) NOPASSWD: ALL" | sudo tee  /etc/sudoers.d/$(whoami)-nopasswd-all

# Update Hostname
echo "geeko" | sudo tee /etc/hostname

# Check Host Subscription Status and initiate registration/subscription process
# TODO 

# Update Host OS
sudo zypper up

# Setup SSH Keys
echo "" | ssh-keygen -tecdsa -b521 -f ~/.ssh/harvester.kubernerdes.lab
cat << EOF | tee ~/.ssh/config
Host node1 node2 node3 10.10.12.221 10.10.12.222 10.10.12.223 
  IdentityFile ~/.ssh/harvester.kubernerdes.lab
EOF

# Create Hosts entries
cat << EOF | sudo tee -a /etc/hosts

# Hosts for Harvester
10.10.12.220	api.harvester.kubernerdes.lab
10.10.12.221 	node1.harvester.kubernerdes.lab node1
10.10.12.222 	node2.harvester.kubernerdes.lab node2
10.10.12.223 	node3.harvester.kubernerdes.lab node3
EOF 
