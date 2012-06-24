#!/bin/bash

function createRoles() {
	knife role from file roles/base.js;
	knife role from file roles/hadoop-master.js;
	knife role from file roles/hadoop-slave.js;
}

function createNodes() {
	knife node from file nodes/hadoop-master.js;
	knife node from file nodes/hadoop-slave-template.js;
}