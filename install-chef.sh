#!/bin/bash

# Install Chef onto an Debian based system (tested on Ubuntu 12.04)
# This does not need to be run if using the pre-built Ubuntu templates supplied
# with this repository.

function installChefCore() {
    echo "Installing Opscode repository..."
	echo "deb http://apt.opscode.com/ `lsb_release -cs`-0.10 main" | tee /etc/apt/sources.list.d/opscode.list
	echo "Adding GPG key..."
	mkdir -p /etc/apt/trusted.gpg.d
	gpg --keyserver keys.gnupg.net --recv-keys 83EF826A
	gpg --export packages@opscode.com | tee /etc/apt/trusted.gpg.d/opscode-keyring.gpg > /dev/null
	echo "Updating apt..."
	apt-get update
	echo "Installing opscode-keyring..."
	apt-get install opscode-keyring
}

function installChefServer() {
	installChefCore
	echo "Installing chef-server..."
	apt-get install chef chef-server -y
}

function installChefClient() {
	installChefCore
	echo "Installing chef-client..."
	apt-get install chef -y
	echo "Updating time..."
	ntpdate 0.pool.ntp.org
	echo "Copying validation.pem from Chef server..."
	echo "Enter the name or IP of the Chef server:"
	read chefServer
	echo "Enter the Chef server username:"
	read userName
	scp $userName@$chefServer:/etc/chef/validation.pem /etc/chef/validation.pem
}

type=client
if [ "$1" == "server" ]; then
	echo "Installing Chef server (and client)"
	installChefServer
elif [ "$1" == "client" ]; then
	echo "Installing Chef client only"
	installChefClient
else
	echo "Usage: install-chef.sh client|server"
	exit 1
fi

exit 0
