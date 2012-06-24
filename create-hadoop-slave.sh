#!/bin/bash

# Create a new hadoop slave node
#
# Steps:
#
# 1. Clone hadoop slave VM template
# 2. Start new VM to auto-configure hostname using "hadoop-slave-template"
#    node configuration, which shuts down the node after one-time run. This
#    also updates the slaves file.
# 3. Create new nodes using knife, giving it the "base" and "hadoop-slave" roles
# 4. Update the hadoop cookbook using knife (force a rerun of chef-client on master)
#    to ensure it has the latest slaves file.
# 5. Boot the updated VM to install and configure hadoop



function cloneNode() {
	echo "Clone not yet implemented";
}

function startNode() {
	echo "Start not yet implemented";
}

function createHostname() {
	echo hadoop-slave-`date "+%Y%m%d%H%M%S"`
}

function createSlaveNode() {
	# Create new new hostname
	newHostname=`createHostname`
	echo "New slave will be $newHostname"
	
	# Set the 'set_fqdn' attribute of the hadoop-slave-template node
	# This will cause the node to acquire it's new hostname
    knife exec -E "nodes.find(:name => 'hadoop-slave-template') {|n| n.set['sef_fqdn'] = '$newHostname' ; n.save }"
	
	#Create the new node in chef
	knife node create $newHostname --disable-editing
	knife node run_list add $newHostname "role[base]"
	knife node run_list add $newHostname "role[hadoop-slave]"
	
	#Clone the node
	cloneNode
	
	#Start the node
	startNode
}


echo "Creating new hadoop slave node..."
createSlaveNode 


