#!/bin/bash

# Variables
LOG_DIR=/root/Documents/flisol
#LOG_DIR=/var/log
ROOT_UID=0
E_NROOT=85

clear

# is Root?
if [[ $EUID -ne $ROOT_UID ]]; then
	echo "Must be root to run this script."
	exit
fi

echo "Run as root"
# Clean logs
cat /dev/null > $LOG_DIR/messages
cat /dev/null > $LOG_DIR/wtmp
echo " == Logs cleaned up == "
