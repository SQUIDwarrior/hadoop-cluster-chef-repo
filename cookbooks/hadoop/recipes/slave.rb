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

# Install the slave processes.
package "hadoop-0.20-datanode" do
  action :install
  version node[:Hadoop][:Version]
  options "--force-yes"
end

package "hadoop-0.20-tasktracker" do
  action :install
  version node[:Hadoop][:Version]
  options "--force-yes"
end

cookbook_file "/tmp/buildHadoopDisks.sh" do
  source "buildHadoopDisks.sh"
  owner "root"
  group "root"
  backup false
  mode "0755"
end

execute "buildHadoopDisks" do
  command "/tmp/buildHadoopDisks.sh"
  action :run
end

# For now just assume a simple 2-disk configuration
if File.exist?("/data/b")
   node.set['Hadoop']['HDFS']['dfsDataDir'] = [ "/data/b/dfs/data" ]
   node.set['Hadoop']['Mapred']['mapredLocalDir'] = [ "/data/b/mapred/local" ]
elsif File.exist?("/data/a")
   node.set['Hadoop']['HDFS']['dfsDataDir'] = [ "/data/a/dfs/data" ]
   node.set['Hadoop']['Mapred']['mapredLocalDir'] = [ "/data/a/mapred/local" ]
else
   node.set['Hadoop']['HDFS']['dfsDataDir'] = [ "/data/a/dfs/data" ]
   node.set['Hadoop']['Mapred']['mapredLocalDir'] = [ "/data/a/mapred/local" ]
end

node[:Hadoop][:HDFS][:dfsDataDir].each do |dataDir|
  directory dataDir do
    owner "hdfs"
    group "hadoop"
    mode "0755"
    recursive true
    action :create
  end
end

node[:Hadoop][:Mapred][:mapredLocalDir].each do |localDir|
  directory localDir do
    owner "mapred"
    group "hadoop"
    mode "0755"
    recursive true
    action :create
  end
end

# Create and start the slave services.
service "hadoop-0.20-datanode" do
  action [ :enable, :start ]
  running true
  supports :status => true, :start => true, :stop => true, :restart => true
end

service "hadoop-0.20-tasktracker" do
  action [ :enable, :start ]
  running true
  supports :status => true, :start => true, :stop => true, :restart => true
end

#Set the masters file and restart the services if needed
template "/etc/hadoop/conf/masters" do
  owner "root"
  group "hadoop"
  mode "0644"
  source "masters.erb"
  notifies :restart, resources(:service => "hadoop-0.20-datanode")
  notifies :restart, resources(:service => "hadoop-0.20-tasktracker")
end
