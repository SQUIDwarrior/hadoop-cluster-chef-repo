{
  "name": "hadoop-slave-template",
  "chef_environment": "_default",
  "normal": {
  	"set_fqdn": "hadoop-slave-template"
  },
  "run_list": [
    "role[base]",
    "recipe[hostname]"
  ]
}