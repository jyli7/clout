class Node
	attr_accessor :name
	attr_reader :follower_names, :followee_names

	def initialize(name)
		@name = name
		@follower_names = []
		@followee_names = []
	end

	def add_followee!(followee)
		@followee_names.push(get_name(followee))
	end

	def remove_followee!(followee)
		@followee_names.delete(get_name(followee))
	end

	def add_follower!(follower)
		@follower_names.push(get_name(follower))
	end

	def remove_follower!(follower)
		@follower_names.delete(get_name(follower))
	end

	def has_followees?
		!@followee_names.empty?
	end

	def has_followee?(followee)
		@followee_names.include?(get_name(followee))
	end

	def has_followers?
		!@follower_names.empty?
	end

	def has_follower?(follower)
		@follower_names.include?(get_name(follower))
	end

	private

		def get_name(name_or_node)
			if name_or_node.is_a?(Node)
				name_or_node.name
			elsif name_or_node.is_a?(String)
				name_or_node
			else
				raise "Argument is neither name nor node"
			end
		end

end
