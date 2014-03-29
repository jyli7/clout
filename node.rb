class Node
	attr_accessor :name
	attr_reader :follower_names, :followee_name

	def initialize(name)
		@name = name
		@follower_names = []
		@followee_name = nil
	end

	def follow!(followee)
		@followee_name = get_name(followee)
	end

	def unfollow!(followee)
		followee_name = get_name(followee)
		if self.has_followee?(followee)
			@followee_name = nil
		end
	end

	def add_follower!(follower)
		@follower_names.push(get_name(follower))
	end

	def remove_follower!(follower)
		@follower_names.delete(get_name(follower))
	end

	def has_followee?(followee = nil)
		if followee
			self.followee_name == get_name(followee)
		else
			self.followee_name
		end
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
