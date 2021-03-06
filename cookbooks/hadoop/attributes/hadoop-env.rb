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

# Settings for /etc/hadoop/conf/hadoop-env.sh

default[:Hadoop][:Env][:HADOOP_HEAPSIZE] = 6144
default[:Hadoop][:Env][:HADOOP_NAMENODE_OPTS] = ""
default[:Hadoop][:Env][:HADOOP_SECONDARYNAMENODE_OPTS] = ""
default[:Hadoop][:Env][:HADOOP_DATANODE_OPTS] = ""
default[:Hadoop][:Env][:HADOOP_JOBTRACKER_OPTS] = ""
default[:Hadoop][:Env][:HADOOP_TASKTRACKER_OPTS] = ""
default[:Hadoop][:Env][:HADOOP_LOG_DIR] = "/var/lib/hadoop-0.20/logs"
default[:Hadoop][:Env][:JAVA_HOME] = "/usr/lib/jvm/java-6-openjdk-amd64/jre"