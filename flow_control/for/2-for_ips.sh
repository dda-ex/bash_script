#!/bin/bash

for ip in $(seq 1 254); do
	echo "172.16.10${ip}" >> ip_172-16-10-hosts.txt
done
