#!/bin/bash

if [ -z "$PASSWORD" ]; then
	echo PASSWORD environment variable is missing
	exit 1
fi

echo root:$PASSWORD | chpasswd

exec /usr/sbin/sshd -D
