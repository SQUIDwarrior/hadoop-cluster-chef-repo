Hadoop Cookbook
===============

Builds a working Hadoop cluster using Ubuntu VMs.

Based on the original cookbook by Nathan Milford: https://github.com/nmilford/cookbooks/tree/master/hadoop

Requirements
============

Built & tested using VMWare and Ubuntu templates. Results may vary elsewhere.

ATTRIBUTES
==========

See the attributes directory.  All of the basic settings you might use to tweak your hadoop cluster are avaliable there.

To start you'll want to adjust

* attributes/core-site.rb: default[:Hadoop][:Core][:fsDefaultName]

* attributes/hadoop-env.rb default[:Hadoop][:Env][:HADOOP_HEAPSIZE]

* attributes/hdfs-site.rb default[:Hadoop][:HDFS][:dfsSecondaryHttpAddress]

* attributes/mapred-site.rb default[:Hadoop][:Mapred][:mapredJobTracker]


USAGE
=====

Add the default recipe to any host you only want hadoop libs and config on.

Add any other if you want a node to have a specific function (e.g. master or slave)


LICENSE & AUTHOR
================

Original Author: Nathan Milford <nathan@outbrain.com>

Copyright: &copy; 2011, Outbrain, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
