require_relative 'node'
require_relative 'graph'
require_relative 'helpers'

graph = Graph.new

while input = prompt('> ')
	if match_data = follows_regex.match(input)
		begin
			follower_name = match_data[1]
			followee_name = match_data[2]
			follower = graph.find_or_add_node_by_name!(follower_name)
			followee = graph.find_or_add_node_by_name!(followee_name)
			follower.follow!(followee)
			puts "OK!"
		rescue Exception => msg
			puts msg
		end
	elsif match_data = clout_regex.match(input)
		node_name = match_data[1]
		node = graph.find_or_add_node_by_name!(node_name)
		print_clout(node)
	elsif clout_global_regex.match(input)
		if graph.node_objects.empty?
			puts "No people in the system yet"
		else
			graph.node_objects.each do |node|
				print_clout(node)
			end
		end
	elsif exit_regex.match(input)
		puts "Thanks for playing!"
		break
	else
		print_invalid_input_msg
	end
end

