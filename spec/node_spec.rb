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

	context "managing followees" do

		describe "#add_followee!" do
			it "adds the followee_name to the followee_names" do
				@normal_node.add_followee!(@leader_node.name)
				@normal_node.followee_names.should eql [@leader_node.name]
			end

			it "adds the name of the node to the followee_names, if provided a node" do
				@normal_node.add_followee!(@leader_node)
				@normal_node.followee_names.should eql [@leader_node.name]
			end
		end

		describe "#remove_followee!" do
			before :each do
				@normal_node.add_followee!(@leader_node)
			end

			it "removes the name of the followee from the followee_names, if passed a name" do
				@normal_node.followee_names.should eql [@leader_node.name]
				@normal_node.remove_followee!(@leader_node.name)
				@normal_node.followee_names.should be_empty
			end

			it "removes the name of the follower from the follower_names, if passed a node" do
				@normal_node.followee_names.should eql [@leader_node.name]
				@normal_node.remove_followee!(@leader_node)
				@normal_node.followee_names.should be_empty
			end

			it "does nothing, if passed a name that's not a follower" do
				@normal_node.followee_names.should eql [@leader_node.name]
				@normal_node.remove_followee!('Bad')
				@normal_node.followee_names.should eql [@leader_node.name]
			end
		end

		describe "#has_followees?" do
			before :each do
				@normal_node.add_followee!(@leader_node.name)
			end

			it "returns true if the node has any followees" do
				@normal_node.has_followees?.should be_true
			end

			it "returns false otherwise" do
				@normal_node.remove_followee!(@leader_node.name)
				@normal_node.has_followees?.should be_false
			end
		end

		describe "#has_followee?" do
			before :each do
				@normal_node.add_followee!(@leader_node.name)
			end

			it "returns true if the node has a followee_name equal to this name" do
				@normal_node.has_followee?(@leader_node.name).should be_true
			end

			it "returns true if the node has a followee_name equal to the name of this node" do
				@normal_node.has_followee?(@leader_node).should be_true
			end

			it "returns false otherwise" do
				@normal_node.has_followee?('Bad').should be_false
			end
		end
	end

	context "managing followers" do

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

		describe "#has_followers?" do
			before :each do
				@leader_node.add_follower!(@normal_node.name)
			end

			it "returns true if the node has any followers" do
				@leader_node.has_followers?.should be_true
			end

			it "returns false otherwise" do
				@leader_node.remove_follower!(@normal_node.name)
				@leader_node.has_followers?.should be_false
			end
		end

		describe "#has_follower?" do
			before :each do
				@leader_node.add_follower!(@normal_node.name)
			end

			it "returns true if the node has a follower_name equal to this name" do
				@leader_node.has_follower?(@normal_node.name).should be_true
			end

			it "returns true if the node has a follower_name equal to the name of this node" do
				@leader_node.has_follower?(@normal_node).should be_true
			end

			it "returns false otherwise" do
				@leader_node.has_follower?('Bad').should be_false
			end
		end
	end
end