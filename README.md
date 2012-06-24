Overview
========

This Chef repository is designed to dynamically create and deploy a Hadoop cluster using 
virtual machines. The basic install script [script name] is used to create the cluster 
with a pre-set number of initial nodes.

Prerequisites
=============
You must have a DHCP and DNS server running so that the nodes can find each other. 
You must also be running VMWare workstation (or vCenter) in order to use the setup scripts
to automatically clone the nodes.

You must also have a configured Chef workstation that you can set up to communicate with 
the Chef server.

Environment
===========
This uses a pre-built VMs running Ubuntu 12.04, 64-bit. The hadoop-master VM is also the
Chef server. As this is designed to be a stand-alone proof-of-concept, it is not designed
to be deployed into an existing Chef environment out of the box. This can be done by 
editing the server_url attribute in roles/base.js and updating the chef-client 
configuration within the hadoop-slave VM template before cloning the VM.

This can also be deployed to already existing Ubuntu nodes by simply applying the 
base and hadoop-slave roles to the node, and editing and updating the slaves.rb file with
the list of hadoop slaves.

There is currently no support for other platforms.

Usage (Pre-built VM templates)
==============================
First, boot the hadoop-master template and configure your Chef workstation to use this
as the Chef server. Once this is complete, run the [install tool] utility to deploy the
Hadoop cluster using the supplied Ubuntu VMWare templates. You will need at least 1 slave
node in order to use Hadoop as the master node does not run the DataNode or JobTracker
services.

Usage (Custom)
==============================
If you don't want to use the supplied templates, you can use the supplied scripts to build
your cluster by hand:

install-chef.sh: This will install the Chef binares on the system. It can do both server 
				 and client installs. Only supported on Debian-based systems. Client 
				 install requires a configured Chef server first.
				 
create-roles-and-nodes.sh:	This will create all the required roles and nodes on the 
							Chef server. Requires a configured Chef workstation and server
							
create-hadoop-slave.sh:	This will create new Hadoop slave node. It will need to be 
						modified by hand if different VM templates are desired, or if you
						don't want to cloe a template at all. Requires a configured Chef
						workstation and server.