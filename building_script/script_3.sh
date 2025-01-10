#!/bin/bash

# Variables
LOG_DIR=/root/Documents/flisol
#LOG_DIR=/var/log
ROOT_UID=0
E_NROOT=85
OK=0

# is Root?
isROOT() {
	if [[ $EUID -ne $ROOT_UID ]]; then
		echo "Must be root to run this script."
		return $E_NROOT
	fi
		return $OK
}

# Clean logs
cleaningLOGS(){
	cat /dev/null > $LOG_DIR/messages
	cat /dev/null > $LOG_DIR/wtmp

	echo " == Logs cleaned up == "
}

# --------------------------------
# 			Main Program
# --------------------------------

clear

isROOT
echo "Run as root"

cleaningLOGS
