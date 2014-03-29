require 'spec_helper'

describe Graph do
	before :each do
		@graph = Graph.new
	end

	describe "#new" do
		it "takes in no parameters and returns a Graph instance" do
			@graph.should be_instance_of Graph
		end
	end

	context "managing single nodes" do

		describe "#add_node_by_name!" do
			it "adds the node_name and node to the nodes array" do
				@graph.add_node_by_name!('Bob')
				@graph.nodes['Bob'].should be_instance_of Node
				@graph.nodes['Bob'].name.should eql 'Bob'
			end

			it "raises an exception if the node already exists" do
				@graph.add_node_by_name!('Bob')
				expect { @graph.add_node_by_name!('Bob') }.to raise_error
				expect { @graph.add_node_by_name!('Frank') }.to_not raise_error
			end
		end

		describe "#find_node_by_name" do
			it "returns the node, if it exists in the graph" do
				@graph.add_node_by_name!('Bob')
				@graph.find_node_by_name('Bob').should be_instance_of Node
				@graph.find_node_by_name('Bob').name.should eql 'Bob'
			end

			it "returns nil, if it doesn't exist" do
				@graph.add_node_by_name!('Bob')
				@graph.find_node_by_name('Frank').should be_nil
			end
		end

		describe "#find_or_add_node_by_name" do
			it "returns the node, if it already exists" do
				@graph.add_node_by_name!('Bob')
				@graph.find_or_add_node_by_name('Bob').should be_instance_of Node
				@graph.find_or_add_node_by_name('Bob').name.should eql 'Bob'
			end

			it "adds and returns the node, even it it didn't exist" do
				@graph.find_or_add_node_by_name('Bob').should be_instance_of Node
				@graph.find_or_add_node_by_name('Bob').name.should eql 'Bob'
			end
		end
	end

	context "managing node relationships" do
		describe "#establish_relationship!" do
			context "if the nodes are new" do
				it "adds the follower to the followee" do
					@graph.establish_relationship!({followee_name: 'followee', follower_name: 'follower'})
					@graph.find_node_by_name('followee').has_follower?('follower').should be_true
				end

				it "adds the followee to the follower" do
					@graph.establish_relationship!({followee_name: 'followee', follower_name: 'follower'})
					@graph.find_node_by_name('follower').has_followee?('followee').should be_true
				end
			end

			context "if the nodes already exist in the graph" do
				before :each do
					@graph.add_node_by_name!('followee')
					@graph.add_node_by_name!('follower')
				end

				it "adds the follower to the followee" do
					@graph.establish_relationship!({followee_name: 'followee', follower_name: 'follower'})
					@graph.find_node_by_name('followee').has_follower?('follower').should be_true
					@graph.nodes.keys.length.should eql 2
				end

				it "adds the followee to the follower" do
					@graph.establish_relationship!({followee_name: 'followee', follower_name: 'follower'})
					@graph.find_node_by_name('follower').has_followee?('followee').should be_true
					@graph.nodes.keys.length.should eql 2
				end
			end

			context "if the follower has a pre-existing followee" do
				it "swaps the old followee for the new followee, on the follower" do
					@graph.establish_relationship!({followee_name: 'old_followee', follower_name: 'follower'})
				end
			end

		end

		describe "#destroy_relationship" do
			it "raises an exception, if the follower does not exist in the graph" do
				@graph.add_node_by_name!('followee')
				expect { @graph.destroy_relationship({follower_name: 'follower',
																							followee_name: 'followee'}) }.to raise_error
			end

			it "raises an exception, if the followee does not exist in the graph" do
				@graph.add_node_by_name!('follower')
				expect { @graph.destroy_relationship({follower_name: 'follower',
																							followee_name: 'followee'}) }.to raise_error
			end

			it "removes the follower from the followee" do
				@graph.establish_relationship!({followee_name: 'followee', follower_name: 'follower'})
				@graph.find_node_by_name('followee').has_follower?('follower').should be_true
				@graph.destroy_relationship!({followee_name: 'followee', follower_name: 'follower'})
				@graph.find_node_by_name('followee').has_follower?('follower').should be_false
			end

			it "removes the followee from the follower" do
				@graph.establish_relationship!({followee_name: 'followee', follower_name: 'follower'})
				@graph.find_node_by_name('follower').has_followee?('followee').should be_true
				@graph.destroy_relationship!({followee_name: 'followee', follower_name: 'follower'})
				@graph.find_node_by_name('follower').has_followee?('followee').should be_false
			end
		end
	end
end