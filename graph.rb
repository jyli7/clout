class Graph
	attr_reader :nodes

	def initialize
		@nodes = {}
	end

	def add_node_by_name!(node_name)
		if find_node_by_name(node_name)
			raise "Node already exists"
		else
			node = Node.new(node_name)
			@nodes[node_name] = node
		end
	end

	def find_node_by_name(node_name)
		@nodes[node_name]
	end

	def find_or_add_node_by_name(node_name)
		self.find_node_by_name(node_name) || self.add_node_by_name!(node_name)
	end

	# Move this into the Node class!
	def establish_relationship!(args)
		follower_node = self.find_or_add_node_by_name(args[:follower_name])
		followee_node = self.find_or_add_node_by_name(args[:followee_name])

		# The graph, not the node, enforces the fact that a node can only have 1 followee
		if follower_node.has_followees?
			self.destroy_relationship!({follower_name: follower_node.name,
																 	followee_name: follower_node.first_followee_name})
		end

		follower_node.add_followee!(followee_node)
		followee_node.add_follower!(follower_node)
	end

	def destroy_relationship!(args)
		follower_node = self.find_node_by_name(args[:follower_name])
		followee_node = self.find_node_by_name(args[:followee_name])

		raise "Follower does not exist" if follower_node.nil?
		raise "Followee does not exist" if followee_node.nil?

		follower_node.remove_followee!(followee_node)
		followee_node.remove_follower!(follower_node)
	end

	def extended_follower_count_of(node_name)
		node = self.find_node_by_name(node_name)
		return 0 if node.nil?
		frontier_names = node.follower_names
		extended_follower_count = 0
		next_level_names = []

		while (frontier_names.length)
			result += frontier_names.count
			frontier_names.each do |follower_name|
				extended_follower_count += 1
				follower_node = self.find_node_by_name(follower_name)
				followee_node.follower_names.each do |next_follower_name|
					next_level_names.push(next_follower_name)
				end
			end
			frontier_names = next_level_names
		end
	end
end
