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
	echo "Logs cleaned up"
}

# Scanning ports
fastScanNT(){	
	read -p " Enter a range of IP {192.168.10.0/24,192.168.2.3} : " target
	rm ips_$(date +%Y-%m-%d).* 
	
	masscan $target --ping --open-only | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" > ips_`date +%Y-%m-%d.%H:%M:%S`
	
	clear
	
	echo " == Hosts alive == "
	cat ips_$(date +%Y-%m-%d).*
}

# --------------------------------
# 			Main Program
# --------------------------------

clear

isROOT

echo "Run as root"

cleaningLOGS
fastScanNT

echo "exit"
