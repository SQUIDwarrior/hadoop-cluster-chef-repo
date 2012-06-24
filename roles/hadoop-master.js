{
  "name": "hadoop-master",
  "description": "",
  "json_class": "Chef::Role",
  "default_attributes": {
  },
  "override_attributes": {
  },
  "chef_type": "role",
  "run_list": [
    "recipe[java]",
    "recipe[hadoop]",
    "recipe[hadoop::master]",
    "recipe[hadoop::secondarynamenode]"
  ],
  "env_run_lists": {
  }
}
