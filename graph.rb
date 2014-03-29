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
end
