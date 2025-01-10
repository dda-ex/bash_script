#!/bin/bash

# Variables
LOG_DIR=/root/Documents/flisol
#LOG_DIR=/var/log
ROOT_UID=0
E_NROOT=85
OK=0

IPADD=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}')
IPSFILE=ips_$(date +%Y-%m-%d)

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

# Scanning ports
fastNTScan(){	
	read -p " Enter a range of IP {192.168.0.0/24,192.168.0.0} : " target
	
	if [[ -f  $IPSFILE ]]; then
		rm $IPSFILE 
	fi
	
	masscan $target --ping --open-only | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" > $IPSFILE
	
	echo " == Hosts alive == "
	cat $IPSFILE
}

# Scanning ports
runFULLScan(){	
	if [[ -f $IPSFILE ]]; then
		# scanning ports
		cat $IPSFILE | ( while read hostname; do nmap -sS -Pn --top-ports 10 -oA Syn_$hostname $hostname; done;)
		# get ports
		cat $IPSFILE | ( while read hostname; do cat Syn_$hostname.nmap | grep open |  cut -d " " -f1 | 
			cut -d "/" -f1 | sed ':a;N;$!ba;s/\n/,/g' > puertos_Segmento$hostname.txt; done;)

		
		echo " == Hosts and Ports == "
		# print hosts and ports
		cat $IPSFILE | ( while read hostname; do echo "$hostname: "; 
			printf '\t%s\n' "$(<puertos_Segmento$hostname.txt)"; done;)
	else
		echo "$IPSFILE was not found, please run Fast Network Scanning"

		
	fi
}

# --------------------------------
# 			Main Program
# --------------------------------
clear

isROOT

echo "Run as root"

cleaningLOGS
fastNTScan
runFULLScan

echo "exit"
