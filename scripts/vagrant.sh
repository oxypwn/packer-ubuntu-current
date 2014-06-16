#!/bin/bash

# Add user if it not already exists
id vagrant
if [ "$?" == 1 ]; then
	groupadd vagrant
	groupadd permit_ssh_in
	useradd -m -g vagrant -G docker,sudo,permit_ssh_in -s /bin/bash vagrant
else
	# Setup sudo to allow no-password sudo for "sudo"
	usermod -a -G sudo vagrant
fi

# Set up sudo
echo %vagrant ALL=NOPASSWD:ALL > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# Installing vagrant keys
sudo -u vagrant sh -c 'export HOME="/home/vagrant" && curl -s ssh.keychain.io/letters@paulnotcom.se/vagrant/install | bash'

# Install NFS for Vagrant
apt-get update
apt-get install -y nfs-common
