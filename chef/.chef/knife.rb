cookbook_path    ["cookbooks", "site-cookbooks"]
node_path        "nodes"
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"

log_level                :info
log_location             STDOUT

knife[:berkshelf_path] = "cookbooks"


current_dir = File.dirname(__FILE__)

