#!/bin/bash

# This script creates the required Chef roles and nodes needed to deploy the Hadoop 
# cluster. This does not need to be run if using the pre-built Ubuntu templates supplied
# with this repository.

function createRoles() {
	echo "Creating roles..."
	knife role from file roles/base.js;
	knife role from file roles/hadoop-master.js;
	knife role from file roles/hadoop-slave.js;
	
}

function createNodes() {
	echo "Creating nodes..."
	knife node from file nodes/hadoop-master.js;
}

createRoles
createNodes