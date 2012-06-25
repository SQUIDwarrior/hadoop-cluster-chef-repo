#!/bin/bash

# Configures the Chef workstation (supported on Mac OS X, Debian, and Red Hat Linux)
# 
# Prerequisites:
# - Ruby 1.9 installed
# - Git installed
# - Configured Chef server


# Install Chef gem
chefInstalled=`gem list | grep chef`

if [ "$chefInstalled" == "" ]; then
	echo "Installing chef gem..."
	sudo gem install chef --no-ri --no-rdoc

	if [ "$?" == 1 ]; then
		echo "Install of Chef gem failed. Aborting..."
		exit 1
	fi
else
	echo "Chef gem detected. Continuing..."
fi

# Create config directory
configDir=~/.chef
mkdir $configDir

# Configure knife
knife configure

# Copy validation keys from server
echo "Preparing to copy validation keys from chef server."
echo "Enter name of chef server:"
read chefServer
username=`grep node_name ~/.chef/knife.rb | awk -F\' '{print $2}'`
scp $username@$chefServer:/home/$username/.chef/*.pem $configDir

if [ "$?" == 1 ]; then
	echo "Failed to copy validation keys from server. Aborting..."
	exit 1
fi

echo "Testing knife configuration..."
if [ "`knife client list | grep $username`" == "" ]; then
	echo "FAILED!"
else
	echo "PASSED!"
fi