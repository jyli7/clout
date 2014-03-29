require 'spec_helper'

describe Node do
	before :each do
		@normal_node = Node.new('Bob')
		@leader_node = Node.new('Boss')
	end

	describe "#new" do
		it "takes one parameter and returns a Node instance" do
			@normal_node.should be_an_instance_of Node
		end
	end

	describe "#name" do
		it "returns the name of the node" do
			@normal_node.name.should eql @normal_node.name
		end
	end

	context "adding and removing relationships" do
		describe "#follow!" do
			it "adds the followee to the follower" do
				@normal_node.follow!(@leader_node)
				@normal_node.followees.should eq [@leader_node]
			end

			it "adds the follower to the followee" do
				@normal_node.follow!(@leader_node)
				@leader_node.followers.should eq [@normal_node]
			end

			context "if the follower has a pre-existing followee" do
				before :each do
					@old_leader = Node.new('Old Boss')
					@normal_node.follow!(@old_leader)
				end

				it "swaps the old followee for the new followee, on the follower" do
					@normal_node.followees.should eq [@old_leader]
					@normal_node.follow!(@leader_node)
					@normal_node.followees.should eq [@leader_node]
				end

				it "removes the follower from the old followee" do
					@old_leader.followers.should eq [@normal_node]
					@normal_node.follow!(@leader_node)
					@old_leader.followers.should eq []
				end
			end
		end

		describe "#unfollow" do
			before :each do
				@normal_node.follow!(@leader_node)
			end

			it "removes the followee from the follower" do
				@normal_node.followees.should eq [@leader_node]
				@normal_node.unfollow!(@leader_node)
				@normal_node.followees.should eq []
			end

			it "removes the follower from the followee" do
				@leader_node.followers.should eq [@normal_node]
				@normal_node.unfollow!(@leader_node)
				@leader_node.followers.should eq []
			end

			it "does nothing if passed in someone the node was never following" do
				@isolated_node = Node.new("Lonely")
				@normal_node.unfollow!(@isolated_node)
				@leader_node.followers.should eq [@normal_node]
				@normal_node.followees.should eq [@leader_node]
			end
		end
	end

	context "querying the status of relationships" do
		describe "#has_followees?" do
			before :each do
				@normal_node.follow!(@leader_node)
			end

			it "returns true if the node has any followees" do
				@normal_node.has_followees?.should be_true
			end

			it "returns false otherwise" do
				@normal_node.unfollow!(@leader_node)
				@normal_node.has_followees?.should be_false
			end
		end

		describe "#has_followee?" do
			before :each do
				@normal_node.follow!(@leader_node)
			end

			it "returns true if the node has a followee_name equal to this name" do
				@normal_node.has_followee?(@leader_node).should be_true
			end

			it "returns true if the node has a followee_name equal to the name of this node" do
				@normal_node.has_followee?(@leader_node).should be_true
			end

			it "returns false otherwise" do
				@bad_node = Node.new('Bad')
				@normal_node.has_followee?(@bad_node).should be_false
			end
		end

		describe "#has_followers?" do
			before :each do
				@normal_node.follow!(@leader_node)
			end

			it "returns true if the node has any followers" do
				@leader_node.has_followers?.should be_true
			end

			it "returns false otherwise" do
				@normal_node.unfollow!(@leader_node)
				@leader_node.has_followers?.should be_false
			end
		end

		describe "#has_follower?" do
			before :each do
				@normal_node.follow!(@leader_node)
			end

			it "returns true if the node has a follower_name equal to this name" do
				@leader_node.has_follower?(@normal_node).should be_true
			end

			it "returns true if the node has a follower_name equal to the name of this node" do
				@leader_node.has_follower?(@normal_node).should be_true
			end

			it "returns false otherwise" do
				@bad_node = Node.new('Bad')
				@leader_node.has_follower?(@bad_node).should be_false
			end
		end
	end
end