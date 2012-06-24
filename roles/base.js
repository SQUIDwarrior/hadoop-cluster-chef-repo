{
  "name": "base",
  "description": "",
  "json_class": "Chef::Role",
  "default_attributes": {
  },
  "override_attributes": {
    "languages": {
      "ruby": {
        "default_version": "1.9.1"
      }
    }
  },
  "chef_type": "role",
  "run_list": [
    "recipe[apt]",
    "recipe[ntp]",
    "recipe[ruby]",
    "recipe[ruby::symlinks]"
  ],
  "env_run_lists": {
  }
}
