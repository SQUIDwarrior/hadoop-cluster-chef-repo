# Copyright 2011, Outbrain, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Install the namenode and jobtracker packages
package "hadoop-0.20-namenode" do
  action :install
  version node[:Hadoop][:Version]
  options "--force-yes"
end
package "hadoop-0.20-jobtracker" do
  action :install
  version node[:Hadoop][:Version]
  options "--force-yes"
end

template "/etc/hadoop/conf/fair-scheduler.xml" do
  owner "root"
  group "hadoop"
  mode "0644"
  source "fair-scheduler.xml.erb"
end

template "/etc/hadoop/conf/dfs.hosts.exclude" do
  owner "root"
  group "hadoop"
  mode "0644"
  source "dfs.hosts.exclude.erb"
end

# For now just assume a simple 2-disk configuration
if File.exist?("/data/b")
   node.set['Hadoop']['HDFS']['dfsNameDir'] = [ "/data/b/dfs/name" ]
elsif File.exist?("/data/a")
   node.set['Hadoop']['HDFS']['dfsNameDir'] = [ "/data/a/dfs/name" ]
else
   node.set['Hadoop']['HDFS']['dfsNameDir'] = [ "/data/a/dfs/name" ]
end


# Format the namenode, if needed
# 
# First create the HDFS directory structure
node[:Hadoop][:HDFS][:dfsNameDir].each do |nameDir|
  directory nameDir do
    owner "hdfs"
    group "hadoop"
    mode "0755"
    recursive false
    action :create
  end
end
# Then format the filesystem, if it hasn't already been done
if !File.exist?("/etc/hadoop/conf/formated")  
  execute "formatHDFS" do
    command "hadoop namenode -format -force"
    user "hdfs"
    action :run
  end
  
  file "/etc/hadoop/conf/formated" do
    owner "hdfs"
    group "hadoop"
    mode "0755"
    action :create_if_missing
  end
end

# Create the mapred directory structure
node[:Hadoop][:Mapred][:mapredLocalDir].each do |localDir|
  directory localDir do
    owner "mapred"
    group "hadoop"
    mode "0755"
    recursive true
    action :create
  end
end

# create the services
service "hadoop-0.20-namenode" do
  action [ :enable, :start ]
  running true
  supports :status => true, :start => true, :stop => true, :restart => true
end
service "hadoop-0.20-jobtracker" do
  action [ :enable, :start ]
  running true
  supports :status => true, :start => true, :stop => true, :restart => true
end

#Set the slaves file and restart the services if needed
template "/etc/hadoop/conf/slaves" do
  owner "root"
  group "hadoop"
  mode "0644"
  source "slaves.erb"
  notifies :restart, resources(:service => "hadoop-0.20-namenode")
  notifies :restart, resources(:service => "hadoop-0.20-jobtracker")
end

