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

package "hadoop-0.20-namenode" do
  action :install
  version node[:Hadoop][:Version]
  options "--force-yes"
end

template "/etc/hadoop/conf/dfs.hosts.exclude" do
  owner "root"
  group "hadoop"
  mode "0644"
  source "dfs.hosts.exclude.erb"
end

if File.exist?("/data/b")
   node.set['Hadoop']['HDFS']['dfsNameDir'] = [ "/data/b/dfs/name" ]
elsif File.exist?("/data/a")
   node.set['Hadoop']['HDFS']['dfsNameDir'] = [ "/data/a/dfs/name" ]
else
   node.set['Hadoop']['HDFS']['dfsNameDir'] = [ "/data/a/dfs/name" ]
end


# For now you'll need to run 'hadoop namenode -format' manually until I learn
# more Ruby and Chef semantics to make it safe.  Here we make sure the
# directory BELOW dfs.name.dir has the proper permissions as the above command
# like to create it itself.
node[:Hadoop][:HDFS][:dfsNameDir].each do |nameDir|
  directory nameDir do
    owner "hdfs"
    group "hadoop"
    mode "0755"
    recursive false
    action :create
  end
end

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

service "hadoop-0.20-namenode" do
  action [ :enable, :start ]
  running true
  supports :status => true, :start => true, :stop => true, :restart => true
end


