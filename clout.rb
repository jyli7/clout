require_relative 'node'
require_relative 'graph'

def prompt(prompt_msg)
  print(prompt_msg)
  gets
end

def follows_regex
	/^(.*) follows (.*)$/
end

def clout_regex
	/^clout (.*)$/
end

def clout_global_regex
	/^clout\s*$/
end

def exit_regex
	/^exit\s*$/
end

def print_clout(node)
	clout = node.clout
	if clout == 0
		puts "#{node.name} has no followers"
	elsif clout == 1
		puts "#{node.name} has #{clout} follower"
	else
		puts "#{node.name} has #{clout} followers"
	end
end

def print_invalid_input_msg
	puts "That's not a valid input.\n\n"
	puts "Valid inputs:"
	puts "Person_1 follows Person_2"
	puts "clout Person_2"
	puts "clout"
	puts "\n"
end

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

