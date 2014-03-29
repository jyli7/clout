require 'spec_helper'

describe Node do
	before :each do
		@normal_node = Node.new('Bob')
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

	context "managing immediate relationships" do

		before :each do
			@leader_node = Node.new('Boss')
		end

		describe "#follow!" do
			it "sets the followee_name to the name provided" do
				@normal_node.follow!(@leader_node.name)
				@normal_node.followee_name.should eql @leader_node.name
			end

			it "sets the followee_name to the name of the node provided, if provided a node" do
				@normal_node.follow!(@leader_node)
				@normal_node.followee_name.should eql @leader_node.name
			end
		end

		describe "#unfollow!" do

			before :each do
				@normal_node.follow!(@leader_node)
			end

			it "sets the followee_name to nil, if passed the name of the followee" do
				@normal_node.unfollow!(@leader_node.name)
				@normal_node.followee_name.should be_nil
			end

			it "sets the followee_name to nil, if passed the node of the followee" do
				@normal_node.unfollow!(@leader_node)
				@normal_node.followee_name.should be_nil
			end

			it "does nothing, if passed anything BUT the name or node of the followee" do
				@normal_node.unfollow!('Bad Name')
				@normal_node.followee_name.should eql @leader_node.name

				@normal_node.unfollow!(Node.new('Bad Name'))
				@normal_node.followee_name.should eql @leader_node.name
			end
		end

		describe "#add_follower!" do
			it "adds the name of the follower to follower_names, if passed a name" do
				@leader_node.add_follower!(@normal_node.name)
				@leader_node.follower_names.should eql [@normal_node.name]
			end

			it "adds the name of the follower to follower_names, if passed a node" do
				@leader_node.add_follower!(@normal_node)
				@leader_node.follower_names.should eql [@normal_node.name]
			end
		end

		describe "#remove_follower!" do
			before :each do
				@leader_node.add_follower!(@normal_node.name)
			end

			it "removes the name of the follower from the follower_names, if passed a name" do
				@leader_node.follower_names.should eql [@normal_node.name]
				@leader_node.remove_follower!(@normal_node.name)
				@leader_node.follower_names.should be_empty
			end

			it "removes the name of the follower from the follower_names, if passed a node" do
				@leader_node.follower_names.should eql [@normal_node.name]
				@leader_node.remove_follower!(@normal_node)
				@leader_node.follower_names.should be_empty
			end

			it "does nothing, if passed a name that's not a follower" do
				@leader_node.follower_names.should eql [@normal_node.name]
				@leader_node.remove_follower!('Bad')
				@leader_node.follower_names.should eql [@normal_node.name]
			end
		end
	end


end