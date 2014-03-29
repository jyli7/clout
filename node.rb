class Node
	attr_accessor :name
	attr_reader :followers, :followees

	def initialize(name)
		@name = name
		@followers = []
		@followees = []
	end

	def follow!(node)
		if has_followees?
			unfollow!(first_followee)
		end
		add_followee!(node)
		node.add_follower!(self)
	end

	def unfollow!(node)
		remove_followee!(node)
		node.remove_follower!(self)
	end

	def has_followees?
		!@followees.empty?
	end

	def has_followee?(followee)
		@followees.include?(followee)
	end

	def has_followers?
		!@followers.empty?
	end

	def has_follower?(follower)
		@followers.include?(follower)
	end

	def extended_follower_count
		frontier = followers
		extended_follower_count = 0
		next_level = []

		while (frontier.length > 0)
			extended_follower_count += frontier.count
			frontier.each do |follower|
				follower.followers.each do |next_level_follower|
					next_level.push(next_level_follower)
				end
			end
			frontier = next_level
			next_level = []
		end

		extended_follower_count
	end

	protected

		# Followees
		def add_followee!(followee)
			@followees.push(followee)
		end

		def remove_followee!(followee)
			@followees.delete(followee)
		end

		def add_follower!(follower)
			@followers.push(follower)
		end

		def remove_follower!(follower)
			@followers.delete(follower)
		end

		# Useful only because we restrict followee count to 1
		def first_followee
			@followees.first
		end
end
