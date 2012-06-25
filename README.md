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
Chef server. Both master and slave templates are set up with a single admin user "hduser"
with a password of "hduser".


As this is designed to be a stand-alone proof-of-concept, it is not designed
to be deployed into an existing Chef environment out of the box. This can be done by 
editing the server_url attribute in roles/base.js and updating the chef-client 
configuration within the hadoop-slave VM template before cloning the VM.

This can also be deployed to already existing Ubuntu nodes by simply applying the 
base and hadoop-slave roles to the node, and editing and updating the slaves.rb file with
the list of hadoop slaves.

There is currently no support for other platforms.

Usage (Pre-built VM templates)
==============================
The hadoop-master template contains a pre-configured installation of Chef server, as 
well as running a master Hadoop node. Once it is online, all that is needed is to 
configure your workstation by running the "configure-chef-workstation.sh" script. No 
further configuration is needed until you are ready to deploy the cluster.

To deploy the slave cluster, ensure you have started the hadoop-master VM and configured
your workstation as stated above. Once this is complete, run the [install tool] utility to 
deploy the Hadoop cluster using the supplied Ubuntu VMWare template. You will need at 
least 1 slave node in order to use Hadoop as the master node does not run the DataNode or 
TaskTracker services.

Once the utility has completed, it may take some time for the cluster to come fully 
online. You can view the cluster status at http://hadoop-master:50070/

Usage (Custom)
==============================
If you don't want to use the supplied templates, you can use the supplied scripts to build
your cluster by hand:

install-chef.sh: This will install the Chef binares on the system. It can do both server 
				 and client installs. Only supported on Debian-based systems. Client 
				 install requires a configured Chef server first. Requires sudo.
				 
create-roles-and-nodes.sh:	This will create all the required roles and nodes on the 
							Chef server. Requires a configured Chef workstation and server
							
create-hadoop-slave.sh:	This will create new Hadoop slave node. It will need to be 
						modified by hand if different VM templates are desired, or if you
						don't want to cloe a template at all. Requires a configured Chef
						workstation and server.
						
						
Acknowledgements
================
This project uses several third-party Chef cookbooks:

apt 		http://community.opscode.com/cookbooks/apt
ruby 		http://community.opscode.com/cookbooks/ruby
java 		http://community.opscode.com/cookbooks/java
ntp			http://community.opscode.com/cookbooks/ntp
chef-client http://community.opscode.com/cookbooks/chef-client
hadoop		https://github.com/nmilford/cookbooks/tree/master/hadoop
																	