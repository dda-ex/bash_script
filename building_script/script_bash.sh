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

	printMenu
	
	echo " == Logs cleaned up == "
}

# Print Menu
printMenu(){
	clear
	echo -e "Introduction to BASH\n"
	echo "	1) Cleaning Logs "
	echo "	2) Fast Network Scan "
	echo -e "	3) Scan Targets \n"
	echo -e "	99) Exit\n"
	echo "IP Address: " $IPADD	
}

# Scanning ports
fastNTScan(){	
	read -p " Enter a range of IP {192.168.0.0/24,192.168.0.0} : " target
	
	if [[ -f  $IPSFILE ]]; then
		rm $IPSFILE 
	fi
	
	masscan $target --ping --open-only | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" > $IPSFILE
	
	printMenu
	
	echo " == Hosts alive == "
	cat $IPSFILE
}

# Scanning ports
runFULLScan(){	
	if [[ -f $IPSFILE ]]; then
		# scanning ports
		cat $IPSFILE | ( while read hostname; do nmap -sS -Pn --top-ports 10 -oA Syn_$hostname $hostname; done;)
		# get ports
		cat $IPSFILE | ( while read hostname; do cat Syn_$hostname.nmap | grep open |  cut -d " " -f1 | cut -d "/" -f1 | sed ':a;N;$!ba;s/\n/,/g' > puertos_Segmento$hostname.txt; done;)
		
		printMenu
		
		echo " == Hosts and Ports == "
		# print hosts and ports
		cat $IPSFILE | ( while read hostname; do echo "$hostname: "; printf '\t%s\n' "$(<puertos_Segmento$hostname.txt)"; done;)
	else
		echo "$IPSFILE was not found, please run Fast Network Scanning"
	fi
}

# --------------------------------
# 			Main Program
# --------------------------------
isROOT
if [[ $? -ne 0 ]]; then
	exit
fi

printMenu
while [[ true ]]; do
	read -p " Option: " FUN 	
	
	case "$FUN" in
		1)  cleaningLOGS
		;;
		
		2)  fastNTScan
		;;
		
		3)  runFULLScan
		;;
		
		99) exit;;
		
		*)  echo "Invalid Option";;
	esac
done
