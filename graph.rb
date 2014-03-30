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
			nodes[node_name] = node
		end
		node
	end

	def find_node_by_name(node_name)
		nodes[node_name]
	end

	def find_or_add_node_by_name!(node_name)
		find_node_by_name(node_name) || add_node_by_name!(node_name)
	end

	def node_objects
		nodes.values
	end

	def sorted_clout_hashes
		name_to_clout_hashes = []
		
		nodes.each_pair do |node_name, node|
			name_to_clout_hashes.push({node_name => node.clout})
		end
		
		name_to_clout_hashes.sort_by do |name_to_clout_hash|
			name_to_clout_hash.values[0]
		end.reverse

	end

end
