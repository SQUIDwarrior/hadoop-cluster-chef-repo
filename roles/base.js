{
  "name": "base",
  "description": "Base role applied to all nodes",
  "json_class": "Chef::Role",
  "default_attributes": {
  },
  "override_attributes": {
    "languages": {
      "ruby": {
        "default_version": "1.9.1"
      }
    },
    "chef_client" => {
    	"init_style" => "init"
  	}
  },
  "chef_type": "role",
  "run_list": [
    "recipe[apt]",
    "recipe[chef-client::config]",
    "recipe[chef-client::service]",
    "recipe[ntp]",
    "recipe[ruby]",
    "recipe[ruby::symlinks]"
  ],
  "env_run_lists": {
  }
}