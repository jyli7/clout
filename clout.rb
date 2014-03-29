require_relative 'node'
require_relative 'graph'

FOLLOWS_REGEX = /^(.*) follows (.*)$/
CLOUT_REGEX = /^clout (.*)$/

graph = Graph.new

while input = gets
	puts "*******"
	if match_data = FOLLOWS_REGEX.match(input)
		follower_name = match_data[1]
		followee_name = match_data[2]
		follower = graph.find_or_add_node_by_name!(follower_name)
		followee = graph.find_or_add_node_by_name!(followee_name)
		follower.follow!(followee)
		# Exception handling here
		puts "OK!"
	elsif match_data = CLOUT_REGEX.match(input)
		node_name = match_data[1]
		node = graph.find_or_add_node_by_name!(node_name)
		clout = node.clout
		if clout == 1
			puts "#{node.name} has #{clout} follower"
		else
			puts "#{node.name} has #{clout} followers"
		end
	end
end