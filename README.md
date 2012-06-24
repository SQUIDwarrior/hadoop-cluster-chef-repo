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

Environment
===========
This uses a pre-built VMs running Ubuntu 12.04, 64-bit. The hadoop-master VM is also the
Chef server. As this is designed to be a stand-alone proof-of-concept, it is not designed
to be deployed into an existing Chef environment. This can be done, however the cookbooks
will need to be updated with the correct Chef server URL, and the VM templates modified
so that the chef-client daemons look for the right server as well. 