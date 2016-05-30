#!/bin/bash

if [ -z "$PASSWORD" ]; then
	echo PASSWORD environment variable is missing
	exit 1
fi

echo changing root password...
echo root:$PASSWORD | chpasswd

echo generating ssh key...
dpkg-reconfigure openssh-server

echo starting sshd...
exec /usr/sbin/sshd -D
