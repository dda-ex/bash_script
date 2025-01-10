#!/bin/bash

# Variables
LOG_DIR=/root/Documents/flisol
#LOG_DIR=/var/log

clear

# Clean logs
cat /dev/null > $LOG_DIR/messages
cat /dev/null > $LOG_DIR/wtmp
echo " == Logs cleaned up == "
