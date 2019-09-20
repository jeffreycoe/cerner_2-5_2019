# cerner_2^5_2019
# Retrieves run list from Chef Server on node
require 'chef'
require 'chef/config_fetcher'
require 'chef/node'

# Variable Declaration
config_file = 'c:/chef/client.rb'

# Load Chef Config from client.rb config file
chef_config = Chef::Config
config_fetcher = Chef::ConfigFetcher.new(config_file)
raw_config = config_fetcher.read_config
chef_config.from_string(raw_config, config_file)
Chef::Config[:node_name] = ::Socket.gethostbyname(::Socket.gethostname).first

# Pull list of cookbooks in run list from node object on Chef Server
node = Chef::Node.load(Chef::Config[:node_name])
run_list_items = node.run_list.run_list_items
run_list_items.each { |i| puts "Run List Item: #{i.name} Type: #{i.type}" }

# Output to JSON
puts "Run List JSON Data: #{run_list_items.to_json}"
