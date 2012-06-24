#!/bin/bash

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