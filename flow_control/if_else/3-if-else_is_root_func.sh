#!/bin/bash

check_if_root() {
	if [[ $EUID -ne $ROOT_UID ]]; then
		return 0
	fi
		return 1
}

if check_if_root; then
	echo "User is root!"
else
	echo "User is not root!"
fi
