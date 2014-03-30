def prompt(prompt_msg)
  STDOUT.print(prompt_msg)
  STDIN.gets
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

def print_clout_for(name, clout)
	if clout == 0
		STDOUT.puts "#{name} has no followers"
	elsif clout == 1
		STDOUT.puts "#{name} has #{clout} follower"
	else
		STDOUT.puts "#{name} has #{clout} followers"
	end
end

def print_invalid_input_msg
	STDOUT.puts "That's not a valid input.\n\n"
	STDOUT.puts "Valid inputs:"
	STDOUT.puts "Person_1 follows Person_2"
	STDOUT.puts "clout Person_2"
	STDOUT.puts "clout"
	STDOUT.puts "\n"
end