#!/bin/bash
# This script will ping any address provided as argument
# Execution ./2-read-from-arguments.sh 192.168.234.87

SCRIPT_NAME="${0}"
TARGET="${1}"

echo "Runing the script ${SCRIPT_NAME}..."
echo "Pinging the target: ${TARGET}..."
ping "${TARGET}"
