#!/bin/bash

# Create a new hadoop slave node

function cloneNode() {	
	echo "Clone not yet implemented";
}

function createHostname() {
	echo hadoop-slave-`date "+%Y%m%d%H%M%S"`
}

function createNewSlaveNode() {
	# Create new new hostname
	local newHostname=`createHostname`
	
	echo "Creating new slave node $newHostname..."
	
	# Create the new node in chef
	knife node create $newHostname --disable-editing
	echo "Adding role 'base' to $newHostname..."
	knife node run_list add $newHostname "role[base]"
	echo "Adding role 'hadoop-slave' to $newHostname..."
	knife node run_list add $newHostname "role[hadoop-slave]"
	echo "Updating hadoop slaves file..."
	echo ",\"$newHostname\"" >> cookbooks/hadoop/attributes/slaves.rb
	echo "Uploading the file to the server..."
	knife cookbook upload hadoop
	
	# Clone the node
	cloneNode $newHostname
}

createNewSlaveNode 


