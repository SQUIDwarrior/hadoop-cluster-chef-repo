{
  "name": "hadoop-slave",
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
    "recipe[hadoop::slave]"
  ],
  "env_run_lists": {
  }
}
